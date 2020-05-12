import 'package:flutter/material.dart';

class CustomListItem extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String url;
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
    this.url,
  }) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SizedBox(
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                child: Image.network(widget.thumbnail),
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
                              widget.author,
                              style: TextStyle(),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              widget.category,
                              style: TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Text(widget.publishDate,
                            style: TextStyle(color: Colors.grey)),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
