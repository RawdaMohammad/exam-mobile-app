 import 'package:shared_preferences/shared_preferences.dart';

class StorageModule{
 Future<SharedPreferences> getSharedPref() async {
   return await SharedPreferences.getInstance();
 }
}