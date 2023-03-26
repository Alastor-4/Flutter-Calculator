import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences? _prefs;
  static bool _isDarkmode = false;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isDarkmode {
    return _prefs!.getBool('isDarkmode') ?? _isDarkmode;
  }

  set isDarkmode(bool value) {
    _isDarkmode = value;
    _prefs!.setBool('isDarkmode', value);
  }
}
