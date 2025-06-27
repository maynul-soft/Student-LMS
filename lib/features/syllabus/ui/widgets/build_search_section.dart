import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate<String> {
  final List<Map<String, String>> data;
  final Function(String) onQueryChanged;

  DataSearch({required this.data, required this.onQueryChanged});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryChanged(query);
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onQueryChanged(query);
    return Container(); // No need to rebuild results here
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? data
        : data.where((row) {
      return row.values.any((element) =>

          element.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['Course'] ?? ''),
          onTap: () {
            query = suggestion['Course'] ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}