import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/features/search/presentation/provider/search_provider.dart';

class SearchBarWidget extends HookConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hooks let us use a TextEditingController without a StatefulWidget!
    final textController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: const Icon(Icons.search),
          
          // A huge benefit of having the controller is adding a clear button
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              textController.clear();
              ref.read(searchNotifierProvider.notifier).search('');
            },
          ),
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        ),
        onChanged: (text) {
          ref.read(searchNotifierProvider.notifier).search(text);
        },
      ),
    );
  }
}
