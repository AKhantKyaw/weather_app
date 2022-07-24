import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Component/Constant/WeatherCondition/weathercondition.dart';
import 'package:weather_app/Component/Constant/constanstyle.dart';
import 'package:weather_app/Model/errormdel.dart';
import 'package:weather_app/Model/weathermodel.dart';
import 'package:weather_app/Services/network.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  NetworkCall networkCall = NetworkCall();
  WeatherStatus weatherStatus = WeatherStatus();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Search City"),
          backgroundColor: Color(0xff34B3F1),
          elevation: 0,
          bottom: PreferredSize(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 12, bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: TextFormField(
                        
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some city name';
                          }
                          return null;
                        },
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                            hintText: 'Search for city',
                            contentPadding: EdgeInsets.only(left: 24.0),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          networkCall.searchcity(controller.text);
                        });
                      })
                ],
              ),
              preferredSize: const Size.fromHeight(55)),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff3AB0FF), Color(0xff66BFBF)],
          )),
          child: FutureBuilder<Wathermodel>(
            future: networkCall.searchcity(controller.text),
            builder: (context, AsyncSnapshot<Wathermodel> asyncSnapshot) {
              if(asyncSnapshot.connectionState == ConnectionState.waiting){
                return  Center(child:  SpinKitPouringHourGlassRefined(color: Colors.black,));
              }
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
                                          color: Colors.black, fontSize: 25),
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
                          ],
                        ),
                      );
                    }));
              } else if (asyncSnapshot.hasError) {
                return FutureBuilder<Errormodel>(
                    future: networkCall.geterror(controller.text),
                    builder:
                        ((context, AsyncSnapshot<Errormodel> asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    asyncSnapshot.data!.cod,
                                    style: Constantstyle.defulttextstyle,
                                  ),
                                  Text(
                                    asyncSnapshot.data!.message,
                                    style: Constantstyle.defulttextstyle,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return Center(
                          child: Text(
                        "please write some city name",
                        style: Constantstyle.defulttextstyle,
                      ));
                    }));
              }
              return const Center(
                  child: SpinKitWanderingCubes(color: Colors.redAccent));
            },
          ),
        ),
      ),
    );
  }
}
