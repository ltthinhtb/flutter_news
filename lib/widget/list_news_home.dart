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
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.3
            )
          ),
          height: 200,
          child: Image.network(
            widget.thumbnail != "" ? widget.thumbnail : "https://topdev.vn/blog/wp-content/uploads/2018/09/7-2-1.jpg" ,
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
                style: TextStyle(fontSize: 12,color: AppTheme.deactivatedText),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.category,
                style: TextStyle(fontSize: 12,color: AppTheme.deactivatedText),
              )
            ],
          ),
        )
      ],
    ));
  }
}
