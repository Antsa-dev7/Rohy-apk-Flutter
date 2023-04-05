class KeyValueObject {

  String id;
  String name;

  KeyValueObject({ required this.id, required this.name });

  bool operator ==(o) => o is KeyValueObject && name == o.name;
  int get hashCode => name.hashCode;

}

class Category extends KeyValueObject {

  int countOffers = 0;
  int countEnterprises = 0;

  Category({ required String name, required this.countOffers, required this.countEnterprises }) : super(id: name, name: name);

  static Category fromJson(Map<String, dynamic> json) => Category(
      name: json.containsKey("nom") ? json["nom"] : json.containsKey("name") ? json["name"] : "",
      countOffers: json.containsKey("countOffers") ? json["countOffers"] : 0,
      countEnterprises: json.containsKey("countEnterprises") ? json["countEnterprises"]: 0
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'countOffers': countOffers,
    'countEnterprises': countEnterprises
  };
}

enum CategoryType {

  Offers("Offers"),
  Enterprises("Enterprises");

  const CategoryType(this.value);
  final String value;
}