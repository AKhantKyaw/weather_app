import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/Component/Constant/constanstyle.dart';
import 'package:weather_app/View/startscreen.dart';

class Checknetwork extends StatefulWidget {
  const Checknetwork({Key? key}) : super(key: key);

  @override
  State<Checknetwork> createState() => _ChecknetworkState();
}

class _ChecknetworkState extends State<Checknetwork> {
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const StartedScreen(),
              ),
              (route) => false);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data \n Repress again";
      });
    }
  }

  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff34B3F1),
      body: Column(
        
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: SvgPicture.asset("images/serverdown.svg")),
            Text(T,style: Constantstyle.titleconststyle,)
        ],
      ),
    );
  }
}
