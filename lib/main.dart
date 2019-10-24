import 'package:flutter/material.dart';
import 'package:ui_client/src/preferecias_usuario/preferencias_usuario.dart';
import 'package:ui_client/src/routes/routes.dart';

 
void main() async{

    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();

    print( prefs.email );

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