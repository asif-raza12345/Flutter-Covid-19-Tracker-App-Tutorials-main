import 'package:covid_tracker/Model/Worldstatemodel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Services/states_services.dart';
import 'View/countrielist.dart';

class WorldststeScrreen extends StatefulWidget {
  const WorldststeScrreen({Key? key}) : super(key: key);
  @override
  State<WorldststeScrreen> createState() => WorldstateScreen();
}

class WorldstateScreen extends State<WorldststeScrreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices worldstate = StateServices();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: worldstate
                        .fetchWorldStatesRecord(), // Corrected method call
                    builder: (context, AsyncSnapshot<Worldstatemodel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 22,
                            controller: controller,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                                legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left,

                                ),
                                dataMap: {
                                  "Total": double.parse(
                                      snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(
                                      snapshot.data!.recovered!.toString()),
                                  "Death": double.parse(
                                      snapshot.data!.deaths!.toString()),
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                // animationDuration: const Duration(microseconds: 1200),
                                chartType: ChartType.disc,
                                colorList: const [
                                  Colors.red,
                                  Colors.green,
                                  Colors.black
                                ]),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: "Today Case",
                                        value:
                                            snapshot.data!.todayCases.toString()),
                                    ReusableRow(
                                        title: "Today Death",
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReusableRow(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                    ReusableRow(
                                        title: "Total",
                                        value: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        title: "Death",
                                        value: snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        title: "Active",
                                        value: snapshot.data!.active.toString()),
                                    ReusableRow(
                                        title: "Recovered",
                                        value:
                                            snapshot.data!.recovered.toString()),
                                    ReusableRow(
                                        title: "Critical",
                                        value:
                                            snapshot.data!.critical.toString()),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesListScreen()));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    const Center(child: Text('Track Countries')),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatefulWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              Text(widget.value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
