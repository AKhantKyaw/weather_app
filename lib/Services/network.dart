import 'package:weather_app/Model/errormdel.dart';
import 'package:weather_app/Model/forecastmodel.dart';
import 'package:weather_app/Model/weathermodel.dart';
import 'package:weather_app/Services/location_service.dart';
import 'package:http/http.dart' as http;
class NetworkCall {
  LocationService locationService = LocationService();
  Future<Forecastmodel> getforecast() async {
    await locationService.initLocationCheck();
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=${locationService.latitude}&lon=${locationService.longitude}&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return forecastmodelFromJson(response.body);
    } else {
      throw Exception("forecast is none");
    }
  }
  Future<Errormodel> geterror(String name) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
    final response = await http.get(url);
    if (response.statusCode == 404) {
      return errormodelFromJson(response.body);
    } else {
      throw Exception("Please some text");
    }
  }
  Future<Wathermodel> searchcity(String name) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      return wathermodelFromJson(respone.body);
    } else {
      throw Exception("No Search data");
    }
  }
  Future<Wathermodel> getWeather() async {
    await locationService.initLocationCheck();
    if (locationService.latitude == null || locationService.longitude == null) {
    } else {
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${locationService.latitude}&lon=${locationService.longitude}&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return wathermodelFromJson(response.body);
      }
    }
    throw Exception("throwexception");
  }
}
