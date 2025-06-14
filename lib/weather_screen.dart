import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> futureWeather;
 
  Future<Map<String, dynamic>> getCurrentWeather() async{

    try {
  String cityName = 'Mumbai';
  final res = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,in&APPID=043924e569fd81125b7cff08617a3545'
      ),
    );
    final data = jsonDecode(res.body);
    if (data['cod'] != '200') {
      throw 'An unexpected error occurred';
    }
    
       //data['list'][0]['main']['temp'] - 273.15;
    
    return data;
} catch (e) {
  throw e.toString();
}
  }

@override
  void initState() {
    super.initState();
    futureWeather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        centerTitle: true,
        
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                
              });
            },
            icon: const Icon(Icons.refresh),
            iconSize: 27,
          ),
          
        ],
        flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 16.0, top:78),
            child: Text(DateFormat.MMMd().format(DateTime.now()), 
                    style: const TextStyle(
            fontSize: 15
            
            ),
                    ),
          )
        
      ),
      body:FutureBuilder(
        future: futureWeather,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child:  CircularProgressIndicator.adaptive());
                          }
        
                          if (snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()));
                          }
                          
                          final data = snapshot.data!;
                          final currentTemp = data['list'][0]['main']['temp'] - 273.15;
                          final currentSky = data['list'][0]['weather'][0]['main'];
                          final currentPressure = data['list'][0]['main']['pressure']; 
                          final currentWindSpeed = data['list'][0]['wind']['speed'];
                          final currentHumidity = data['list'][0]['main']['humidity'];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      // child: FutureBuilder(
                      //   future: getCurrentWeather(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState == ConnectionState.waiting){
                      //       return const Center(child:  CircularProgressIndicator.adaptive());
                      //     }
        
                      //     if (snapshot.hasError){
                      //       return Center(child: Text(snapshot.error.toString()));
                      //     }
        
                      //     final data = snapshot.data!;
                      //     final currentTemp = data['list'][0]['main']['temp'] - 273.15;
                      //     final currentSky = data['list'][0]['weather'][0]['main'];
                      //     final currentPressure = data['list'][0]['main']['pressure']; 
                          
                          child: Padding(
                          padding:const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              //main text child 1
                              Text(
                                '${currentTemp.toStringAsFixed(2)} °C',
                                style:  const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                               const SizedBox(
                                height: 16,
                              ),
                              //icon child 2
                              Icon(
                                
                                currentSky == 'Clouds'
                                ? Icons.cloud
                                : currentSky == 'Rain'
                                    ? FontAwesomeIcons.cloudRain
                                    : Icons.sunny,
                                size: 64),
                              const SizedBox(
                                height: 16,
                              ),
                              //subtext child 3
                              Text(
                                currentSky,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        )
                        
                      
                    ),
                  ),
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
              //weather forecast cards
              const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              // const SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       //1
              //       HourlyForecastItem(icon:FontAwesomeIcons.cloudRain, data:"21°C", time:"03:00"),
        
              //       //2
              //       HourlyForecastItem(icon:Icons.cloudy_snowing, data:"24°C", time:"06:00"),
        
              //       //3
              //       HourlyForecastItem(icon:FontAwesomeIcons.cloudMoon, data:"28°C", time:"09:00"),
        
              //       //4
              //       HourlyForecastItem(icon:Icons.cloudy_snowing, data:"31°C", time:"12:00"),
        
              //       //5
              //       HourlyForecastItem(icon:Icons.sunny, data:"30°C", time:"15:00"),
        
              //       //6
              //       HourlyForecastItem(icon:Icons.cloud, data:"28°C", time:"18:00"),
        
              //       //7
              //       HourlyForecastItem(icon:Icons.thunderstorm, data:"25°C", time:"21:00"),
        
              //       //8
              //       HourlyForecastItem(icon:FontAwesomeIcons.smog, data:"23°C", time:"00:00"),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: 135,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    
                    final hourlyForecast = data['list'][index+1];
                    final hourlySky = hourlyForecast['weather'][0]['main'];
                    final hourlyTemp = hourlyForecast['main']['temp'] - 273.15;
                    final time =  DateTime.parse(hourlyForecast['dt_txt']);
                    return HourlyForecast(
                      time: DateFormat.Hm().format(time),
                      data: hourlyTemp.toStringAsFixed(2) + '°C',
                      icon:   
                                    hourlySky == 'Clouds'
                                    ? Icons.cloud
                                    : hourlySky == 'Rain'
                                        ? FontAwesomeIcons.cloudRain
                                        : Icons.sunny,
                                    
                                  
                
                    );
                    
                  },
                ),
              ),
              const SizedBox(
                
                height: 30,
              ),
              //additional information
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16,),
              
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: [  Column(
                  
                  children: [
                    const Icon(Icons.water_drop, size: 48,),
                    const SizedBox(height: 8,),
                    const Text(
                      "Humidity",
                      style: TextStyle(
                        fontSize: 18,
                        
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      "$currentHumidity",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              
                
                 Column(
                  children: [
                    const Icon(Icons.air, size: 48,),
                    const SizedBox(height: 8,),
                    const Text(
                      "Wind Speed",
                      style:  TextStyle(
                        fontSize: 18,
                        
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      "$currentWindSpeed",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        
                
                Column(
                  children: [
                    const Icon(Icons.shield, size: 48,),
                    const SizedBox(height: 8,),
                    const Text(
                      'Pressure',
                      style: TextStyle(
                        fontSize: 18,
                        
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      "$currentPressure",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ]
              )
            ],
          ),
        );
        }
      ),
    );
  }
}



class HourlyForecast extends StatelessWidget {
  final IconData icon;
  final String time;
  final String data;
  const HourlyForecast({
    super.key,
    required this.icon,
    required this.time,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Column(
          children: [
            Text(
              maxLines: 1,
              time,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(icon, size: 32),
            const SizedBox(
              height: 10,
            ),
            Text(
              data,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



