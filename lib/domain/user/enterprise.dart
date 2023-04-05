import 'package:rohy/domain/category.dart';

class EntepriseVote {
  String? id;
  double? vote;
  Map? rohyUser;
  String? enterpriseId;

  EntepriseVote({
    this.id,
    this.vote,
    this.rohyUser,
    this.enterpriseId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vote': vote,
      'rohyUser': rohyUser,
      'enterpriseId': enterpriseId
    };
  }

  factory EntepriseVote.fromMap(map) {
    return EntepriseVote(
      id: map['id'] != null ? map['id'] as String : null,
      vote: map['vote'] != null ? map['vote'] as double : null,
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      enterpriseId: map['enterpriseId'] != null ? map['enterpriseId'] as String : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'vote': vote,
        'rohyUser': rohyUser,
        'enterpriseId': enterpriseId

      };

  static EntepriseVote fromJson(Map<String, dynamic> json) => EntepriseVote(
      id: json["id"],
      vote: json["vote"],
      enterpriseId: json["enterpriseId"]);
}

class Enterprise extends KeyValueObject {

  String logoUrl;
  String description;
  String category;
  String openingHour;
  String endingHour;
  String address;
  String facebookUrl;
  String instagramUrl;
  String linkedInUrl;
  String twitterUrl;
  String uid;
  String? num_siret;
  List<Map>? votes;

  Enterprise({
    required id,
    required name,
    required this.description,
    required this.logoUrl,
    required this.category,
    required this.openingHour,
    required this.endingHour,
    required this.address,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.linkedInUrl,
    required this.twitterUrl,
    required this.uid,
    this.num_siret,
    this.votes
  }) : super(id: id, name: name);

  static Enterprise initEnterprise({String? name = "", })
  {
    return Enterprise(description: "", name: name, logoUrl: "", category: "", openingHour: "", endingHour: "", address: "", facebookUrl: "", instagramUrl:
    "", linkedInUrl: "", twitterUrl: "", id: "", uid: "", num_siret: "");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "logoUrl": logoUrl,
      "category": category,
      "description": description,
      "openingHour": openingHour,
      "endingHour": endingHour,
      "address": address,
      "facebookUrl": facebookUrl,
      "instagramUrl": instagramUrl,
      "linkedInUrl": linkedInUrl,
      "twitterUrl": twitterUrl,
      "id": id,
      "uid": uid,
      "num_siret" : num_siret,
      'votes': votes
    };
  }

  factory Enterprise.fromMap(map) {
    return Enterprise(
      name: map['name'] != null
          ? map['name'] as String
          : "",
      logoUrl: map['logoUrl'] != null ? map['logoUrl'] as String : "",
      description:
      map['description'] != null ? map['description'] as String : "",
      category: map['category'] != null ? map['category'] as String : "",
      openingHour:
      map['openingHour'] != null ? map['openingHour'] as String : "",
      endingHour:
      map['endingHour'] != null ? map['endingHour'] as String : "",
      address: map['address'] != null
          ? map['address'] as String
          : "",
      facebookUrl:
      map['facebookUrl'] != null ? map['facebookUrl'] as String : "",
      instagramUrl:
      map['instagramUrl'] != null ? map['instagramUrl'] as String : "",
      linkedInUrl:
      map['linkedInUrl'] != null ? map['linkedInUrl'] as String : "",
      twitterUrl:
      map['twitterUrl'] != null ? map['twitterUrl'] as String : "",
      id: map['id'] != null
          ? map['id'] as String
          : "",
      uid: map['uid'] != null
          ? map['uid'] as String
          : "",
      num_siret: map['num_siret'] != null
          ? map['num_siret'] as String
          : "",
      votes:
      map['votes'] != null ? map['votes'] as List<Map> : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'logoUrl': logoUrl,
    'category': category,
    'openingHour': openingHour,
    'endingHour': endingHour,
    'address': address,
    'facebookUrl': facebookUrl,
    'instagramUrl': instagramUrl,
    'linkedInUrl': linkedInUrl,
    'twitterUrl': twitterUrl,
    'id': id,
    'uid': uid,
    'num_siret' : num_siret
  };

  static Enterprise fromJson(Map<String, dynamic> json) =>
      Enterprise(
        name: json["name"],
        description: json["description"],
        logoUrl: json["logoUrl"],
        category: json["category"],
        openingHour: json["openingHour"],
        endingHour: json["endingHour"],
        address: json["address"],
        facebookUrl: json["facebookUrl"],
        instagramUrl: json["instagramUrl"],
        linkedInUrl: json["linkedInUrl"],
        twitterUrl: json["twitterUrl"],
        id: json["id"],
        uid: json["uid"],
        votes: json["votes"],
        num_siret: json["num_siret"],
      );
}