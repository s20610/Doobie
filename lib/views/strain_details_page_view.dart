import 'package:doobie/DTO/weed_strain.dart';
import 'package:flutter/material.dart';

class StrainDetailsPage extends StatefulWidget {
  final WeedStrain strainDetails;

  const StrainDetailsPage({Key? key, required this.strainDetails})
      : super(key: key);

  @override
  StrainDetailsPageState createState() => StrainDetailsPageState();
}

class StrainDetailsPageState extends State<StrainDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strainDetails.strain),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildImage(),
            const SizedBox(height: 20),
            _buildStats(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.strainDetails.imgThumb),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatItem('Type', widget.strainDetails.strainType),
          _buildStatItem('THC', widget.strainDetails.thc),
          _buildStatItem('CBD', widget.strainDetails.cbd),
          _buildStatItem('CBG', widget.strainDetails.cbg),
          _buildStatItem('Difficulty', widget.strainDetails.difficulty),
          _buildStatItem('Climate', widget.strainDetails.climate),
          _buildStatItem('Indoor Yield', '${widget.strainDetails.indoorYieldInGramsMax}g'),
          _buildStatItem('Outdoor Yield', '${widget.strainDetails.outdoorYieldInGramsMax}g'),
          _buildStatItem('Flowering Weeks', '${widget.strainDetails.floweringWeeksMin}-${widget.strainDetails.floweringWeeksMax}'),
          _buildStatItem('Height', '${widget.strainDetails.heightInInchesMin}-${widget.strainDetails.heightInInchesMax} inches'),
          _buildStatItem('Good Effects', widget.strainDetails.goodEffects),
          _buildStatItem('Side Effects', widget.strainDetails.sideEffects),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
