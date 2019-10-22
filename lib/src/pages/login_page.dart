import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container( 
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child:  Column(
              children: <Widget>[
                _encabezado(),
                _emailInput(),
                _passwordInput(),
                _ingresarButton(),
                _crearCuenta()
              ],
            ),
          )
        ),
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
        style: TextStyle( 
          color: Colors.grey
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingrese correo electrónico',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(10.0),
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
        obscureText: _isHidden ? false: true,
        style: TextStyle(
          color: Colors.grey
        ),
        decoration: InputDecoration(
          hintText: 'Ingrese contraseña',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(10.0),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton( 
            icon: _isHidden ? Icon(Icons.visibility): Icon(Icons.visibility_off),
            onPressed: _toggleVisibility,
          ),
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
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.10,
        height: 48.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          color: Colors.blue.shade300,
          textColor: Colors.white,
          child: Text('Ingresar'.toUpperCase()),
          onPressed: (){
          },
        ),
      ),
    );
  }


    Widget _registrarseButton(){
    return  Container( 
      margin: EdgeInsets.only(top: 24.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.10,
        height: 48.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), 
            side: BorderSide(color: Colors.blue.shade200, width: 1.5)
          ),
          color: Colors.white,
          textColor: Colors.blue.shade200,
          child: Text('Crear cuenta'.toUpperCase()),
          onPressed: (){
             Navigator.pushReplacementNamed(context, 'register');
          },
        ),
      ),
    );
  }

    Widget _crearCuenta(){
    return Container( 
      margin: EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        children: <Widget>[
          Text('o'.toUpperCase(), style: TextStyle(color: Colors.grey),),
          _registrarseButton()
        ],
      )
    );
  }


  Widget _encabezado(){
    return Container( 
      padding: EdgeInsets.only(top: 20.0,bottom: 40.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'Hero',
            child: CircleAvatar( 
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/logo.png'),
            )
          ),
          SizedBox(height: 30,),
          Text( 
            'Bienvenido'.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18.0,
              fontFamily: 'arial',
              fontWeight: FontWeight.bold
            ),
          ),

        ],
      )
    );
  }

  void _toggleVisibility(){
    setState(() {
     _isHidden = !_isHidden;
    });
  }

}
