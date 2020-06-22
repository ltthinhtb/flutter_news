import 'package:flutter/material.dart';
import 'package:flutter_news/Utils/apptheme.dart';

class CustomListItem extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String author;
  final String publishDate;
  final String category;

  CustomListItem({
    Key key,
    @required this.thumbnail,
    @required this.title,
    @required this.author,
    @required this.publishDate,
    this.category,
  }) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                //width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(widget.thumbnail != ""
                        ? widget.thumbnail
                        : "https://yt3.ggpht.com/a/AATXAJyPMywRmD62sfK-1CXjwF0YkvrvnmaaHzs4uw=s900-c-k-c0xffffffff-no-rj-mo")),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.category,
                          style: TextStyle(color: AppTheme.deactivatedText,fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Text(widget.publishDate,
                        style: TextStyle(color: AppTheme.deactivatedText,fontSize: 12)),
                  )
                ],
              ))
            ],
          )),
    );
  }
}
