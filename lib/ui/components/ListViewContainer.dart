import 'package:flutter/material.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';
import 'List.dart';
import 'Calender.dart';

class ListViewContent extends StatelessWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;
  ListViewContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });
  @override
  Widget build(BuildContext context) {
    return (new Stack(
      alignment: listSlideAnimation.value,
      children: <Widget>[
        new Calender(margin: listSlidePosition.value * 6.5),
        new ListData(
            margin: listSlidePosition.value * 5.5,
            width: listTileWidth.value,
            title: "Yoga classes with Emily",
            subtitle: "7 - 8am Workout",
            image: avatar6),
        new ListData(
            margin: listSlidePosition.value * 4.5,
            width: listTileWidth.value,
            title: "Breakfast with Harry",
            subtitle: "9 - 10am ",
            image: avatar1),
        new ListData(
            margin: listSlidePosition.value * 3.5,
            width: listTileWidth.value,
            title: "Meet Pheobe ",
            subtitle: "12 - 1pm  Meeting",
            image: avatar5),
        new ListData(
            margin: listSlidePosition.value * 2.5,
            width: listTileWidth.value,
            title: "Lunch with Janet and friends",
            subtitle: "2 - 3pm ",
            image: avatar4),
        new ListData(
            margin: listSlidePosition.value * 1.5,
            width: listTileWidth.value,
            title: "Catch up with Tom",
            subtitle: "5 - 6pm  Hangouts",
            image: avatar2),
        new ListData(
            margin: listSlidePosition.value * 0.5,
            width: listTileWidth.value,
            title: "Party at Hard Rock",
            subtitle: "8 - 12 Pub and Restaurant",
            image: avatar3),
      ],
    ));
  }
}
