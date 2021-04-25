import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:proxyprovider_demo/models/welcome.dart';
import 'package:proxyprovider_demo/services/geolocator_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoservice = GeoLocatorService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context)=>geoservice.getCoords()),
        ProxyProvider<Position,Future<List<Placemark>>>(
          update: (context,position,placemarks)=> (position!=null)?geoservice.getAddress(position):null,
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Welcome(),
      ),
    );
  }
}

