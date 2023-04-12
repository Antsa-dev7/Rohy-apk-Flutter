import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:rohy/domain/category.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/user/user.dart';
import 'package:rohy/infrastructure/repositories/transformer.dart';

import '../../ui/screens/toast.dart';
import '../iam/sign_mail.dart';
import '../iam/update_password.dart';


class DirectoryRepository {

  static Future<DocumentSnapshot<Object?>> readUser(uid) {
    return FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<RohyUser> readRohyUser(uid) async {
    final ref =
    _firestore
        .collection("users")
        .doc(uid)
        .get();

    final docSnap = await ref;
    if (docSnap.data() == null) return RohyUser();
    return RohyUser.fromJson(docSnap.data()!);
  }

  static void updateUser(
      RohyUser rohyUser, String password, bool isSocialLogin) {
    if (!isSocialLogin) {
      FirebaseAuthMethods.updatePassword(password: password);
    }
    // Update a user
    User user = FirebaseAuth.instance.currentUser!;
    Logger _logger = Logger();
    _logger.i(rohyUser.phone);
    rohyUser.photoURL = user.photoURL;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(rohyUser.toMap())
        .then(
          (value) {
        return true;
      },
    ).catchError((e) {
      print(e);
    });
    showToast("Votre compte a été mis à jour !");
  }


  Stream<List<Enterprise>> findAllEnterprisesByUser(String uid) =>
      _firestore
          .collection("suppliersEntreprisesInfo")
          .where("uid", isEqualTo: uid)
          .snapshots()
          .transform(Utils.transformer(Enterprise.fromJson));

  Stream<List<Enterprise>> findAllEnterprises() =>
      _firestore
          .collection("suppliersEntreprisesInfo")
          .snapshots()
          .transform(Utils.transformer(Enterprise.fromJson));

  void createOrUpdateEnterprise(Enterprise enterprise) async {
    _firestore.runTransaction((transaction) async {
      var docEnterprise = null;
      if (enterprise.id != null && enterprise.id != "" ) {
        docEnterprise = FirebaseFirestore.instance
            .collection("suppliersEntreprisesInfo")
            .doc(enterprise.id);
      }
      else {
        docEnterprise = _firestore
            .collection("suppliersEntreprisesInfo")
            .doc();
      }
      enterprise.id = docEnterprise.id;
      await docEnterprise.set(enterprise.toJson());

      // Get the category object
      final categoriesSnapshot = await _firestore
          .collection("categories")
          .limit(1)
          .where("name", isEqualTo: enterprise.category)
          .get();
      // Update the category
      final categoryModel =
          Category.fromJson(categoriesSnapshot.docs[0].data());
      categoryModel.countEnterprises += 1;
      _firestore
          .collection("categories")
          .doc(categoriesSnapshot.docs[0].id)
          .update(categoryModel.toJson());
    }).then((value) => print("Transaction OK"),
        onError: (e) => print("Transaction KO: $e"));
  }

  Future deleteEnterprise(String id) async {
    final enterprise = _firestore
        .collection("suppliersEntreprisesInfo")
        .doc(id);

    await enterprise.delete();
  }

  //Votes
  void addOrUpdateEnterpriseVote(RohyUser user, String enterpriseId, double vote) async {
    DocumentReference _enterpriseReference = _firestore.collection(
        "suppliersEntreprisesInfo").doc(enterpriseId);
    CollectionReference _voteReference = _enterpriseReference.collection("votes");
    QuerySnapshot voteSnapshot = await _voteReference.where(
        "rohyUser.uid", isEqualTo: user.uid).get();
    final voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
    var doc = _voteReference.doc();
    if (!voteData.isEmpty) {
      // doc = _voteReference.doc((Vote.fromJson(voteData[0] as Map<String, dynamic>);
      doc = _voteReference.doc(EntepriseVote
          .fromMap(voteData[0] as Map)
          .id);
    }
    EntepriseVote _vote = EntepriseVote();
    _vote.id = doc.id;
    _vote.vote = vote;
    _vote.rohyUser = user.toMap();
    await doc.set(_vote.toJson());
  }

  void addOrUpdateUserEnterpriseVote(RohyUser user, String enterpriseId, double vote) async {
    if (user.uid != null) {
      DocumentReference _userReference = _firestore.collection(
          "users").doc(user.uid);
      CollectionReference _voteReference = _userReference.collection(
          "votesEnterprise");
      QuerySnapshot voteSnapshot = await _voteReference.where(
          "enterpriseId", isEqualTo: enterpriseId).get();
      final voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
      var doc = _voteReference.doc();
      if (!voteData.isEmpty) {
        doc = _voteReference.doc(EntepriseVote
            .fromMap(voteData[0] as Map)
            .id);
      }
      EntepriseVote _vote = EntepriseVote();
      _vote.id = doc.id;
      _vote.vote = vote;
      // _vote.rohyUser = user.toMap();
      _vote.enterpriseId = enterpriseId;
      await doc.set(_vote.toJson());
    }
  }

  Future<List<EntepriseVote>> readRohyUserEnterpriseVotes(uid) async {
    var votes = await _firestore
        .collection("users")
        .doc(uid)
        .collection("votesEnterprise").snapshots().transform(Utils.transformer(EntepriseVote.fromJson));
     return votes.first;
  }

  Future<List<PostVote>> readRohyUserPostVotes(uid) async {
    var votes = await _firestore
        .collection("users")
        .doc(uid)
        .collection("votesPost").snapshots().transform(Utils.transformer(PostVote.fromJson));
    return votes.first;
  }

  //Reaction
  Future<List<ReactionPost>> readRohyUserPostReactions(uid) async {
    var reactions = await _firestore
        .collection("users")
        .doc(uid)
        .collection("reactionsPost").snapshots().transform(Utils.transformer(ReactionPost.fromJson));
    return reactions.first;
  }


  // save User to Firestore
  Future<RohyUser> saveSocialUser(
      {
        required User googleUser,
        required String type,
        required String? status}) async {

      RohyUser user = await readRohyUser(googleUser.uid);

      user.email = googleUser.email;
      user.prenom = googleUser.displayName?.split(' ')[0];
      user.nom = googleUser.displayName?.split(' ')[1];
      user.uid = googleUser.uid;
      user.type = type;
      user.status = status;
      user.photoURL = googleUser.photoURL;

      /// create a new user in firebase firestore
      await _firestore
          .collection("users")
          .doc(googleUser.uid)
          .set(user.toMap());

      return user;
  }

  Future<void> addOrUpdateUserPostReaction(RohyUser user, String postId, String type) async {
    RohyUser rohyUser = await readRohyUser(user.uid);
    if (rohyUser.postReactions == null)
      rohyUser.postReactions = {};
    rohyUser.postReactions![postId] = type;
    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(rohyUser.toMap());
  }

  Future<void> addOrUpdateUserPostVote(RohyUser user, String postId, double vote) async {
    RohyUser rohyUser = await readRohyUser(user.uid);
    if (rohyUser.postVotes == null)
      rohyUser.postVotes = {};
    rohyUser.postVotes![postId] = vote;
    await _firestore
        .collection("users")
        .doc(user.uid)
        .set(rohyUser.toMap());
  }
}
