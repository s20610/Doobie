import 'package:cloud_firestore/cloud_firestore.dart';

class WeedStrain {
  final int id;
  final String strain;
  final String thc;
  final String cbd;
  final String cbg;
  final String strainType;
  final String climate;
  final String difficulty;
  final int indoorYieldInGramsMax;
  final int outdoorYieldInGramsMax;
  final double floweringWeeksMin;
  final double floweringWeeksMax;
  final double heightInInchesMin;
  final double heightInInchesMax;
  final String goodEffects;
  final String sideEffects;
  final String imgThumb;

  const WeedStrain({
    required this.id,
    required this.strain,
    required this.thc,
    required this.cbd,
    required this.cbg,
    required this.strainType,
    required this.climate,
    required this.difficulty,
    required this.indoorYieldInGramsMax,
    required this.outdoorYieldInGramsMax,
    required this.floweringWeeksMin,
    required this.floweringWeeksMax,
    required this.heightInInchesMin,
    required this.heightInInchesMax,
    required this.goodEffects,
    required this.sideEffects,
    required this.imgThumb,
  });

  WeedStrain.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.data()['id'],
        strain = snapshot.data()['strain'],
        thc = snapshot.data()['thc'] ?? "Unknown",
        cbd = snapshot.data()['cbd'] ?? "Unknown",
        cbg = snapshot.data()['cbg'] ?? "Unknown",
        strainType = snapshot.data()['strainType'] ?? "Unknown",
        climate = snapshot.data()['climate'] ?? "Unknown",
        difficulty = snapshot.data()['difficulty'] ?? "Unknown",
        indoorYieldInGramsMax = snapshot.data()['indoorYieldInGramsMax'] ?? 0,
        outdoorYieldInGramsMax = snapshot.data()['outdoorYieldInGramsMax'] ?? 0,
        floweringWeeksMin = snapshot.data()['floweringWeeksMin'] ?? 0,
        floweringWeeksMax = snapshot.data()['floweringWeeksMax'] ?? 0,
        heightInInchesMin = snapshot.data()['heightInInchesMin'] ?? 0,
        heightInInchesMax = snapshot.data()['heightInInchesMax'] ?? 0,
        goodEffects = snapshot.data()['goodEffects'] ?? "Unknown",
        sideEffects = snapshot.data()['sideEffects'] ?? "Unknown",
        imgThumb = snapshot.data()['imgThumb'] ?? "Unknown";
}
