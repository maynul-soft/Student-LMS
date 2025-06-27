import 'package:flutter/material.dart';
import '../widgets/data_search.dart';


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
        "Sl": "$index",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-${(index % 10) + 1}",
        "Link": "Open"
      };
    });
    filteredData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Plan 2024 - 2025'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final selected = await showSearch(
                context: context,
                delegate: DataSearch(data: data),
              );

              if (selected != null && selected.isNotEmpty) {
                setState(() {
                  filteredData = data.where((row) {
                    return row.values.any(
                            (value) => value.toLowerCase().contains(selected.toLowerCase()));
                  }).toList();
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(2),
          },
          children:  [
           const TableRow(
              children:  [
                Padding(padding: EdgeInsets.all(3),child: Text('llak') , ),
                Padding(padding: EdgeInsets.all(3),child: Text('llak') , ),
                Padding(padding: EdgeInsets.all(3),child: Text('llak') , )
              ],
            ),
            ...filteredData.map((student) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(student['Sl'].toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(student['Class'].toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(student['Course'].toString()),
                ),
              ],
            )),
        
        
          ],
        ),
      ),

    );
  }
}





