import 'package:flutter/material.dart';

class LoginPageOld extends StatefulWidget {
  // LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageOldState createState() => _LoginPageOldState();
}

class _LoginPageOldState extends State<LoginPageOld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView( 
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _logo(),
            _emailInput(),
            _passwordInput(),
            _ingresarButton(),
            _crearCuentaText()
          ],
        ),
        )
      ),
    );
  }


  Widget _emailInput(){
    return Container(
      margin: EdgeInsets.only(bottom: 18.0),
      width: MediaQuery.of(context).size.width / 1.10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow( 
            blurRadius: 10.0,
            color: Colors.black26
          )
        ]
      ),
      child: TextFormField( 
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingrese correo electrónico',
          contentPadding: EdgeInsets.all(14.0),
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          enabledBorder: OutlineInputBorder( 
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }

  Widget _passwordInput(){
    return Container(

      margin: EdgeInsets.only(bottom: 18.0),
      width: MediaQuery.of(context).size.width / 1.10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow( 
            blurRadius: 10.0,
            color: Colors.black26
          )
        ]
      ),
      child: TextFormField( 
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Ingrese contraseña',
          contentPadding: EdgeInsets.all(14.0),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility_off),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          enabledBorder: OutlineInputBorder( 
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }

  Widget _ingresarButton(){
    return  Container( 
      margin: EdgeInsets.only(bottom: 18.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.10,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          color: Colors.blue.shade300,
          textColor: Colors.white,
          child: Text('Ingresar'.toUpperCase()),
          onPressed: (){},
        ),
      ),
    );
  }

  Widget _registrarseButton(){
    return  Container( 
      margin: EdgeInsets.only(bottom: 18.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.10,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), 
            side: BorderSide(color: Colors.blue.shade200, width: 1.4)
          ),
          color: Colors.white,
          textColor: Colors.blue.shade300,
          child: Text('Crear una cuenta'.toUpperCase()),
          onPressed: (){},
        ),
      ),
    );
  }

  Widget _crearCuentaText(){
    return Container( 
      margin: EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        children: <Widget>[
          Text('o'.toUpperCase(), style: TextStyle(color: Colors.grey),),
          SizedBox(height: 24.0,),
          //Text('Crear una cuenta'.toUpperCase(), style: TextStyle(color: Colors.blue.shade300, fontSize: 15.0),)
          _registrarseButton()
        ],
      )
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
      child: Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    ),
    );
  }


}
