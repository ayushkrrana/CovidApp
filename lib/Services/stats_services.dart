import 'dart:convert';

import 'package:covidapp/Model/WorldStatsModel.dart';
import 'package:covidapp/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices{

  Future<WorldStatsModel> fetchWorldRecords() async{
    final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data =jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    }
    else{
      throw Exception('Error Messages');
    }

  }

  Future<List<dynamic>> countriesNamesFetch() async{ //here we do not create the model of the countries name because we only require name and flag of the countries
    var data;
    final response=await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      var data =jsonDecode(response.body.toString());
      return data; //WorldStatsModel.fromJson(data);- here we do not return this because we do not create model for this data,that's why we pass list in the future rather than model and also return the data
    }
    else{
      throw Exception('Error Messages');
    }

  }

}