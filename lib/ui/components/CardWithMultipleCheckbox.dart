import 'package:flutter/material.dart';

class CardWithMultipleCheckbox extends StatelessWidget {
  final String title;
  final double height;
  final List<Widget> children;

  CardWithMultipleCheckbox({this.title, this.height, this.children});
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    double screenWidth;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    return Card(
      elevation: 4,
      color: Colors.grey[200],
      borderOnForeground: false,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.grey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            padding: EdgeInsets.all(5.0),
            width: double.infinity,
            child: Container(
              width: screenWidth * 0.77,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: height,
            padding: EdgeInsets.all(8),
            child: Scrollbar(
              isAlwaysShown: false,
              controller: _scrollController,
              child: ListView(children: children),
            ),
          )
        ],
      ),
    );
  }
}
