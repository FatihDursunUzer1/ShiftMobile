import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserModel with ChangeNotifier{
  var _user;
  Position? _position;
  get position => _position;
  set position(value){
    _position=value;
    notifyListeners();
  }
  get user => _user;
  set user(value) {
    _user = value;
    notifyListeners();
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error(
            'Location permissions are denied');
      }
    }
    position=await Geolocator.getCurrentPosition();
    return position;
  }
  bool isMockLocation()
  {
    determinePosition().then((value) {
      if(value!.isMocked)
        return true;
    });
    return false;
  }
}