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
                title: Text('Số ca nhiễm Covid'),
                bottom: TabBar(
                  tabs: [Text('Việt Nam'), Text('Thế Giới')],
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Expanded(
                              child:
                                  Text("Tỉnh", style: TextStyle(fontSize: 16))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: TextStyle(fontSize: 16))),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.vN
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(e.provinceName),
                              ),
                              DataCell(
                                Text("${e.confirmed}"),
                              ),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Expanded(
                              child: Text("Thế Giới",
                                  style: TextStyle(fontSize: 16))),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: TextStyle(fontSize: 16))),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.tG
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(e.provinceName),
                              ),
                              DataCell(
                                Text("${e.confirmed}"),
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
