import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<Map<String, String>> data;

  DataSearch({required this.data});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Nothing shown here, handled after close()
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? data
        : data.where((row) {
      return row.values.any(
            (value) => value.toLowerCase().contains(query.toLowerCase()),
      );
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['Course'] ?? ''),
          onTap: () {
            close(context, suggestion['Course'] ?? '');
          },
        );
      },
    );
  }
}
