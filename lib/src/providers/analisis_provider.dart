import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class AnalasisProvider {

  final urlApi = 'https://app-enfermedades.herokuapp.com';

  Future<String> subirImagen(File imagen) async {
    //URL endpoint
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dahvnny63/image/upload?upload_preset=g5th7gse');
    final mineType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath('file', imagen.path,
    contentType: MediaType(mineType[0], mineType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('error en subir imagen');
      return null;
    }

    final respData = json.decode(resp.body);

    return respData['secure_url'];
  }

  //DETECTAR ENFERMEDAD
  Future<dynamic> detectarEnfermedad(String rutaImg) async {
    //URL api
    final url ='$urlApi/analizarImagen?img=$rutaImg';

    //peticion http get
    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    //verificar si hubo algun error
    if(resp.statusCode != 200){
      print('error en detectar enfermedad');
      return null;
    }

    //decodificar respuesta a json
    final respData = json.decode(resp.body);

    //retorno de enfermedad si no hay errores
    return respData['enfermedad']; 
  }

  //CONSULTAR SINTOMAS
  Future<dynamic> consultarSintomas(String _enfermedad) async{

    //URL api
    final url = '$urlApi/consultarSintomas?enfermedad=$_enfermedad';

    //peticion http get
    final resp = await http.get(url, headers: {
       HttpHeaders.contentTypeHeader: "application/json",
    });

    //comprobar si hubieron errores
    if(resp.statusCode != 200){
      print('error en consultar sintomas');
      return null;
    }

    //decodificar respuesta a json
    final decodeData = json.decode(resp.body);

    //retorna sintomas encontrados segun enfermedad
    return decodeData['sintomas'];

  }

  //INSERTAR HISTORIAL
  Future<dynamic> insertarHistorial(String _email, String _rutaImg, String _enfermedad, String _gravedad,
                                    String _fecha, double _ejecucion, String _ubicacion) async{

    //URL api
    final url = '$urlApi/insertarHistorial';

    //data

    final data = { 
      'email': _email, 
      'rutaImg': _rutaImg, 
      'enfermedad': _enfermedad,
      'gravedad': _gravedad, 
      'fecha': _fecha, 
      'ejecucion': _ejecucion,
      'ubicacion': _ubicacion 
    };

    //peticion http post
    final resp = await http.post(url,
    headers: { HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(data)
    );

    //verificar si hubieron errores
    if(resp.statusCode != 200){
      print('error al insertar historial');
      return null;
    }

    //convertir resp en json
    final decodeData  = json.decode(resp.body);

    //retorna status de la operacion
    return decodeData['status'];

  }

  
}
