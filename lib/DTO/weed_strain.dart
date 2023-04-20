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

  WeedStrain({
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

  factory WeedStrain.fromJson(Map<String, dynamic> json) {
    return WeedStrain(
      id: json['id'],
      strain: json['strain'],
      thc: json['thc']??"Unknown",
      cbd: json['cbd']??"Unknown",
      cbg: json['cbg']??"Unknown",
      strainType: json['strainType']??"Unknown",
      climate: json['climate']??"Unknown",
      difficulty: json['difficulty']??"Unknown",
      indoorYieldInGramsMax: json['indoorYieldInGramsMax']??0,
      outdoorYieldInGramsMax: json['outdoorYieldInGramsMax']??0,
      floweringWeeksMin: json['floweringWeeksMin']??0,
      floweringWeeksMax: json['floweringWeeksMax']??0,
      heightInInchesMin: json['heightInInchesMin']??0,
      heightInInchesMax: json['heightInInchesMax']??0,
      goodEffects: json['goodEffects']??"Unknown",
      sideEffects: json['sideEffects']??"Unknown",
      imgThumb: json['imgThumb']??"Unknown",
    );
  }
}
