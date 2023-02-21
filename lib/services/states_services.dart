import 'dart:convert';

import 'package:http/http.dart';
import 'package:test2/model/world_state_model.dart';
import 'package:http/http.dart' as http;
import 'package:test2/services/utilities/app_url.dart';

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecord() async {
    final responce = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListStateRecord() async {
    var data;
    final responce = await http.get(Uri.parse(AppUrl.countrystateApi));

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
