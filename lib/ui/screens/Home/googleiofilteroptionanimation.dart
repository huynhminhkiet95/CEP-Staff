import 'package:flutter/material.dart';

class ListTileWithPopupMenuButton extends StatefulWidget {
  @override
  _ListTileWithPopupMenuButtonState createState() => new _ListTileWithPopupMenuButtonState();
}

class _ListTileWithPopupMenuButtonState extends State<ListTileWithPopupMenuButton> {
  /// Holds the selected lucky number.
  int selectedLuckyNumber;

  /// A list of lucky numbers.
  List<int> luckyNumbersList = [7, 69, 420, 100];

  /// The key for the PopUpMenButton. Basically it's a reference to the button,
  /// i.e we can control the Menu by using this key as done below.
  final GlobalKey _menuKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lucky Number selector",),
      ),
      body: new Center(
        child: _buildListTile()),
    );

  }

  /// Builds a ListTile containing a PopupMenuButton.
  Widget _buildListTile(){

    /// The list containing the [PopUpMenuItem]s
    List<PopupMenuItem> luckyNumbers = [];

    // Add each luckyNumber name into the list of PopupMenuItems, [luckyNumbers]
    for (int luckyNumber in luckyNumbersList) {
      luckyNumbers.add(
        new PopupMenuItem(
          child: new Text("$luckyNumber"),
          value: luckyNumber,
        )
      );
    }

    /// When a [PopUpMenuItem] is selected, we assign its value to
    /// selectedLuckyNumber and rebuild the widget.
    void handlePopUpChanged(int value) {
      setState(() {
        selectedLuckyNumber =  value;
      });
      /// Log the selected lucky number to the console.
      print("The lucky number you selected was $selectedLuckyNumber");
    }

    return new ListTile(
      /// The leading widget is a text widget displaying the [selectedLuckyNumber];
      /// this is to show off the statefulness of this class ;p
      leading: new Text(selectedLuckyNumber.toString()),
      /// The title of the list tile.
      title: new Text("Your lucky number"),
      trailing: new PopupMenuButton(
        key: _menuKey,
        onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem),
        itemBuilder: (BuildContext context) => luckyNumbers,
        tooltip: "Tap me to select a number.",
      ),
      /// When ListTile is tapped, open the popUpMenuButton! Notice how we use
      /// menuKey to do that.
      onTap: () {
        dynamic popUpMenustate = _menuKey.currentState;
        popUpMenustate.showButtonMenu();
      },
    );
  }

}