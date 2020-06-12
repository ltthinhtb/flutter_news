import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder(
          stream: Firestore.instance.collection('questions').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Text(snapshot.data.documents[index]['question']),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot
                                .data.documents[index]['suggest'].length,
                            itemBuilder: (context, int i) {
                              return FlatButton(
                                  onPressed: () {
                                    snapshot.data.documents[index]['suggest'][i]
                                            ['isTrue']
                                        ? _displaySnackBar(
                                            context, "Đáp an đúng")
                                        : _displaySnackBar(
                                            context, "Đap án sai");
                                  },
                                  child: Text(snapshot.data.documents[index]
                                      ['suggest'][i]['anwser']));
                            },
                          )
                        ],
                      ),
                    );
                  });
            else
              return Container(
                child: Text('Không có dữ liệu'),
              );
          },
        ));
  }
}
