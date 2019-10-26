import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui_client/src/preferecias_usuario/preferencias_usuario.dart';

class AutenticationProvider {

  final String _apiKey = 'AIzaSyBIosVtg-JwEpYSJPI2rIrpJGCQGQEP6uA';
  final _prefs = PreferenciasUsuario();

  Future<Map<String, dynamic>> ingresar(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      
      _prefs.email = decodeResp['email'];//guarda email para hacer peticiones a firebase

      return {"ok": true};
    } else {
      return {"ok": false, "message": decodeResp['error']['message']};
    }

  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {

      return {"ok": true};
    } else {
      return {"ok": false, "message": decodeResp['error']['message']};
    }
  }
}
