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
        children: <Widget>[_vistaNoticias()],
      ),
    );
  }

  Widget _vistaNoticias() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              _panel(),
              _botonCerrarSesion()
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      padding: EdgeInsets.all(30.0),
      margin: EdgeInsets.only(top: 50.0, bottom: 30.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(185, 194, 194, 0.56),
            blurRadius: 20.0,
            offset: Offset(0, 10.0))
      ]),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 100.0,
                color: Color.fromRGBO(63, 66, 66, 0.9),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                prefs.email,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(63, 66, 66, 0.6),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Guatemala city',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(63, 66, 66, 0.6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _botonCerrarSesion() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.5,
        height: 48.0,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          color: Colors.teal.shade200,
          textColor: Colors.teal.shade200,
          child: Text(
            'Cerrar Sesión'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 13.0),
          ),
          onPressed:(){
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
    );
  }
}
