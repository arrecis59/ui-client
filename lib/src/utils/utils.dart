import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String message, String type) {

  if(message == 'EMAIL_NOT_FOUND' || message == 'INVALID_EMAIL'){
    message = '¡No existe la cuenta!';

  }else if(message == 'INVALID_PASSWORD'){
    message = '¡Contraseña incorrecta!';
  }else if(message == 'EMAIL_EXISTS'){
    message = '¡La cuenta ya existe!';
  }
  else if(message == 'WEAK_PASSWORD : Password should be at least 6 characters'){
    message = '¡La contraseña debe ser de almenos 6 caracteres!';
  }
  else if(message == 'TOO_MANY_ATTEMPTS_TRY_LATER : Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later'){
    message = '¡Demasiados intentos de sesión incorrectos, por favor intentelo más tarde!';
  }

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(type),
          content: Text(message),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: <Widget>[
            Container(
              child: FlatButton(
                child: Text(
                  'ok'.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Color.fromRGBO(47, 181, 121, 0.5),
              ),
            )
          ],
        );
      });
}
