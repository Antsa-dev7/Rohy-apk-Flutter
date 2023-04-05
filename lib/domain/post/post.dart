class PostVote {
  String? id;
  double vote = 0;
  Map? rohyUser;
  String? postId;

  PostVote({
    this.id,
    required this.vote,
    this.rohyUser,
    this.postId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vote': vote,
      'rohyUser': rohyUser,
      'postId': postId,
    };
  }

  factory PostVote.fromMap(map) {
    return PostVote(
      id: map['id'] != null ? map['id'] as String : null,
      vote: map['vote'] != null ? map['vote'] as double : 0,
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      postId: map['postId'] != null ? map['postId'] as String: null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'vote': vote,
        'rohyUser': rohyUser,
        'postId': postId,
      };

  static PostVote fromJson(Map<String, dynamic> json) => PostVote(
      id: json["id"],
      vote: json["vote"],
      postId: json["postId"]);
}

class ReactionPost{
  String? id;
  String? type;
  Map? rohyUser;
  String? postId;

  ReactionPost({
    this.id,
    this.type,
    this.rohyUser,
    this.postId
  });
  factory ReactionPost.fromMap(map) {
    return ReactionPost(
      id: map['id'] != null ? map['id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      rohyUser: map['rohyUser'] != null ? map['rohyUser'] as Map: null,
      postId: map['postId'] != null ? map['postId'] as String: null,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'rohyUser': rohyUser,
      'postId': postId,
    };
  }
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'type': type,
        'rohyUser': rohyUser,
        'postId': postId,
      };
  static ReactionPost fromJson(Map<String, dynamic> json) => ReactionPost(
      id: json["id"],
      type: json["type"],
      postId: json["postId"]);

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
  Map<String, int>? reaction;
  int? reactions;


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
    this.reaction,
    this.reactions,
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
      'reaction' : reaction,
      'reactions': reactions
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
      reaction: map['reaction'] != null ? map['reaction'] as  Map<String, int> : null,
      reactions: map['reactions'] != null ? map['reactions'] as int: 0,
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
    'reaction' : reaction,
    'reactions': reactions
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
        reaction: json["reaction"],
        reactions: json["reactions"]
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