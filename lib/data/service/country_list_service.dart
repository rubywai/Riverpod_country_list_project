
import 'package:dio/dio.dart';
import '../../const/api_const.dart';
import '../model/country_list_model.dart';

class CountryListService{
  final Dio _dio = Dio();
  Future<List<CountryListModel>> getCountryList() async{
    Uri uri = Uri.parse('${ApiConst.baseUrl}/${ApiConst.all}?fields=name,region,flags');
    final response = await _dio.getUri(uri);
    return (response.data as List).map((data){
      return CountryListModel.fromJson(data);
    }).toList();
  }
}