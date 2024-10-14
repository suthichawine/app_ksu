import 'dart:convert';

import 'package:flutter/services.dart';

class ReadJson {
  Future<void> university() async {
    final String response =
        await rootBundle.loadString('assets/json/university.json');
    final data = await json.decode(response);
// ...
print(data);
  }
}
