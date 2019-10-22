import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Center( 
        child: SingleChildScrollView(
          child: Container( 
            child: Column( 
              children: <Widget>[
                Text("I'm the home page")
              ],
            ),
          ),
        ),
      ),
    );
  }
}