import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HorizontalScrollScreen(),
    ));

class HorizontalScrollScreen extends StatelessWidget {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal ListView'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: MediaQuery.of(context).size.height * 0.35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              Container(
                height: 50,
                width: 150,
                color: Colors.amber[600],
                child: Center(child: Text('Entry A')),
              ),
              Container(
                height: 50,
                width: 150,
                color: Colors.amber[500],
                child: Center(child: Text('Entry B')),
              ),
              Container(
                height: 50,
                width: 150,
                color: Colors.blue[500],
                child: Center(child: Text('Entry B')),
              ),
              Container(
                height: 50,
                width: 150,
                color: Colors.red[500],
                child: Center(child: Text('Entry B')),
              ),
              // Add more containers here
            ],
          )),
    );
  }
}
