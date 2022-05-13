import 'dart:io';

///Read a json file and return its content as a string
///
///JSON should be in test/testData/json/ folder
String readJson(String name) {
  return File('test/testData/json/$name').readAsStringSync();
}
