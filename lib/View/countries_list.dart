import 'package:covidapp/Services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:http/http.dart' as http;

import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController(); // We create this controller so that we can search the countries by their name easily

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices =
        StatsServices(); // we have to write the class to call the api function
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // this set the elevation to zero and the app bar appears to be flat
        backgroundColor: Theme.of(context,).scaffoldBackgroundColor, //This sets the background color of the widget (like AppBar, Card, etc.) to match the overall screen's background color.
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search with Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(// future builder require future data which come from future api model to rebuild its UI according to the data
                future: statsServices.countriesNamesFetch(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 10, // number of shimmer items to show
                      itemBuilder: (context, index) {
                        return Shimmer(
                          duration: Duration(seconds: 2),
                          interval: Duration(seconds: 2),
                          color: Colors.grey.shade300,
                          colorOpacity: 0,
                          enabled: true,
                          direction: ShimmerDirection.fromLTRB(),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: Colors.grey.shade400,
                            ),
                            title: Container(
                              height: 10,
                              width: double.infinity,
                              color: Colors.grey.shade400,
                              margin: EdgeInsets.only(bottom: 5),
                            ),
                            subtitle: Container(
                              height: 10,
                              width: double.infinity, //It means "take all the horizontal space available in the parent widget.
                              color: Colors.grey.shade400,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length, //it display the whole length of the raw json data
                      itemBuilder: (context, index) {
                        String name=snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreenCountry(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'],


                                  )));
                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(),), // we convert this to string because cases are in integer in the POSTMAN API
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                  ), //Each square bracket is diving one level deeper into the map.
                                  //Because you didn’t create a model, Dart doesn’t know the types — so you have to navigate the JSON manually using key strings.
                                ),
                              ),
                            ],
                          );
                        }
                        else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreenCountry(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'],
                                  )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ), // we convert this to string because cases are in integer in the POSTMAN API
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                  ), //Each square bracket is diving one level deeper into the map.
                                  //Because you didn’t create a model, Dart doesn’t know the types — so you have to navigate the JSON manually using key strings.
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Text('Some Error Has Occurred');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
