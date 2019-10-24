import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class AnalasisProvider{

  Future<String> subirImagen(File imagen) async{

  final url = Uri.parse('https://api.cloudinary.com/v1_1/dahvnny63/image/upload?upload_preset=g5th7gse');
  final mineType = mime(imagen.path).split('/');

  final imageUploadRequest = http.MultipartRequest(
    'POST',
    url,
  );

  final file = await http.MultipartFile.fromPath(
    'file',
    imagen.path,
    contentType: MediaType(mineType[0], mineType[1])
  );

  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();

  final resp = await http.Response.fromStream(streamResponse);

  if(resp.statusCode !=200 && resp.statusCode !=201){
    print('algo salio mal');
    print(resp.body);
    return null;
  }

  final respData = json.decode(resp.body);

  print(respData['secure_url']);

  return respData['secure_url'];

}

}