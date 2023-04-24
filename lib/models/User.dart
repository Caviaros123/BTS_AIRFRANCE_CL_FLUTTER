


class User {

  final id;
  final name;
  final firstname;
  final role;
  final email;

  User({this.id, this.name, this.firstname, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nom'],
      firstname: json['prenom'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': name,
    'prenom': firstname,
    'email': email,
    'role': role,
  };

}