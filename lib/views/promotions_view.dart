import 'package:flutter/material.dart';

class PromotionsView extends StatefulWidget {
  const PromotionsView({Key? key}) : super(key: key);

  @override
  State<PromotionsView> createState() => _PromotionsViewState();
}

class _PromotionsViewState extends State<PromotionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best deals in town'),
      ),
      body: const Center(
        child: Text('Promo'),
      ),
    );
  }
}
