import 'package:covid_tracker/detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states_services.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController Searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateservices = StateServices();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
                controller: Searchcontroller,
                onChanged: (value){
              setState(() {

              });
            },
                decoration: InputDecoration(
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)))),
          ),
          Expanded(
              child: FutureBuilder(
                  future: stateservices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapShot) {


                    if (!snapShot.hasData) {

                      return ListView.builder(
                        itemCount:4,
                          itemBuilder: (context,index){
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,width: 89,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                  leading:Container(height: 10,width: 50,color: Colors.white,) ,
                                )
                              ],
                            ),
                          );
                          }
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                        String name = snapShot.data![index]['country'];
                          if(Searchcontroller.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(

                                      image:snapShot.data![index]['countryInfo']['flag'],
                                      name: snapShot.data![index]['country'],
                                      todayCases: snapShot.data![index]['cases'],
                                      todayDeaths: snapShot.data![index]['todayDeaths'],
                                      critical: snapShot.data![index]['critical'],
                                      deaths: snapShot.data![index]['critical'],
                                      todayRecovered: snapShot.data![index]['todayRecovered'],
                                      active: snapShot.data![index]['active'],
                                      recovered: snapShot.data![index]['recovered'],

                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapShot.data![index]['country']),
                                    subtitle: Text(snapShot.data![index]['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapShot
                                          .data![index]['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }else if(name.toLowerCase().contains(Searchcontroller.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(

                                      image:snapShot.data![index]['countryInfo']['flag'],
                                      name: snapShot.data![index]['country'],
                                      todayCases: snapShot.data![index]['cases'],
                                      todayDeaths: snapShot.data![index]['todayDeaths'],
                                      critical: snapShot.data![index]['critical'],
                                      deaths: snapShot.data![index]['critical'],
                                      todayRecovered: snapShot.data![index]['todayRecovered'],
                                      active: snapShot.data![index]['active'],
                                      recovered: snapShot.data![index]['recovered'],

                                    )));
                                  },
                                  child: ListTile(
                                    title: Text(snapShot.data![index]['country']),
                                    subtitle: Text(snapShot.data![index]['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapShot
                                          .data![index]['countryInfo']['flag']),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                             return Container();
                          }
                          return null;

                          }
                      );
                    }
                  }
                  )
          )
        ]));
  }
}
