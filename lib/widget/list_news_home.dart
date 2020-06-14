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
    this.category,
    this.lead,
  }) : super(key: key);

  @override
  _ListNewsHomeState createState() => _ListNewsHomeState();
}

class _ListNewsHomeState extends State<ListNewsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            widget.lead,
            style: TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Text(
                "4h trước",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Thế giới",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ],
    ));
  }
}
