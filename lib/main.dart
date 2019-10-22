import 'package:flutter/material.dart';
import 'package:ui_client/src/routes/routes.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),//rutas App
      theme: ThemeData( 
        primaryColor: Colors.blue.shade200
      ),
    );
  }
}