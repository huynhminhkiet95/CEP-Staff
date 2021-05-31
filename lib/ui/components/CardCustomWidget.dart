import 'package:flutter/material.dart';

class CardCustomizeWidget extends StatelessWidget {
  //final double height;
  final double width;
  final String title;
  final List<Widget> children;
  final void Function() onTap;
  final bool isShowCopyIcon;
  CardCustomizeWidget(
      {this.width, this.title, this.children, this.onTap, this.isShowCopyIcon});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        //height: height,

        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: EdgeInsets.all(5.0),
              width: double.infinity,
              child: Builder(builder: (context) {
                List<Widget> _headerAppbar = new List<Widget>();
                _headerAppbar.add(
                  Container(
                    width: width * 0.77,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
                _headerAppbar.add(
                  InkWell(
                    onTap: null,
                    child: Icon(
                      Icons.undo_sharp,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                );
                if (isShowCopyIcon == true) {
                  _headerAppbar.add(InkWell(
                    onTap: onTap,
                    child: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ));
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _headerAppbar,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
