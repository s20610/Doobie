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
          _buildBasicStatItem(),
          _buildStatItem('CBD', widget.strainDetails.cbd),
          _buildStatItem('CBG', widget.strainDetails.cbg),
          _buildStatItem('Difficulty', widget.strainDetails.difficulty),
          _buildStatItem('Climate', widget.strainDetails.climate),
          _buildStatItem('Indoor Yield', '${widget.strainDetails.indoorYieldInGramsMax}g'),
          _buildStatItem('Outdoor Yield', '${widget.strainDetails.outdoorYieldInGramsMax}g'),
          _buildStatItem('Good Effects', widget.strainDetails.goodEffects),
          _buildStatItem('Side Effects', widget.strainDetails.sideEffects),
        ],
      ),
    );
  }

  Widget _buildBasicStatItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            const Icon(Icons.local_fire_department, color: Colors.red),
            const SizedBox(width: 5.0),
            Text(
              'THC: ${widget.strainDetails.thc}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            const Icon(Icons.local_florist, color: Colors.green),
            const SizedBox(width: 5.0),
            Text(
              'Strain Type: ${widget.strainDetails.strainType}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            const Icon(Icons.timer, color: Colors.blue),
            const SizedBox(width: 5.0),
            Text(
              'Flowering Weeks: ${widget.strainDetails.floweringWeeksMin.truncate()}-${widget.strainDetails.floweringWeeksMax.truncate()}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            const Icon(Icons.height, color: Colors.purple),
            const SizedBox(width: 5.0),
            Text(
              'Height: ${widget.strainDetails.heightInInchesMin.truncate()}-${widget.strainDetails.heightInInchesMax.truncate()} inches',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ],
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