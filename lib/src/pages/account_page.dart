import 'package:flutter/material.dart';
import 'package:ui_client/src/preferecias_usuario/preferencias_usuario.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Información de la cuenta',
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade200,
      ),
      body: Stack(
        children: <Widget>[
         _vistaCuenta()
        ],
      ),
    );
  }

  Widget _vistaCuenta(){
    return Container();
  }

}