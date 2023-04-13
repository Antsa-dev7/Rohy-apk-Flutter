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
      doc = voteReference.doc(VoteOnObject
          .fromMap(voteData[0] as Map)
          .id);
    }
    VoteOnObject _vote = VoteOnObject(vote: 0);
    _vote.id = doc.id;
    _vote.vote = vote;
    _vote.rohyUser = user.toMap();
    _vote.objectId = postId;
    await doc.set(_vote.toJson());
  }

  Future<List<VoteOnObject>> loadVotes(String postId) async {
     DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    final voteReference = _postReference.collection("votes");
    QuerySnapshot voteSnapshot = await voteReference.where(
        "vote", isGreaterThan: 0).get();
    var voteData = voteSnapshot.docs.map((doc) => doc.data()).toList();
    List<VoteOnObject> toRet = List.empty(growable: true);
    voteData.forEach((element) =>
        toRet.add(VoteOnObject.fromMap(element as Map)));
    return toRet;
  }


  // React on post
  Future<void> addOrUpdateReaction(RohyUser user, String postId, String type) async {
    DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    CollectionReference _reactionReference = _postReference.collection("reactions");
    QuerySnapshot reactionSnapshot = await _reactionReference.where(
        "rohyUser.uid", isEqualTo: user.uid).get();
    var reactionData = reactionSnapshot.docs.map((doc) => doc.data()).toList();
    var doc = _reactionReference.doc();
    if (reactionData.isNotEmpty) {
      doc = _reactionReference.doc(ReactionOnObject
          .fromMap(reactionData[0] as Map)
          .id);
    }
    ReactionOnObject reaction = ReactionOnObject();
    reaction.id = doc.id;
    reaction.objectId = postId;
    reaction.type = type;
    reaction.rohyUser = user.toMap();
    await doc.set(reaction.toJson());
  }

  Future<List<ReactionOnObject>> loadReactions(String postId) async {
    DocumentReference postReference = _firestore.collection(
        _collectionName).doc(postId);
    final reactionReference = postReference.collection("reactions");
    QuerySnapshot reactionSnapshot = await reactionReference.get();
    var reactionData = reactionSnapshot.docs.map((doc) => doc.data()).toList();
    List<ReactionOnObject> toRect = List.empty(growable: true);
    for (var element in reactionData) {
      toRect.add(ReactionOnObject.fromMap(element as Map));
    }
    return toRect;
  }

  Future deletePost(String id) async {
    final post = _firestore
        .collection(_collectionName)
        .doc(id);

    await post.delete();
  }

  Future<List<CommentOnObject>> loadComments(String postId) async {
    DocumentReference postReference = _firestore.collection(
        _collectionName).doc(postId);
    final reactionReference = postReference.collection("comments");
    QuerySnapshot reactionSnapshot = await reactionReference.get();
    var data = reactionSnapshot.docs.map((doc) => doc.data()).toList();
    List<CommentOnObject> toRet = List.empty(growable: true);
    for (var element in data) {
      toRet.add(CommentOnObject.fromMap(element as Map));
    }
    return toRet;
  }

  // React on post
  Future<void> addOrUpdateComment(RohyUser user, String postId, String commentText) async {
    DocumentReference _postReference = _firestore.collection(
        _collectionName).doc(postId);
    CollectionReference _commentReference = _postReference.collection("comments");
    QuerySnapshot commentSnapshot = await _commentReference.where(
        "rohyUser.uid", isEqualTo: user.uid).get();
    var data = commentSnapshot.docs.map((doc) => doc.data()).toList();
    var doc = _commentReference.doc();
    if (data.isNotEmpty) {
      doc = _commentReference.doc(ReactionOnObject
          .fromMap(data[0] as Map)
          .id);
    }
    CommentOnObject comment = CommentOnObject(comment: commentText);
    comment.id = doc.id;
    comment.objectId = postId;
    comment.rohyUser = user.toMap();
    await doc.set(comment.toJson());
  }

  Future<void> removeComment(String postId, String commentId) async {
    final comment = _firestore
        .collection(_collectionName)
        .doc(postId).collection("comments").doc(commentId);
    comment.delete();
  }



  Future<void> updatePostCommentsCount(String postId, int comments) async {
    final ref =_firestore
        .collection(_collectionName)
        .doc(postId)
        .get();

    final docSnap = await ref;
    var post = Post.fromJson(docSnap.data()!);
    post.countComments = comments;
    DocumentReference postReference = FirebaseFirestore.instance.collection(
        _collectionName).doc(postId);
    postReference.set(post.toMap());
  }
}