import 'package:flutter/material.dart';

class UnknownRoute extends StatelessWidget{
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text("Unknown"),), //AppBar,
        body: Container(
            padding: const EdgeInsets.all(20),
          child: const Text("Unknown"),
        ),
      );


  }



}