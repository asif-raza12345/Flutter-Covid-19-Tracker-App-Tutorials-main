import 'dart:convert';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../Model/Worldstatemodel.dart';

class StateServices {
  Future<Worldstatemodel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.WorldStatelist));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Worldstatemodel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countrieslist));

    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}




