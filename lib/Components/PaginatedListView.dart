import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  final List<Widget> items;
  final int itemsPerPage;

  const PaginatedListView({
    Key? key,
    required this.items,
    this.itemsPerPage = 10,
  }) : super(key: key);

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int pageCount = (widget.items.length / widget.itemsPerPage).ceil();

    List<Widget> getPageItems() {
      int start = currentPage * widget.itemsPerPage;
      int end = start + widget.itemsPerPage;
      return widget.items.sublist(
          start, end > widget.items.length ? widget.items.length : end);
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: getPageItems(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed:
                  currentPage > 0 ? () => setState(() => currentPage--) : null,
              child: Text('Previous'),
            ),
            Text('Page ${currentPage + 1} of $pageCount'),
            ElevatedButton(
              onPressed: currentPage < pageCount - 1
                  ? () => setState(() => currentPage++)
                  : null,
              child: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
