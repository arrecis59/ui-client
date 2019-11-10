import 'package:geolocator/geolocator.dart';

class LocationProvider{

  Future<dynamic> obtenerUbicacion() async{

    var position;
    var address = {"zona": "", "municipio": "", "pais": "", "direccion": "no especificada"};
    Geolocator geolocator = Geolocator();
    GeolocationStatus status  = await geolocator.checkGeolocationPermissionStatus();


    try {
      position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      if(status == GeolocationStatus.granted){
      List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark  = newPlace[0]; 

      String pais = placeMark.country;
      String zona = placeMark.subLocality;
      String municipio = placeMark.subAdministrativeArea;

      if(zona == "" && municipio != ""){
        address = {"zona": "", "municipio": municipio, "pais": pais, "direccion": municipio + ", " + pais};
      }else if(zona !="" && municipio == ""){
        address = {"zona": zona, "municipio": "", "pais": pais, "direccion": zona + ", " + pais};
      }

     }
    } catch (e) {
      print(e);
      address = {"zona": "", "municipio": "", "pais": "", "direccion": "no especificada"};
    }

    return address;
   
  }
}