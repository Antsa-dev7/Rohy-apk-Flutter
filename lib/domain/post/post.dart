
class VoteOnObject {
  String? id;
  double vote = 0;
  Map? rohyUser;
  String? objectId;

  VoteOnObject({
    this.id,
    required this.vote,
    this.rohyUser,
    this.objectId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vote': vote,
      'rohyUser': rohyUser,
      'objectId': objectId,
    };
  }

  factory VoteOnObject.fromMap(map) {
    return VoteOnObject(
      id: map['id'] != null ? map['id'] as String : null,
      vote: map['vote'] != null ? map['vote'] as double : 0,
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      objectId: map['objectId'] != null ? map['objectId'] as String: null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'vote': vote,
        'rohyUser': rohyUser,
        'objectId': objectId,
      };

  static VoteOnObject fromJson(Map<String, dynamic> json) => VoteOnObject(
      id: json["id"],
      vote: json["vote"],
      objectId: json["objectId"]);
}

class ReactionOnObject{
  String? id;
  String? type;
  Map? rohyUser;
  String? objectId;

  ReactionOnObject({
    this.id,
    this.type,
    this.rohyUser,
    this.objectId
  });
  factory ReactionOnObject.fromMap(map) {
    return ReactionOnObject(
      id: map['id'] != null ? map['id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      objectId: map['objectId'] != null ? map['objectId'] as String: null,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'rohyUser': rohyUser,
      'objectId': objectId,
    };
  }
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'type': type,
        'rohyUser': rohyUser,
        'objectId': objectId,
      };
  static ReactionOnObject fromJson(Map<String, dynamic> json) => ReactionOnObject(
      id: json["id"],
      type: json["type"],
      objectId: json["objectId"]);

}

class CommentOnObject {
  String? id;
  String comment = "";
  Map? rohyUser;
  String? objectId;

  CommentOnObject({
    this.id,
    required this.comment,
    this.rohyUser,
    this.objectId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'rohyUser': rohyUser,
      'objectId': objectId,
    };
  }

  factory CommentOnObject.fromMap(map) {
    return CommentOnObject(
      id: map['id'] != null ? map['id'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : "",
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      objectId: map['objectId'] != null ? map['objectId'] as String: null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'comment': comment,
        'rohyUser': rohyUser,
        'objectId': objectId,
      };
}


class Post {

  String id;
  String title;
  String description;
  String? stringTypeDebut;
  String? stringTypeEnd;
  String? datetimeTypeDebut;
  String? datetimeTypeEnd;
  String? price;
  String? image;
  String category;
  String? email;
  String? phone;
  String? address;
  String? facebookLink;
  String? intagramLink;
  String? linkedInLink;
  String? twitterLink;
  String? supplierName;
  String? supplierId;
  Map? rohyUser;
  Map? enterprise;
  List<Map>? votes;
  int? votants;
  double? averageVotes;
  Map? reactionDetails;
  int? countReactions;
  int? countComments;


  Post({
    required this.id,
    required this.title,
    this.stringTypeDebut,
    required this.category,
    this.stringTypeEnd,
    this.datetimeTypeDebut,
    this.datetimeTypeEnd,
    this.price,
    this.image,
    this.phone,
    this.email,
    this.address,
    this.facebookLink,
    this.intagramLink,
    this.linkedInLink,
    this.twitterLink,
    this.supplierName,
    this.supplierId,
    required this.description,
    this.rohyUser,
    this.enterprise,
    this.votes,
    this.votants,
    this.averageVotes,
    this.reactionDetails,
    this.countReactions,
    this.countComments
  });

  static Post initPost({String? id = "", })
  {
    return Post(title: "",category: "",price: "",image: "",enterprise : {},
        description: "",id: "", supplierId: "");
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'stringTypeDebut': stringTypeDebut,
      'stringTypeEnd': stringTypeEnd,
      'category': category,
      'datetimeTypeDebut': datetimeTypeDebut,
      'datetimeTypeEnd': datetimeTypeEnd,
      'price': price,
      'image': image,
      'email': email,
      'phone': phone,
      'facebookLink': facebookLink,
      'intagramLink': intagramLink,
      'address': address,
      'linkedInLink': linkedInLink,
      'twitterLink': twitterLink,
      'supplierName': supplierName,
      'supplierId': supplierId,
      'description': description,
      'rohyUser': rohyUser,
      'enterprise': enterprise,
      'votes': votes,
      'votants': votants,
      'averageVotes': averageVotes,
      'reactionDetails' : reactionDetails,
      'countReactions': countReactions,
      'countComments': countComments,
    };
  }

  factory Post.fromMap(map) {

    return Post(
      id: map['id'] ,
      title: map['title'],
      stringTypeDebut: map['stringTypeDebut'] != null
          ? map['stringTypeDebut'] as String
          : null,
      category: map['category'],
      stringTypeEnd:
      map['stringTypeEnd'] != null ? map['stringTypeEnd'] as String : null,
      datetimeTypeDebut: map['datetimeTypeDebut'] != null
          ? map['datetimeTypeDebut'] as String
          : null,
      datetimeTypeEnd: map['datetimeTypeEnd'] != null
          ? map['datetimeTypeEnd'] as String
          : null,
      price: map['price'] != null ? map['price'] as String : null,
      image:
      map['image'] != null ? map['image'] as String : null,
      twitterLink:
      map['twitterLink'] != null ? map['twitterLink'] as String : null,
      linkedInLink:
      map['linkedInLink'] != null ? map['linkedInLink'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      intagramLink:
      map['intagramLink'] != null ? map['intagramLink'] as String : null,
      facebookLink:
      map['facebookLink'] != null ? map['facebookLink'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      description: map['description'],
      supplierName:
      map['supplierName'] != null ? map['supplierName'] as String : null,
      supplierId:
      map['supplierId'] != null ? map['supplierId'] as String : null,
      rohyUser:
      map['rohyUser'] != null ? map['rohyUser'] as Map : null,
      enterprise:
      map['enterprise'] != null ? map['enterprise'] as Map : null,
      votes:
      map['votes'] != null ? map['votes'] as List<Map> : null,
      votants: map['votants'] != null ? map['votants'] as int: 0,
      averageVotes: map['averageVotes'] != null ? map['averageVotes'] as double: 0,
      reactionDetails: map['reactionDetails'] != null ? map['reactionDetails'] as  Map : {},
      countReactions: map['countReactions'] != null ? map['countReactions'] as int: 0,
      countComments: map['countComments'] != null ? map['countComments'] as int: 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'stringTypeDebut': stringTypeDebut,
    'category': category,
    'stringTypeEnd': stringTypeEnd,
    'datetimeTypeDebut': datetimeTypeDebut,
    'datetimeTypeEnd': datetimeTypeEnd,
    'price': price,
    'image': image,
    'email': email,
    'phone': phone,
    'facebookLink': facebookLink,
    'intagramLink': intagramLink,
    'address': address,
    'twitterLink': twitterLink,
    'linkedInLink': linkedInLink,
    'supplierName': supplierName,
    'supplierId': supplierId,
    'description': description,
    'rohyUser': rohyUser,
    'enterprise': enterprise,
    'votants': votants,
    'averageVotes': averageVotes,
    'reactionDetails' : reactionDetails,
    'countReactions': countReactions,
    'countComments': countComments,
    };

  static Post fromJson(Map<String, dynamic> json) {
    return Post
      (
        id: json["id"],
        title: json["title"],
        stringTypeDebut: json["stringTypeDebut"],
        category: json["category"],
        stringTypeEnd: json["stringTypeEnd"],
        datetimeTypeDebut: json["datetimeTypeDebut"],
        datetimeTypeEnd: json["datetimeTypeEnd"],
        price: json["price"],
        image: json["image"],
        email: json["email"],
        phone: json["phone"],
        facebookLink: json["facebookLink"],
        intagramLink: json["intagramLink"],
        address: json["address"],
        linkedInLink: json["linkedInLink"],
        twitterLink: json["twitterLink"],
        supplierName: json["supplierName"],
        description: json["description"],
        supplierId: json["supplierId"],
        rohyUser: json["rohyUser"],
        enterprise: json["enterprise"],
        votes: json["votes"],
        votants: json["votants"],
        averageVotes: json["averageVotes"],
        reactionDetails: json["reactionDetails"],
        countReactions: json["countReactions"],
        countComments: json["countReactions"],
    );
  }

  String getName() {
    if (enterprise == null) {
      return rohyUser!["prenom"] + " " + rohyUser!["nom"];
    }
    else {
      return enterprise!["name"];
    }
  }

  String getPhotoUrl() {
    if (enterprise == null) {
      return rohyUser!["photoURL"];
    }
    else {
      return enterprise!["logoUrl"];
    }
  }
  getCurrentId(){
    if (enterprise == null) {
      if (rohyUser == null) {
        return supplierId ;
      }
      else {
        return supplierId;
      }
    }
    else {
      return enterprise!["uid"];
    }
  }
}