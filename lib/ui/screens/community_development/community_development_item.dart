import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class CommunityDevelopmentItem extends StatelessWidget {
  CommunityDevelopmentItem();
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return new Container(
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: new Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Card(
        elevation: 6,
        shadowColor: Colors.grey,
        color: Colors.white,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.86,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        "KIET365 - Huynh Minh Kiet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Row(
                            children: [
                              Icon(
                                IconsCustomize.gender,
                                size: 20,
                                color: Colors.blue,
                              ),
                              VerticalDivider(
                                width: 10,
                              ),
                              Container(
                                width: 30,
                                child: Text(
                                  "Nam",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Row(
                            children: [
                              Icon(
                                IconsCustomize.birth_date,
                                size: 20,
                                color: Colors.red,
                              ),
                              VerticalDivider(
                                width: 10,
                              ),
                              VerticalDivider(
                                width: 1,
                              ),
                              Text(
                                "1980",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Row(
                            children: [
                              Icon(
                                IconsCustomize.id_card,
                                color: Colors.orange,
                                size: 20,
                              ),
                              VerticalDivider(
                                width: 15,
                              ),
                              Text(
                                "212275568",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(left: 6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          VerticalDivider(
                            width: 1,
                          ),
                          Container(
                            width: 230,
                            child: Text(
                              "102 Quang Trung, P. Hiệp Phú, Quận 9, TP Thủ Đức",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
