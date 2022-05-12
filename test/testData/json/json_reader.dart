import 'dart:io';

String readJson(String name) {
  return File('test/testData/json/$name').readAsStringSync();
}
