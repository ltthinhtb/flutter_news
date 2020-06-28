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
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(75),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_bloc.isDark ? "assets/bg_appbar.png" : "assets/bg_appbar_light.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                  child: AppBar(
                    backgroundColor: Color.fromRGBO(255, 255, 255, _bloc.isDark ? 0 : 0.3),
                    automaticallyImplyLeading: false,
                    title:  Center(
                      child: Container(
                        child: PreferredSize(
                          preferredSize: Size.fromHeight(20),
                          child: Text("Thông tin Covid 19", style: TextStyle(fontWeight: FontWeight.w500, color: _bloc.isDark ? Colors.white : Colors.black87),),
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(10.0),
                      child: TabBar(
                        tabs: [
                          Container(
                              margin: EdgeInsets.all(10), child: Text('Việt Nam' , style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),)),
                          Container(
                              margin: EdgeInsets.all(10), child: Text('Thế Giới', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,)))
                        ],
                      ),
                    ),
                  ),
                )
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
                                  Text("Tỉnh", style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Tử vong",
                                  style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Bình Phục",
                                  style: ts)),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.vN
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(e.provinceName,
                                    style: ts),
                              ),
                              DataCell(
                                Text("${e.confirmed}",
                                    style: ts),
                              ),
                              DataCell(
                                Text("${e.deaths}",
                                    style: ts),
                              ),
                              DataCell(
                                Text("${e.recovered}",
                                    style: ts),
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
                                  style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Số ca nhiễm",
                                  style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Tử vong",
                                  style: ts)),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Expanded(
                              child: Text("Bình Phục",
                                  style: ts)),
                          numeric: false,
                        ),
                      ],
                      rows: _bloc.tG
                          .map(
                            (e) => DataRow(cells: [
                              DataCell(
                                Text(
                                  e.provinceName,
                                  style: ts,
                                ),
                              ),
                              DataCell(
                                Text("${e.confirmed}",
                                    style: ts),
                              ),
                              DataCell(
                                Text("${e.deaths}",
                                    style: ts),
                              ),
                              DataCell(
                                Text("${e.recovered}",
                                    style: ts),
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
  TextStyle ts = TextStyle(fontSize: 13);
}
