import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/Utils/apptheme.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.thumbnail != "" ? widget.thumbnail : "https://topdev.vn/blog/wp-content/uploads/2018/09/7-2-1.jpg" ,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.lead, style: TextStyle(fontSize: 13),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "4 giờ trước",
              style: TextStyle(color: AppTheme.deactivatedText,fontSize: 11),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.category,
              style: TextStyle(color: AppTheme.deactivatedText,fontSize: 11),
            )
          ],
        )
      ],
    ));
  }
}
