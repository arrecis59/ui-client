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
        title: Text(
        'Inteligencía de negocios',
        style: TextStyle( 
          color: Colors.white,
          fontSize: 15.0
        ),
        ),
        backgroundColor: Color.fromRGBO(242, 195, 53, 0.7),
      ),
      body: Center( 
        child: Text('Hola'),
      ),
    );
  }
}