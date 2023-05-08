
class Airport {

  final idaeroport;
  final nom;
  final pays;

  Airport({this.idaeroport, this.nom, this.pays});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      idaeroport: json['idaeroport'],
      nom: json['nom'],
      pays: json['pays']
    );
  }

  Map<String, dynamic> toJson() => {
    'idaeroport': idaeroport,
    'nom': nom,
    'pays': pays
  };
}