class Contact {
  final String nom;
  final String email;
  final String objet;
  final String message;
  final DateTime date;

  Contact({
    required this.nom,
    required this.email,
    required this.objet,
    required this.message,
    required this.date,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      nom: map["nom"],
      email: map["email"],
      objet: map["objet"],
      message: map["message"],
      date: map["date"].toDate(),
    );
  }
}