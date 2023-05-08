import 'package:doobie/DTO/weed_strain.dart';
import 'package:doobie/services/cloud/firebase_cloud_storage.dart';
import 'package:flutter/material.dart';

class StrainDetailsView extends StatefulWidget {
  final WeedStrain strainDetails;
  final FirebaseCloudStorage firestoreService;

  const StrainDetailsView(
      {Key? key, required this.strainDetails, required this.firestoreService})
      : super(key: key);

  @override
  StrainDetailsViewState createState() => StrainDetailsViewState();
}

class StrainDetailsViewState extends State<StrainDetailsView> {
  bool _isFavorite = false;
  String email = 'borys@ukotka.com';

  void isStrainInFavorites() async {
    _isFavorite = await widget.firestoreService.isStrainInTriedStrains(
        userEmail: email, strainName: widget.strainDetails.strain);
  }

  @override
  void initState() {
    isStrainInFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strainDetails.strain),
        actions: [
          IconButton(
            onPressed: () async {
              if (_isFavorite) {
                await widget.firestoreService.removeStrainFromTriedStrains(
                    userEmail: email, strainName: widget.strainDetails.strain);
                setState(() {
                  _isFavorite = false;
                });
              } else {
                await widget.firestoreService.addStrainToTriedStrains(
                    userEmail: email, strainName: widget.strainDetails.strain);
                setState(() {
                  _isFavorite = true;
                });
              }
            },
            icon: _isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          ),
        ],
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
          _buildStatItem(
              'Indoor Yield', '${widget.strainDetails.indoorYieldInGramsMax}g'),
          _buildStatItem('Outdoor Yield',
              '${widget.strainDetails.outdoorYieldInGramsMax}g'),
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
    final style;
    if (label == 'Side Effects') {
      style = const TextStyle(fontSize: 16, color: Colors.deepOrange);
    } else if (label == 'Good Effects') {
      style = const TextStyle(fontSize: 16, color: Colors.green);
    } else {
      style = const TextStyle(fontSize: 16);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: style,
        ),
      ],
    );
  }
}
