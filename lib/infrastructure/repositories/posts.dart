import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rohy/domain/post/post.dart';
import 'package:rohy/domain/category.dart';
import 'package:rohy/infrastructure/repositories/transformer.dart';
import 'package:rohy/domain/user/user.dart';

class PostRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = "post";

  Future<void> updatePostVotant(String postId, int votants, double averageVote) async {
    final ref =_firestore
        .collection(_collectionName)
        .doc(postId)
        .get();

    final docSnap = await ref;
    var post = Post.fromJson(docSnap.data()!);
    post.votants = votants;
    post.averageVotes = averageVote;
    DocumentReference postReference = FirebaseFirestore.instance.collection(
        _collectionName).doc(postId);
    postReference.set(post.toMap());
  }

  Future<void> updatePostReaction(String postId, int reactions, Map<String?, int> reactionDetails) async {
    final ref = _firestore
        .collection(_collectionName)
        .doc(postId)
        .get();
    final docSnap = await ref;
    var post = Post.fromJson(docSnap.data()!);
    post.countReactions = reactions;
    post.reactionDetails = reactionDetails;
    DocumentReference postReference = _firestore.collection(
        _collectionName).doc(postId);
    postReference.set(post.toMap());
  }

  Stream<List<Post>> findAll() {
    var posts = _firestore
        .collection(_collectionName)
        .snapshots()
        .transform(Utils.transformer(Post.fromJson));
    return posts;
  }

  Future<List<Post>> loadAllPosts() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(_collectionName).get();
    List<Post> posts = [];
    for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
      Post post = Post.fromMap(snapshot.data());
      posts.add(post);
    }
    return posts;
  }

  void post(Post post) async {
    _firestore.runTransaction((transaction) async {
      final doc = _firestore.collection(_collectionName).doc(post.id);
      post.id = doc.id;

      post.datetimeTypeDebut = DateTime.now().toString();
      post.datetimeTypeEnd =
          DateTime.now().add(const Duration(days: 30)).toString();

      await doc.set(post.toJson());
      // Get the category object
      final categoriesSnapshot = await _firestore.collection(
          "categories").limit(1).where("name", isEqualTo: post.category).get();
      // Update the category
      final categoryModel = Category.fromJson(
          categoriesSnapshot.docs[0].data());
      categoryModel.countOffers += 1;
      FirebaseFirestore.instance.collection("categories").doc(
          categoriesSnapshot.docs[0].id).update(categoryModel.toJson());
    }
    ).then(
            (value) => print("Transaction OK"),
        onError: (e) => print("Transaction KO: $e"));
  }

  addOrUpdateVote(RohyUser user, String postId, double vote) async {
    DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    CollectionReference voteReference = _postReference.collection("votes");
    QuerySnapshot voteSnapshot = await voteReference.where(
        "rohyUser.uid", isEqualTo: user.uid).get();
    var voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
    var doc = voteReference.doc();
    if (voteData.isNotEmpty) {
      // doc = _voteReference.doc((Vote.fromJson(voteData[0] as Map<String, dynamic>);
      doc = voteReference.doc(PostVote
          .fromMap(voteData[0] as Map)
          .id);
    }
    PostVote _vote = PostVote(vote: 0);
    _vote.id = doc.id;
    _vote.vote = vote;
    _vote.rohyUser = user.toMap();
    await doc.set(_vote.toJson());
  }

  Future<List<PostVote>> loadVotes(String postId) async {
     DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    final voteReference = _postReference.collection("votes");
    QuerySnapshot voteSnapshot = await voteReference.where(
        "vote", isGreaterThan: 0).get();
    var voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
    List<PostVote> toRet = List.empty(growable: true);
    voteData.forEach((element) =>
        toRet.add(PostVote.fromMap(element as Map)));
    return toRet;
  }

  Future<void> addOrUpdateUserPostVote(RohyUser user, String postId, double vote) async {
    if (user.uid != null) {
      DocumentReference _userReference = _firestore.collection(
          "users").doc(user.uid);
      CollectionReference _voteReference = _userReference.collection(
          "votesPost");
      QuerySnapshot voteSnapshot = await _voteReference.where(
          "postId", isEqualTo: postId).get();
      final voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
      var doc = _voteReference.doc();
      if (voteData.isNotEmpty) {
        doc = _voteReference.doc(PostVote
            .fromMap(voteData[0] as Map)
            .id);
      }
      PostVote _vote = PostVote(vote: 0);
      _vote.id = doc.id;
      _vote.vote = vote;
      _vote.postId = postId;
      await doc.set(_vote.toJson());
    }
  }

  // React on post
  Future<void> addOrUpdatePostReaction(RohyUser user, String postId, String type) async {
    DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    CollectionReference _reactionReference = _postReference.collection("reactions");
    QuerySnapshot reactionSnapshot = await _reactionReference.where(
        "rohyUser.uid", isEqualTo: user.uid).get();
    var reactionData = reactionSnapshot.docs.map((doc) => doc.data()).toList();
    var doc = _reactionReference.doc();
    if (reactionData.isNotEmpty) {
      doc = _reactionReference.doc(ReactionPost
          .fromMap(reactionData[0] as Map)
          .id);
    }
    ReactionPost reaction = ReactionPost();
    reaction.id = doc.id;
    reaction.postId = postId;
    reaction.type = type;
    reaction.rohyUser = user.toMap();
    await doc.set(reaction.toJson());
  }

  Future<List<ReactionPost>> loadReactions(String postId) async {
    DocumentReference postReference = _firestore.collection(
        _collectionName).doc(postId);
    final reactionReference = postReference.collection("reactions");
    QuerySnapshot reactionSnapshot = await reactionReference.get();
    var reactionData = reactionSnapshot.docs.map((doc) => doc.data()).toList();
    List<ReactionPost> toRect = List.empty(growable: true);
    for (var element in reactionData) {
      toRect.add(ReactionPost.fromMap(element as Map));
    }
    return toRect;
  }

  Future deletePost(String id) async {
    final post = _firestore
        .collection(_collectionName)
        .doc(id);

    await post.delete();
  }
}