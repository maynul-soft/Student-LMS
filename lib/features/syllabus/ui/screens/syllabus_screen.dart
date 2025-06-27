import 'package:flutter/material.dart';
import '../widgets/build_search_section.dart';


class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  static const String name = 'syllabus-screen';



  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {

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
              element.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Plan 2024 - 2025'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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

    );
  }
}





