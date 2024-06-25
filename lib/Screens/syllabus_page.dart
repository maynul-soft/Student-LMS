import 'package:flutter/material.dart';
import 'package:lms/Components/ReusableTable.dart';
// Make sure to import the reusable table component

class SyllabusPage extends StatelessWidget {
  const SyllabusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      },
      {
        "Sl.": "1",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-1",
        "Script Link": "Open"
      },
      {
        "Sl.": "2",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-2",
        "Script Link": "Open"
      },
      {
        "Sl.": "3",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
        "Script Link": "Open"
      },
      {
        "Sl.": "4",
        "Class": "O-level Candidate",
        "Course": "Topical Mock",
        "Exam": "Mock-3",
      }
      // Add more rows as necessary
    ];

    List<String> columns = ["Sl.", "Class", "Course", "Exam", "Script Link"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Syllabus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableTable(data: data, columns: columns),
          ],
        ),
      ),
    );
  }
}
