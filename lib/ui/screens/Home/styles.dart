import 'package:flutter/material.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/home.jpeg'),
  fit: BoxFit.cover,
);

DecorationImage profileImage = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/default-avatar.jpg'),
  fit: BoxFit.cover,
);

DecorationImage timelineImage = new DecorationImage(
  image: new ExactAssetImage('assets/timeline.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar1 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-1.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar2 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-2.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar3 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-3.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar4 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-4.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar5 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-5.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar6 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-6.jpg'),
  fit: BoxFit.cover,
);

InputDecoration decorationTextFieldCEP = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
  labelStyle: new TextStyle(color: Colors.blue),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
);

Widget customScrollViewSliverAppBarForDownload(
    String title, List<Widget> listChildren, BuildContext context) {
  Size size = MediaQuery.of(context).size;
   
  return CustomScrollView(
    physics: MediaQuery.of(context).orientation == Orientation.portrait ? NeverScrollableScrollPhysics() : null,
    slivers: <Widget>[
      SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: size.height * 0.07,
          flexibleSpace: Container(
            child: Center(
              child: Text(
                title,
                //  textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff003399),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    wordSpacing: 5
                    ),
              ),
            ),
          ),
          backgroundColor: Colors.white),
      SliverList(
        delegate: SliverChildListDelegate(
          listChildren,
        ),
      ),
    ],
  );
}
// DecorationImage profileImage = new DecorationImage(
//   image: new ExactAssetImage('assets/avatars/avatar-7.gif'),
//   fit: BoxFit.cover,
// );
