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
      body: Stack( 
        children: <Widget>[
          _vista(),
          _crearLoading()
        ],
      )
    );
  }

  Widget _vista() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/header.png'),
                      fit: BoxFit.fill)
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
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                decoration: BoxDecoration( 
                  border: Border( 
                    bottom: BorderSide( 
                      color: Colors.grey[300]
                    )
                  )
                ),
                child: TextField( 
                  controller: emailController,
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
                padding: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                child: TextField( 
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: _isHidden ? false : true,
                  decoration: InputDecoration( 
                    border: InputBorder.none,
                    hintText: 'Contraseña',
                    hintStyle: TextStyle( 
                      color: Colors.grey
                    ),
                    suffixIcon: IconButton( 
                      icon: _isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: _toggleVisibility,
                    )
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
            ],
          ),
          ),
          SizedBox(height: 30.0,),
          Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ButtonTheme( 
            minWidth: MediaQuery.of(context).size.width / 1.5,
            height: 48.0,
            child: FlatButton(
            shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
              color: Color.fromRGBO(47, 181, 121, 0.5),
              textColor: Colors.white,
              child: Text(
              'Ingresar'.toUpperCase(),
              style: TextStyle( 
                fontWeight: FontWeight.w500
              ),
              ),
              onPressed: _iniciarSesion,
            ),
          ),
          ),
          SizedBox(height: 30.0,),
          GestureDetector(
            child: Center( 
              child: Text( 
                'Crear cuenta'.toUpperCase(),
                style: TextStyle( 
                  color: Color.fromRGBO(63, 66, 66, 0.8),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            onTap: (){},
          ),
          SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }


   void _iniciarSesion() async {

    if(emailController.text !='' && emailController.text !=''){

      _setLoading(true);

      Map info = await authProvider.ingresar(emailController.text, passwordController.text);

      if (info['ok']) {
        
        _setLoading(false);
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        
        _setLoading(false);
        mostrarAlerta(context, info['message'], 'error');
      }

    }else{
      mostrarAlerta(context,'Ingrese correo y contraseña', 'error');
    }
  }


   Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )
        ],
      );
    } else {
      return Container();
    }
  }

  void _setLoading(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

}
