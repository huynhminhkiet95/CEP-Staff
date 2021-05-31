import 'package:flutter/material.dart';

dialogCustomForCEP(BuildContext context, String title, onPressed(),
    {double width = 150,
    List<Widget> children,
    String titleOnpress = "Đồng Ý"}) {
  Size size = MediaQuery.of(context).size;
  double screenWidth = size.width;
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // (horizontal:10 = left:10, right:10)(vertical:10 = top:10, bottom:10)
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              backgroundColor: Colors.grey[200],
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 0),
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: EdgeInsets.only(left: 15, right: 10, top: 10),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: children.length == 0
                        ? screenWidth * 0.6
                        : screenWidth * 0.8,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              content: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                width: width,
                height: children.length == 0 ? 0 : null,
                child: Column(
                  children: children,
                ),
              ),
              actions: [
                new FlatButton(
                  padding: const EdgeInsets.only(top: 8.0),
                  textColor: Colors.grey,
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text(
                    "Đóng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new FlatButton(
                  padding: const EdgeInsets.only(top: 8.0),
                  textColor: Colors.pink[500],
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPressed();
                  },
                  child: new Text(
                    titleOnpress,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {});
}

dialogCustomForCEP1(BuildContext context, String title, onPressed(),
    {double height = 150,
    List<Widget> children,
    String titleOnpress = "Đồng Ý"}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // (horizontal:10 = left:10, right:10)(vertical:10 = top:10, bottom:10)
      contentPadding: EdgeInsets.zero,
      scrollable: true,
      backgroundColor: Colors.grey[100],
      elevation: 1,
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(color: Colors.white70, width: 0),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      titlePadding: EdgeInsets.only(left: 15, right: 10, top: 10),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[100])),
              child: Icon(
                Icons.close,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),

      //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        width: 400,
        // width = device width minus insetPadding = deviceWidth - 20  (left:10, right:10 = 20)
        height: 200,
        // height = device height minus insetPadding = deviceHeight - 20  (top:10, bottom:10 = 20)
        child: Column(
          children: children,
        ),
      ),
      actions: [
        new FlatButton(
          padding: const EdgeInsets.only(top: 8.0),
          textColor: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
          child: new Text(
            "Đóng",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        new FlatButton(
          padding: const EdgeInsets.only(top: 8.0),
          textColor: Colors.pink[500],
          onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          },
          child: new Text(
            titleOnpress,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
