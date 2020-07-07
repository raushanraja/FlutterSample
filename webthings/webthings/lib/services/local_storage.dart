import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }    return _instance;
  }



  String getIP(){
    return _preferences.getString("ip");
  }

  Future<bool> setIP(String ipString){
    return _preferences.setString("ip", ipString);
  }
}