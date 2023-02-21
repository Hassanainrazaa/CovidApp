import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:test2/model/world_state_model.dart';
import 'package:test2/services/states_services.dart';
import 'package:test2/view/country_list_screen.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            FutureBuilder(
                future: StateServices().fetchWorldStateRecord(),
                builder: ((context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.09),
                          child: Card(
                            child: Column(
                              children: [
                                reuseableRow(
                                  title: "total",
                                  value: snapshot.data!.cases.toString(),
                                ),
                                reuseableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                reuseableRow(
                                  title: "Death",
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                reuseableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString(),
                                ),
                                reuseableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString(),
                                ),
                                reuseableRow(
                                  title: "Today Death",
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                reuseableRow(
                                  title: "Today Recover",
                                  value:
                                      snapshot.data!.todayRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                })),
            // PieChart(
            //   dataMap: {"Total": 20, "Recovered": 20, "Death": 60},
            //   animationDuration: Duration(milliseconds: 1200),
            //   chartType: ChartType.ring,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: MediaQuery.of(context).size.height * 0.09),
            //   child: Card(
            //     child: Column(
            //       children: [
            //         reuseableRow(
            //           title: "total",
            //           value: "500",
            //         ),
            //         reuseableRow(
            //           title: "total",
            //           value: "500",
            //         ),
            //         reuseableRow(
            //           title: "total",
            //           value: "500",
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.08,
            // ),
            // Container(
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.green, borderRadius: BorderRadius.circular(10)),
            //   child: Center(
            //     child: Text("Track Countries"),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}

class reuseableRow extends StatelessWidget {
  String title;
  String value;
  reuseableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
