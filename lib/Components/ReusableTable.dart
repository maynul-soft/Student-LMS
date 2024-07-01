import 'package:flutter/material.dart';

class ReusableTable extends StatefulWidget {
  final List<Map<String, String>> data;
  final List<String> columns;

  const ReusableTable({
    Key? key,
    required this.data,
    required this.columns,
  }) : super(key: key);

  @override
  _ReusableTableState createState() => _ReusableTableState();
}

class _ReusableTableState extends State<ReusableTable> {
  int rowsPerPage = 20;
  int currentPage = 0;

  void _goToPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  List<Map<String, String>> _getPageData() {
    int start = currentPage * rowsPerPage;
    int end = start + rowsPerPage;
    return widget.data
        .sublist(start, end > widget.data.length ? widget.data.length : end);
  }

  @override
  Widget build(BuildContext context) {
    int totalRows = widget.data.length;
    int pageCount = (totalRows / rowsPerPage).ceil();

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 56.0,
                  maxHeight: 56.0,
                  child: Container(
                    color: Colors.grey[300],
                    child: Table(
                      columnWidths: {
                        for (var i = 0; i < widget.columns.length; i++)
                          i: FlexColumnWidth(),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          children: widget.columns
                              .map((column) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        column,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var row = _getPageData()[index];
                    return Table(
                      columnWidths: {
                        for (var i = 0; i < widget.columns.length; i++)
                          i: FlexColumnWidth(),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          children: widget.columns
                              .map((column) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Center(child: Text(row[column] ?? '')),
                                  ))
                              .toList(),
                        ),
                      ],
                    );
                  },
                  childCount: _getPageData().length,
                ),
              ),
            ],
          ),
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
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
