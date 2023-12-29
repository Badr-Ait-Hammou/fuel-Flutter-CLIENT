class FuelModel {
  final double gasoil;
  final double sansPlomb;
  final double excellium;
  FuelModel(
      {required this.gasoil, required this.sansPlomb, required this.excellium});

  factory FuelModel.fromJson(Map<String, dynamic> json) {
    return FuelModel(
      gasoil: json['Gasoil'],
      sansPlomb: json['SansPlomb'],
      excellium: json['Excellium'],
    );
  }
}
