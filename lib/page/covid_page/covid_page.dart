import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'covid.dart';

class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  CovidPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    _bloc = CovidPageBloc();
    _bloc.add(LoadCovidDataEvent(isRefresh: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child:
          BlocBuilder<CovidPageBloc, CovidPageState>(builder: (context, state) {
        if (state is GetDataSuccess)
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Số ca nhiễm Covid'),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(10.0),
                  child: TabBar(
                    tabs: [
                      Container(
                          margin: EdgeInsets.all(10), child: Text('Việt Nam')),
                      Container(
                          margin: EdgeInsets.all(10), child: Text('Thế Giới'))
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 0,
                      columns: [
                        DataColumn(
                          label: Expanded(
                              child:
                                  Text("Tỉnh", style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Tử vong",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Bình Phục",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.vN
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(e.provinceName,
                                    style: TextStyle(fontSize: 12)),
                              ),
                              DataCell(
                                Text("${e.confirmed}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                              DataCell(
                                Text("${e.deaths}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                              DataCell(
                                Text("${e.recovered}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 0,
                      columns: [
                        DataColumn(
                          label: Expanded(
                              child: Text("Thế Giới",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Tử vong",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Bình Phục",
                                  style: TextStyle(fontSize: 12))),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.tG
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(
                                  e.provinceName,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataCell(
                                Text("${e.confirmed}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                              DataCell(
                                Text("${e.deaths}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                              DataCell(
                                Text("${e.recovered}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        else
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }),
    );
  }
}
