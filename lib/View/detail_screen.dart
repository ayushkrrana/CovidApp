import 'package:covidapp/View/world_states.dart';
import 'package:flutter/material.dart';

//in this we create the detail screen page of the country when we tap on the country
class DetailScreenCountry extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered , active , critical , todayRecovered, test;
   DetailScreenCountry({super.key,
     required this.image,
     required this.name,
   required this.totalCases,
   required this.totalDeaths,
     required this.totalRecovered,
   required this.active,
     required this.critical,
   required this.todayRecovered,
   required this.test});

  @override
  State<DetailScreenCountry> createState() => _DetailScreenCountryState();
}

class _DetailScreenCountryState extends State<DetailScreenCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Stack(// Stack allows the CircleAvatar to sit on top of the Card- so it is used to allow overlap
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height *.06,),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image)
              )
            ],
          )
        ],
      ),

    );
  }
}
