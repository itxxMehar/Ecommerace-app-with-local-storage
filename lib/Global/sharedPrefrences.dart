import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefrences{
storeVal(key,val) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, val);
}
getval(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

// Retrieve a string
  String? stringValue = prefs.getString(key);
  return stringValue;
}
}