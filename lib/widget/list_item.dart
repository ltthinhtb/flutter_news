import 'package:flutter/material.dart';

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
      child: SizedBox(
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3)
                ),
                height: 80,
                //width: 100,
                child: Image.network(widget.thumbnail != "" ? widget.thumbnail : "https://yt3.ggpht.com/a/AATXAJyPMywRmD62sfK-1CXjwF0YkvrvnmaaHzs4uw=s900-c-k-c0xffffffff-no-rj-mo"),
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
