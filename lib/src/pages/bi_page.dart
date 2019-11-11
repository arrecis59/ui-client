import 'package:flutter/material.dart';

class BiPage extends StatefulWidget {
  BiPage({Key key}) : super(key: key);

  @override
  _BiPageState createState() => _BiPageState();
}

class _BiPageState extends State<BiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Inteligencía de negocios'),
      ),
      body: Center( 
        child: Text('Hola'),
      ),
    );
  }
}