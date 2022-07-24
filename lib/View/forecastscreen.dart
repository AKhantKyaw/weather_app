import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Component/Constant/WeatherCondition/weathercondition.dart';
import 'package:weather_app/Component/Constant/constanstyle.dart';
import 'package:weather_app/Model/forecastmodel.dart';
import 'package:weather_app/Services/network.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  NetworkCall networkCall = NetworkCall();
  WeatherStatus weatherStatus = WeatherStatus();
  DateFormat dateFormat = DateFormat("HH:mm");
  final DateFormat _dateFormat = DateFormat.yMMMEd();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffA6D1E6),
      ),
      backgroundColor: const Color(0xffA6D1E6),
      body: FutureBuilder<Forecastmodel>(
          future: networkCall.getforecast(),
          builder: ((context, AsyncSnapshot<Forecastmodel> asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xff2C3333),
                                  borderRadius: BorderRadius.circular(20)),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Forecast for today",
                                    style: Constantstyle.nameconststyle,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            dateFormat.format(asyncSnapshot
                                                .data!.list[0].dtTxt),
                                            style: Constantstyle.defulttextstyle,
                                          ),
                                          Text(
                                            weatherStatus.getWeatherIcon(
                                                asyncSnapshot
                                                    .data!.list[0].weather[0].id),
                                            style: Constantstyle.icontextstyle,
                                          ),
                                          Text(
                                            "${asyncSnapshot.data!.list[0].main.temp.toString()}°c",
                                            style: Constantstyle.defulttextstyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            dateFormat.format(asyncSnapshot
                                                .data!.list[1].dtTxt),
                                            style: Constantstyle.defulttextstyle,
                                          ),
                                          Text(
                                            weatherStatus.getWeatherIcon(
                                                asyncSnapshot
                                                    .data!.list[1].weather[0].id),
                                            style: Constantstyle.icontextstyle,
                                          ),
                                          Text(
                                            "${asyncSnapshot.data!.list[1].main.temp.toString()}°c",
                                            style: Constantstyle.defulttextstyle,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            dateFormat.format(asyncSnapshot
                                                .data!.list[2].dtTxt),
                                            style: Constantstyle.defulttextstyle,
                                          ),
                                          Text(
                                            weatherStatus.getWeatherIcon(
                                                asyncSnapshot
                                                    .data!.list[2].weather[0].id),
                                            style: Constantstyle.icontextstyle,
                                          ),
                                          Text(
                                            "${asyncSnapshot.data!.list[2].main.temp.toString()}°c",
                                            style: Constantstyle.defulttextstyle,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: const Color(0xff2C3333),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "5 days Forecast",
                                    style: Constantstyle.nameconststyle,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _dateFormat.format(
                                          asyncSnapshot.data!.list[0].dtTxt,
                                        ),
                                        style: Constantstyle.detailtextstyle1,
                                      ),
                                      Text(
                                        asyncSnapshot
                                            .data!.list[0].weather[0].description,
                                        style: Constantstyle.defulttextstyle,
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _dateFormat.format(
                                          asyncSnapshot.data!.list[5].dtTxt,
                                        ),
                                        style: Constantstyle.detailtextstyle1,
                                      ),
                                      Text(
                                        asyncSnapshot
                                            .data!.list[5].weather[0].description,
                                        style: Constantstyle.defulttextstyle,
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _dateFormat.format(
                                          asyncSnapshot.data!.list[14].dtTxt,
                                        ),
                                        style: Constantstyle.detailtextstyle1,
                                      ),
                                      Text(
                                        asyncSnapshot.data!.list[14].weather[0]
                                            .description,
                                        style: Constantstyle.defulttextstyle,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _dateFormat.format(
                                          asyncSnapshot.data!.list[24].dtTxt,
                                        ),
                                        style: Constantstyle.detailtextstyle1,
                                      ),
                                      Text(
                                        asyncSnapshot.data!.list[24].weather[0]
                                            .description,
                                        style: Constantstyle.defulttextstyle,
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _dateFormat.format(
                                          asyncSnapshot.data!.list[37].dtTxt,
                                        ),
                                        style: Constantstyle.detailtextstyle1,
                                      ),
                                      Text(
                                        asyncSnapshot.data!.list[37].weather[0]
                                            .description,
                                        style: Constantstyle.defulttextstyle,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                  )));
            } else if (asyncSnapshot.hasError) {
              return const Center(child: Text("Forecast is not alivaliable"));
            }
            return const Center(
                child: SpinKitPouringHourGlassRefined(
              color: Colors.black,
            ));
          })),
    );
  }
}
