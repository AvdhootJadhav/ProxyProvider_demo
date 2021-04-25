import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Future<List<Placemark>>>(context);
    final position = Provider.of<Position>(context);
    return FutureProvider(
      create: (context)=>address,
      child: Scaffold(
        body: (address!=null)?
        Consumer<List<Placemark>>(
          builder: (context,addressList,widget){
            return (addressList!=null)?
            _buildList(position, addressList[0]):
            Center(child: CircularProgressIndicator(),);  
          },
        ):
        Center(child: CircularProgressIndicator(),),
      )
      );
  }
}

Widget _buildList(Position position, Placemark placemark){
  return ListView(
    children: [
      ListTile(
        title: Text("Your location", style: TextStyle(fontSize: 17),),
      ),
      ListTile(
        title: Text("Latitude", style: TextStyle(fontSize: 17),),
        trailing: Text(position.latitude.toString()),
      ),
      ListTile(
        title: Text("Longitude", style: TextStyle(fontSize: 17),),
        trailing: Text(position.longitude.toString()),
      ),
      ListTile(
        title: Text("Speed m/s", style: TextStyle(fontSize: 17),),
        trailing: Text(position.speed.toString()),
      ),
      ListTile(
        title: Text("City", style: TextStyle(fontSize: 17),),
        trailing: Text(placemark.locality),
      ),
      ListTile(
        title: Text("Country", style: TextStyle(fontSize: 17),),
        trailing: Text(placemark.country),
      ),
      
    ],
  );
}