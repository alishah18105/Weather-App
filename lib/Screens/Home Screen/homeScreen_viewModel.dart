import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;
class HomeViewModel extends BaseViewModel{

TextEditingController citySearch = TextEditingController();
String city = "Karachi";
String apiKey =  "6235f467e7bab3bd7543388223f74979";
String apiWeatherKey = "98a0b636afed41a9ba8105025243012";
Map <String, dynamic> currentWeatherData = {};
Map <String, dynamic> WeekWeatherData = {};
Map<String, dynamic> hourlyWeatherData = {};
bool iscurrentWeatherData = true;
bool  ishourlyWeatherData = true;
bool  isweeklyWeatherData = true;


//Current Weather Api:-------------------------------------------------------------------------
 getCurrentWeather(String city) async{ 
  iscurrentWeatherData = true;
  var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey");
  var response = await https.get(url);
  var responseBody = jsonDecode(response.body);
  currentWeatherData = responseBody;
  iscurrentWeatherData = false;
  notifyListeners(); 
}

//Hourly Weather Api:-----------------------------------------------------------------------------
getHourlyWeather(String city) async{
  ishourlyWeatherData = true;
  var url = Uri.parse("https://api.weatherapi.com/v1/forecast.json?q=$city&hours=12&key=$apiWeatherKey");
  var response = await https.get(url);
  hourlyWeatherData = jsonDecode(response.body);
  ishourlyWeatherData = false;
  notifyListeners(); 
}

//Weekly Weather Api:---------------------------------------------------------------------------------
getWeekWeather(String city) async{
  isweeklyWeatherData = true;
  var url = Uri.parse("https://api.weatherapi.com/v1/forecast.json?q=$city&days=7&key=$apiWeatherKey");
  var response = await https.get(url);
  WeekWeatherData = jsonDecode(response.body);
  isweeklyWeatherData = false;
  notifyListeners(); 
}

//Format Time:-------------------------
String formatTime(String time) {
    DateTime parsedTime = DateTime.parse(time);
    return DateFormat('hh:mm a').format(parsedTime);
  }

//Format Date:-------------------------
 String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy, MMM d').format(parsedDate); // Example: Mon, Dec 30
  } 

String animation(String cloudlines){

if(currentWeatherData.isNotEmpty){
switch(cloudlines.toLowerCase()){
  case "clouds":
    return "assets/images/cloud.json";
  case "clear":
    return "assets/images/clear.json";
  case "rain":
    return "assets/images/rain.json";
  case "drizzle":
    return "assets/images/rain.json";
  case "snow":
    return "assets/images/snow.json";
  case "thunderstorm":
    return "assets/images/thunder_rain.json";
  case "mist":
    return "assets/images/mist.json";
  case "haze":
    return "assets/images/mist.json";
  case "dust":
    return "assets/images/mist.json";
  case "fog":
    return "assets/images/mist.json";
  case "tornado":
    return "assets/images/mist.json";
  default:
    return "assets/images/splash_screen.json";
}
}
else {
    return "assets/images/splash_screen.json";

  }
  
  }


}