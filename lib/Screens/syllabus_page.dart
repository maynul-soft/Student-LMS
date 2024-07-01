import 'package:flutter/material.dart';
import 'package:lms/Components/ReusableTable.dart';

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({Key? key}) : super(key: key);

  @override
  _SyllabusPageState createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  List<Map<String, String>> data = [];
  List<Map<String, String>> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Generate 100 rows of data programmatically
    data = List.generate(100, (index) {
      return {
        "Sl.": "${index + 1}",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-${(index % 10) + 1}",
        "Link": "Open"
      };
    });
    filteredData = data;
  }

  void _filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredData = data;
      });
    } else {
      setState(() {
        filteredData = data.where((row) {
          return row.values.any((element) =>
              element != null &&
              element.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> columns = ["Sl.", "Class", "Course", "Exam", "Link"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Plan 2024 - 2025'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(
                  data: data,
                  onQueryChanged: _filterData,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReusableTable(data: filteredData, columns: columns),
      ),
    );
  }
}

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
                element != null &&
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

void main() {
  runApp(MaterialApp(
    home: SyllabusPage(),
  ));
}
