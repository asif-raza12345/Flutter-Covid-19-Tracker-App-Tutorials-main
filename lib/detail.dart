
import 'package:covid_tracker/worldstatescreen.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {

  String name;
  String image;
  int todayCases,deaths, todayDeaths,recovered,todayRecovered,active,critical;
  DetailScreen({
    required this.name,
    required this.image,
    required this.todayRecovered,
    required this.deaths,
    required this.todayDeaths,
    required this.todayCases,
    required this.critical,
    required this.active,
    required this.recovered,

  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.name),
          centerTitle: true,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReusableRow(title: 'Today case', value:widget.todayCases.toString()),
                      ReusableRow(title: 'Today Recovered', value:widget.todayRecovered.toString()),
                      ReusableRow(title: 'Today Deaths', value:widget.todayDeaths.toString()),
                      ReusableRow(title: 'Total Deaths', value:widget.deaths.toString()),
                      ReusableRow(title: 'Today Recovered', value:widget.todayRecovered.toString()),
                      ReusableRow(title: 'Critical', value:widget.critical.toString()),


                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      )

    );
  }
}
