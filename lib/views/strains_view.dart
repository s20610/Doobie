import 'dart:convert';

import 'package:doobie/DTO/weed_strain.dart';
import 'package:doobie/views/strain_details_page_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StrainsView extends StatefulWidget {
  const StrainsView({Key? key}) : super(key: key);

  @override
  State<StrainsView> createState() => _StrainsViewState();
}

class _StrainsViewState extends State<StrainsView> {
  List<WeedStrain> _strains = [];
  final TextEditingController _searchController = TextEditingController();

  List<WeedStrain> _filteredStrains = [];

  Future<void> _performSearch() async {
    setState(() {
      _filteredStrains = _strains
          .where((element) =>
          element.strain
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchStrains();
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  Future<void> _fetchStrains() async {
    final response = await http.get(
      Uri.parse('https://weed-strain1.p.rapidapi.com/?ordering=-strain'),
      headers: {
        'X-RapidAPI-Key': '74ea235850msh50d7b3b8cfd042dp158be6jsnac06ed01c375',
        'X-RapidAPI-Host': 'weed-strain1.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _strains = data.map((item) => WeedStrain.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to fetch strains');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.search, color: Colors.deepPurple,),
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
      body: _strains.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _filteredStrains.length,
        itemBuilder: (BuildContext context, int index) {
          final strain = _filteredStrains[index];
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
                      StrainDetailsPage(strainDetails: strain),
                ),
              );
            },
          );
        },
      )
      ,
    );
  }
}
