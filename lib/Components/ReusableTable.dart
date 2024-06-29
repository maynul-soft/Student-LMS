import 'package:flutter/material.dart';

class ReusableTable extends StatelessWidget {
  final List<Map<String, String>> data;
  final List<String> columns;

  const ReusableTable({
    Key? key,
    required this.data,
    required this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rowsPerPage = 20;
    int totalRows = data.length;
    int pageCount = (totalRows / rowsPerPage).ceil();

    return StatefulBuilder(builder: (context, setState) {
      int currentPage = 0;

      void _goToPage(int page) {
        setState(() {
          currentPage = page;
        });
      }

      List<Map<String, String>> _getPageData() {
        int start = currentPage * rowsPerPage;
        int end = start + rowsPerPage;
        return data.sublist(start, end > totalRows ? totalRows : end);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: {
              for (var i = 0; i < columns.length; i++) i: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: columns
                    .map((column) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            column,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
              ),
              for (var row in _getPageData())
                TableRow(
                  children: columns
                      .map((column) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(row[column] ?? ''),
                          ))
                      .toList(),
                ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed:
                    currentPage > 0 ? () => _goToPage(currentPage - 1) : null,
                child: Text('Previous'),
              ),
              Text('Page ${currentPage + 1} of $pageCount'),
              ElevatedButton(
                onPressed: currentPage < pageCount - 1
                    ? () => _goToPage(currentPage + 1)
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      );
    });
  }
}
