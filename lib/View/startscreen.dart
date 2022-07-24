import 'package:flutter/material.dart';
import 'package:weather_app/Component/Constant/constanstyle.dart';
import 'package:weather_app/Services/location_service.dart';
import 'package:weather_app/Services/network.dart';
import 'package:weather_app/View/weatherscreen.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({Key? key}) : super(key: key);
  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  NetworkCall networkCall = NetworkCall();
  LocationService locationService = LocationService();
  @override
  void initState() {
    locationService.initLocationCheck();
    networkCall.getWeather();
    networkCall.getforecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.blue],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Weather Condition",
              style: Constantstyle.defulttextstyle,
            ),
            Image.asset("images/weatherpicture.jpeg"),
            Text(
              "Find Your weather\nPredictions in your City",
              style: Constantstyle.defulttextstyle,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherApp(),
                    ),
                    (route) => false);
              },
              child: const Text(
                "Get start",
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(300, 40)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
