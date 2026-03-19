import 'package:flutter/material.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search / Filter')),
      body: const Center(child: Text('Search and filter UI')),
    );
  }
}
