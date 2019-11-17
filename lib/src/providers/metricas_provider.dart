import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MetricasProvider{

  final urlApi = 'https://app-enfermedades.herokuapp.com';

  //METRICA ENFERMEDADES
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

  //METRICA UBICACION
  Future<dynamic> obtenerMetricaUbicacion() async{

    final url = '$urlApi/generarMetricaUbicacionEnfermedades';

    final resp = await http.get(url, headers: {
       HttpHeaders.contentTypeHeader: "application/json"
    });

    if(resp.statusCode !=200){
      print('Error al generar metrica de ubicacion');
      return null;
    }

    final formatData = json.decode(resp.body);

    return formatData;

  }

  //METRICA RENDIMIENTO
  Future<dynamic> obtenerMetricaRendimiento() async{

    final url = '$urlApi/generarMetricaRendimiento';

    final resp = await http.get(url, headers: {
       HttpHeaders.contentTypeHeader: "application/json"
    });

    if(resp.statusCode !=200){
      print('Error al generar metrica de rendimiento');
      return null;
    }

    final formatData = json.decode(resp.body);

    return formatData;

  }

}