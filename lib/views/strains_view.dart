import 'package:doobie/DTO/weed_strain.dart';
import 'package:doobie/services/cloud/firebase_cloud_storage.dart';
import 'package:doobie/views/strain_details_view.dart';
import 'package:flutter/material.dart';

class StrainsView extends StatefulWidget {
  const StrainsView({Key? key}) : super(key: key);

  @override
  State<StrainsView> createState() => _StrainsViewState();
}

class _StrainsViewState extends State<StrainsView> {
  Iterable<WeedStrain> _strains = [];
  late final TextEditingController _searchController;
  late final FirebaseCloudStorage _firestoreService;

  Iterable<WeedStrain> _filteredStrains = [];

  Future<void> _performSearch() async {
    setState(() {
      _filteredStrains = _strains
          .where((element) => element.strain
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _firestoreService = FirebaseCloudStorage();
    _searchController = TextEditingController();
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.search,
          color: Colors.deepPurple,
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Perform search functionality here
          },
        ),
      ),
      body: StreamBuilder(
          stream: _firestoreService.getAllWeedStrains(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  _strains = snapshot.data as Iterable<WeedStrain>;
                  if (_filteredStrains.isEmpty) {
                    _filteredStrains = _strains;
                  }
                  return ListView.builder(
                    itemCount: _filteredStrains.length,
                    itemBuilder: (context, index) {
                      final strain = _filteredStrains.elementAt(index);
                      return ListTile(
                        leading: Image.network(strain.imgThumb),
                        title: Text(strain.strain),
                        subtitle: Text(strain.strainType),
                        trailing: Text(strain.thc),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StrainDetailsView(strainDetails: strain, firestoreService: _firestoreService)
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }

              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
