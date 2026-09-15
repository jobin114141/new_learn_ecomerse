import 'package:flutter/material.dart';
import 'package:my_ecomerse/features/search/presentation/widget/search_bar_widget.dart';
import 'package:my_ecomerse/features/search/presentation/widget/search_results_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
      ),
      body: const Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: SearchResultsList(),
          ),
        ],
      ),
    );
  }
}
