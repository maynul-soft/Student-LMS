import 'package:flutter/material.dart';


class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  static const String name = 'comingSoon';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          SizedBox(
            height: height / 4,
          ),
          Image.asset(
            'assets/images/coming_soon.png',
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: height / 6,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_outlined,size: 40,),
                )),
          )
        ]));
  }
}


