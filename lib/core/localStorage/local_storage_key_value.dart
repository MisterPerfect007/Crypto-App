import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageKeyValueInterface{

  ///Saves an integer [value] to persistent storage in the background.
  Future<bool> setInt(String key, int value);
  
  ///Saves a String [value] to persistent storage in the background.
  Future<bool> setString(String key, String value);

  ///Removes an entry from persistent storage.
  Future<bool> remove(String key);

  //
  ///Reads a value from persistent storage, throwing an exception if it's not a String.
  String? getString(String key);
}

class LocalStorageKeyValue implements LocalStorageKeyValueInterface{
  final SharedPreferences prefs;

  LocalStorageKeyValue(this.prefs);

  //! Write data
  // Save an integer.
  
  @override
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  //Save a String
  @override
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  //! Read data
  
  @override
  String? getString(String key)  {
    return prefs.getString(key);
  }

  //! Remove data
  @override
  Future<bool> remove(String key) async {
    return prefs.remove(key);
  }
}