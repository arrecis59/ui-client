import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MetricasProvider{

  final urlApi = 'https://app-enfermedades.herokuapp.com';

  Future<dynamic> obtenerMetricaEnfermedades() async{

    final url = '$urlApi/generarMetricaEnfermedades';

    final resp = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json"
    });

    if(resp.statusCode != 200){
      print('Error al obtener metrica de enfermedades');
      return null;
    }

    final formatData = json.decode(resp.body);

    return formatData;


  }

}