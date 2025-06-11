import 'package:covidapp/Model/WorldStatsModel.dart';
import 'package:covidapp/Services/stats_services.dart';
import 'package:covidapp/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller
        .dispose(); // once our screen is loaded completely we dispose the controller to make sure that it is not connected with some other page
  }

  final colorList = <Color>[Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(// FutureBuilder is a widget used to handle asynchronous operations, particularly when dealing with Future objects, and update the UI accordingly
                future: statsServices.fetchWorldRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // always try to use connection state rather than has data because has data can sometimes cause infinite loading
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );

                  } else if(snapshot.hasData && snapshot.data!=null) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .01),
                          PieChart(
                            dataMap: {
                              "Total Infected": double.parse(snapshot.data!.cases.toString()), //pie chart accepts the double values
                              "Total Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Total Deaths": double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            animationDuration: Duration(seconds: 2),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width / 2.5,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * .06,
                            ), //It gets the total height of the device screen (in logical pixels).For example, on a device with 800 logical pixels height:800 * 0.06 = 48,So your vertical padding becomes 48 pixels on the top and bottom.(so it will add a vertical height of 48 pixel , use of media query is important because it make our ui responsive according to the different screen sizes
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5, // It provided a fixed size to the listview such that it can only scrollable up to this height
                              child: Card(
                                child: ListView(
                                  children: [
                                    ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: 'Total Recovered', value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: 'Total Deaths', value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: 'Total Active Cases', value: snapshot.data!.active.toString()),
                                    ReusableRow(title: 'Critical Cases', value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                    ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                    ReusableRow(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //10th june - complete the whole api and http and from 11 to 17 complete the getx mvvm and from 17 onwards sqlite and firebase
                          Center(
                            child: Container(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: Center(
                                  child: Text('Track Countries'),
                                ), // we have to wrap the text with the center widget to increase the size of our button
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return Center(child: Text('NO data found'));
                  }
                },
              ),
          ),
        ),
      );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            /*
       Column
        └── Row → Title        Value
        └── Row → Title        Value
        └── Row → Title        Value  - that's why we put row inside the column and put space between because to give a space between the value and the title
      */
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
