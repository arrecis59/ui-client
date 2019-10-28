import 'package:flutter/material.dart';
import 'package:ui_client/src/providers/autentication_provider.dart';
import 'package:ui_client/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = false;
  bool _isLoading = false;
  final AutenticationProvider authProvider = AutenticationProvider();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/header.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            'LOGIN'.toUpperCase(),
            style: TextStyle(
                color: Color.fromRGBO(63, 66, 66, 0.8),
                fontSize: 22.0,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 30.0,),
          Container( 
            width: MediaQuery.of(context).size.width / 1.20,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration( 
              color: Colors.white,
              boxShadow: [
                BoxShadow( 
                  color: Color.fromRGBO(185, 194, 194, 0.56),
                  blurRadius: 20.0,
                  offset: Offset(0, 10.0)
                )
              ]
            ),
            child: Column( 
              children: <Widget>[
                Container( 
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration( 
                    border: Border( 
                      bottom: BorderSide( 
                        color: Colors.grey[300]
                      )
                    ),
                  ),
                  child: TextField( 
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration( 
                      border: InputBorder.none,
                      hintText: 'Correo',
                      hintStyle: TextStyle( 
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
                Container( 
                  padding: EdgeInsets.all(8.0),
                  child: TextField( 
                    obscureText: true,
                    decoration: InputDecoration( 
                      border: InputBorder.none,
                      hintText: 'Contraseña',
                      hintStyle: TextStyle( 
                        color: Colors.grey
                      ),
                      suffixIcon: Icon(Icons.visibility)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0,),
          Container( 
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(50.0),
              color: Color.fromRGBO(47, 181, 121, 0.5)
            ),
            child: Center( 
              child: Text( 
                'Ingresar'.toUpperCase(),
                style: TextStyle( 
                  color: Colors.white,
                  fontSize: 14.0
                ),
              ),
            )
          ),
          SizedBox(height: 40.0,),
          Center( 
            child: Text( 
              'Crear cuenta'.toUpperCase(),
              style: TextStyle( 
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(63, 66, 66, 0.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
