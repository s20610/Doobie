import 'package:doobie/DTO/weed_strain.dart';
import 'package:flutter/material.dart';

class WeedStrainDetails extends StatefulWidget {
  final WeedStrain weedStrain;

  const WeedStrainDetails({required this.weedStrain});

  @override
  State<WeedStrainDetails> createState() => _WeedStrainDetailsState();
}

class _WeedStrainDetailsState extends State<WeedStrainDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.weedStrain.strain),
      ),
      body: Center(
        child: Text(widget.weedStrain.strainType),
      ),);
  }
}
