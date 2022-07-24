import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Component/Constant/WeatherCondition/weathercondition.dart';
import 'package:weather_app/Component/Constant/constanstyle.dart';
import 'package:weather_app/Model/weathermodel.dart';
import 'package:weather_app/Services/location_service.dart';
import 'package:weather_app/Services/network.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/View/forecastscreen.dart';
import 'package:weather_app/View/searchscreen.dart';
class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}
class _WeatherAppState extends State<WeatherApp> {
  LocationService locationService = LocationService();
  NetworkCall networkCall = NetworkCall();
  WeatherStatus weatherStatus = WeatherStatus();
  Constantstyle constantstyle = Constantstyle();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff3AB0FF), Color(0xff66BFBF)],
        )),
        child: FutureBuilder<Wathermodel>(
          future: networkCall.getWeather(),
          builder: (context, AsyncSnapshot<Wathermodel> asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff3AB0FF), Color(0xff66BFBF)],
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const SearchScreen())));
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    size: 28,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Text(asyncSnapshot.data!.name,
                              style: Constantstyle.titleconststyle),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(asyncSnapshot.data!.weather[0].description,
                              style: Constantstyle.nameconststyle),
                          const SizedBox(
                            height: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 10,
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    weatherStatus.getWeatherIcon(
                                        asyncSnapshot.data!.weather[0].id),
                                    style: const TextStyle(fontSize: 80),
                                  ),
                                  Text(
                                    "${asyncSnapshot.data!.main.temp.toString()}°c",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white54),
                              height: 200,
                              width: 200,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                              weatherStatus.getMessage(
                                  asyncSnapshot.data!.main.temp.toInt()),
                              style: Constantstyle.nameconststyle),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Wild Status",
                                      style: Constantstyle.detailtextstyle,
                                    ),
                                    Text(
                                      "${asyncSnapshot.data!.wind.speed.toString()} mps",
                                      style: Constantstyle.detailtextstyle1,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Humidity",
                                      style: Constantstyle.detailtextstyle,
                                    ),
                                    Text(
                                      "${asyncSnapshot.data!.main.humidity.toString()} %",
                                      style: Constantstyle.detailtextstyle1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "visibility",
                                      style: Constantstyle.detailtextstyle,
                                    ),
                                    Text(
                                      "${asyncSnapshot.data!.visibility} m",
                                      style: Constantstyle.detailtextstyle1,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Air pressure",
                                      style: Constantstyle.detailtextstyle,
                                    ),
                                    Text(
                                      "${asyncSnapshot.data!.main.pressure.toString()} mph",
                                      style: Constantstyle.detailtextstyle1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return const ForecastScreen();
                              })));
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Center(
                                  child: Text(
                                "View forecast",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                              )),
                            ),
                          )
                        ],
                      ),
                    );
                  }));
            }
            if (asyncSnapshot.hasError) {
              return const Center(child: Text("please something went wrong"));
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const SpinKitPouringHourGlassRefined(color: Colors.black),
                      Text("Loading...",style:Constantstyle.nameconststyle,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
