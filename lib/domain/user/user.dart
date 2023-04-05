import 'dart:convert';

import 'package:rohy/domain/user/enterprise.dart';
import 'package:rohy/domain/post/post.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RohyUser {

  String? email;
  String? prenom;
  String? nom;
  String? uid;
  String? type;
  String? phone;
  String? address;
  String? status;
  String? photoURL;
  List<EntepriseVote>? enterpriseVotes;
  List<PostVote>? postVotes;
  List<ReactionPost>? postReactions;

  RohyUser(
      {this.email,
        this.prenom,
        this.nom,
        this.uid,
        this.type,
        this.phone,
        this.address,
        this.status,
        this.photoURL,
        this.enterpriseVotes,
        this.postVotes,
        this.postReactions
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'prenom': prenom,
      'nom': nom,
      'uid': uid,
      'type': type,
      'phone': phone,
      'address': address,
      'status': status,
      'photoURL': photoURL,
    };
  }

  factory RohyUser.fromMap(map) {
    return RohyUser(
      email: map['email'] != null ? map['email'] as String : null,
      prenom: map['prenom'] != null ? map['prenom'] as String : null,
      nom: map['nom'] != null ? map['nom'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      photoURL: map['photoURL'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  static RohyUser fromJson(Map<String, dynamic> json) => RohyUser(
      email: json["email"],
      prenom: json["prenom"],
      nom: json["nom"],
      uid: json["uid"],
      type: json["type"],
      phone: json["phone"],
      address: json["address"],
      status: json["status"],
      photoURL: json["photoURL"]
  );


}