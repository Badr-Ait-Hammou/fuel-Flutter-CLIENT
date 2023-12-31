class UserModel {
  final int id;
  final String prenom;
  final String nom;
  final String email;

  UserModel({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      prenom: json['prenom'],
      nom: json['nom'],
      email: json['email'],
    );
  }
}
