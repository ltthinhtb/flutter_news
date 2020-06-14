import 'package:flutter/material.dart';

class ListNewsHome extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String publishDate;
  final String category;
  final String lead;

  ListNewsHome({
    Key key,
    @required this.thumbnail,
    @required this.title,
    this.publishDate,
    this.category, this.lead,
  }) : super(key: key);

  @override
  _ListNewsHomeState createState() => _ListNewsHomeState();
}

class _ListNewsHomeState extends State<ListNewsHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 200,
                child: Image.network(
                  widget.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(widget.lead,style: TextStyle(fontSize: 13),),
              Row(
                children: [
                  Text("4h trước"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Thế giới")
                ],
              )
            ],
          )),
    );
  }
}
