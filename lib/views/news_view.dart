import 'package:doobie/DTO/news.dart';
import 'package:doobie/DTO/weed_strain.dart';
import 'package:doobie/services/cloud/firebase_cloud_storage.dart';
import 'package:doobie/views/strain_details_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  Iterable<News> _news = [];
  late final TextEditingController _searchController;
  late final FirebaseCloudStorage _firestoreService;

  Iterable<News> _filteredNews = [];

  Future<void> _performSearch() async {
    setState(() {
      _filteredNews = _news
          .where((element) => element.title
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
      backgroundColor: Colors.grey.shade300,
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
        ),
      ),
      body: StreamBuilder(
          stream: _firestoreService.getAllNews(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  _news = snapshot.data as Iterable<News>;
                  if (_filteredNews.isEmpty) {
                    _filteredNews = _news;
                  }
                  return ListView.builder(
                    itemCount: _filteredNews.length,
                    itemBuilder: (context, index) {
                      final singleNews = _filteredNews.elementAt(index);
                      return getNewsCard(singleNews);
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget getNewsCard(News news) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () async {
          await _launchUrl(news.url);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Image.network(
                  news.imgThumb,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    debugPrint('Error loading image ${news.imgThumb}');
                    return const Icon(
                      Icons.image,
                      size: 30,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(news.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2)),
              const SizedBox(height: 10),
              Text(news.summary, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
