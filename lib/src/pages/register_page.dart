import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                _registrarButton(),
                _existeCuenta()
              ],
            ),
          )
        ),
      ),
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
            'crear cuenta'.toUpperCase(),
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


    Widget _registrarButton(){
    return  Container( 
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.10,
        height: 48.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          color: Colors.blue.shade300,
          textColor: Colors.white,
          child: Text('Crear'.toUpperCase()),
          onPressed: (){
          },
        ),
      ),
    );
  }


  Widget _existeCuenta(){
    return Container(
      margin: EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          GestureDetector( 
            child: Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle( 
                color: Colors.grey
              ),
            ),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          GestureDetector(
            child: Text( 
              'ingresar'.toUpperCase(),
              style: TextStyle( 
                color: Colors.blue.shade200
              ),
            ),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }


    void _toggleVisibility(){
    setState(() {
     _isHidden = !_isHidden;
    });
  }

}