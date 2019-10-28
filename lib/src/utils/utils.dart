import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String message, String type) {

  if(message == 'EMAIL_NOT_FOUND' || message == 'INVALID_EMAIL'){
    message = '¡No existe la cuenta!';

  }else if(message == 'INVALID_PASSWORD'){
    message = '¡Contraseña incorrecta!';
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
