import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper{
  static ApiHelper apiHelper = ApiHelper._();
  ApiHelper._();

  Future<Map> fetchApiData(String img) async {
    String api = "https://pixabay.com/api/?key=45125752-380a2f3338a03301a149d0b54&q=$img";
    Uri url = Uri.parse(api);

    Response response = await http.get(url);

    if(response.statusCode == 200){
      final json = response.body;
      final Map data = jsonDecode(json);
      return data;
    }
    else{
      return{};
    }
  }

}