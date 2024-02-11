// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_/apptexts.dart';
import 'package:http/http.dart' as http;

String CityNames = '';

List<dynamic> weat = [];
List<dynamic> icons = [];
int Maxtemp = 0;
double Mintemp = 0;
String Statetemp = '';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherApState();
}

class _WeatherApState extends State<WeatherApp> {
  void getCityName() async {
    String weatherApiUrl =
        'https://api.weatherbit.io/v2.0/forecast/daily?city=kassel,&key=${Apptext.weatherbitApikey}';

    final joop = await http.get(Uri.parse(weatherApiUrl));
    final body = joop.body;
    final das = jsonDecode(body);
    final data = das['data'];
    final CityName = das['city_name'];
    final icon = das['data'];
    final temps = das['data'][0]['max_temp'];
    final tempm = das['data'][0]['min_temp'];
    final statetemp = das['data'][0]['weather']['description'];

    setState(() {
      weat = data;
      CityNames = CityName;
      icons = icon;
      Maxtemp = temps;
      Mintemp = tempm;
      Statetemp = statetemp;
    });
  }

  Widget texts(String soz,) {
    return Text(
      soz ,
      style: TextStyle(fontSize: 20, ),

    );
  }

  @override
  void initState() {
    super.initState();
    getCityName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            texts('Текущее место:'),
            texts('$CityNames'),
            texts('$Maxtemp'),
            texts('$Mintemp'),
            texts('$Statetemp'),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: weat.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 170,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            texts('${weat[index]['datetime']}' ),
                            // Icon(
                            //   IconData(
                            //       int.parse(icons[index]['weather']['icon']),
                            //       fontFamily: 'R04d'),
                            // ),

                            Image.asset(
                              'assets/images/weather.webp',
                              height: 50,
                              width: 50,
                            ),

                            texts(
                              '${weat[index]['weather']['description']}',
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
