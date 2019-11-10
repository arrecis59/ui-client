import 'package:geolocator/geolocator.dart';

class LocationProvider{

  Future<String> obtenerUbicacion() async{

    var position;
    String address;
    Geolocator geolocator = Geolocator();
    GeolocationStatus status  = await geolocator.checkGeolocationPermissionStatus();


    try {
      position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      if(status == GeolocationStatus.granted){
      List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark  = newPlace[0]; 
      print(position.latitude);
      print(position.longitude);
      address = placeMark.subLocality + ", " + placeMark.locality;
      print('Dirección: '+ address);
     }

    } catch (e) {
      address = null;
    }

    return address;
   
  }
}