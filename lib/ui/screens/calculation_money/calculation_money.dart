import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/ui/components/animated_flip_counter.dart';
import 'package:qr_code_demo/ui/components/spin_textfield_number.dart';
import 'package:flutter/material.dart';

class CalculationMoney extends StatefulWidget {
  CalculationMoney({Key key}) : super(key: key);

  @override
  _CalculationMoneyState createState() => _CalculationMoneyState();
}

class _CalculationMoneyState extends State<CalculationMoney> {
  double screenHeight;
  double screenWidth;
  ScrollController scrollController = new ScrollController();

  int total;
  TextEditingController _500kController = new TextEditingController(text: "0");
  TextEditingController _200kController = new TextEditingController(text: "0");
  TextEditingController _100kController = new TextEditingController(text: "0");
  TextEditingController _50kController = new TextEditingController(text: "0");
  TextEditingController _20kController = new TextEditingController(text: "0");
  TextEditingController _10kController = new TextEditingController(text: "0");
  TextEditingController _5kController = new TextEditingController(text: "0");
  TextEditingController _2kController = new TextEditingController(text: "0");
  TextEditingController _1kController = new TextEditingController(text: "0");
  TextEditingController _500Controller = new TextEditingController(text: "0");
  TextEditingController _200Controller = new TextEditingController(text: "0");

  @override
  void initState() {
    total = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
            //bool a = GlobalDownload.isSubmitDownload;
          },
        ),
        backgroundColor: ColorConstants.cepColorBackground,
        elevation: 20,
        title: const Text(
          'Bảng Kê Tiền',
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "500k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _500kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "200k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _200kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "100k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _100kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "50k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _50kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "20k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _20kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "10k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _10kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "5k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _5kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "2k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _2kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "1k",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _1kController,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: size.width * 0.2,
                          // color: Colors.white,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                spreadRadius: 5,
                                offset: Offset(
                                    10, 10), // changes position of shadow
                              ),
                            ],
                            color: ColorConstants.cepColorBackground,
                            border: Border.all(color: Colors.white, width: 1.0),
                            // backgroundBlendMode: BlendMode.lighten,
                            borderRadius:
                                new BorderRadius.all(Radius.elliptical(60, 40)),
                          ),
                          child: Center(
                            child: Text(
                              "500",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SpinTextFieldNumber(
                          textController: _500Controller,
                          onChangeValue: (value) {
                            totalSubmit();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            // decoration: new BoxDecoration(

            //     color: Colors.grey,
            //     borderRadius: new BorderRadius.only(
            //         topLeft: Radius.elliptical(40, 40),
            //         topRight: Radius.elliptical(40, 40))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Tổng Tiền:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                      child: AnimatedFlipCounter(
                    duration: Duration(milliseconds: 500),
                    value: total,
                    /* pass in a number like 2014 */
                    color: Colors.black,
                    size: 20,
                  )
                      //  Text(
                      //   "20,000,000 VNĐ",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18),
                      // ),
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void totalSubmit() {
    total = 0;
    total += int.parse(_500kController.text) * 500000;
    total += int.parse(_200kController.text) * 200000;
    total += int.parse(_100kController.text) * 100000;
    total += int.parse(_50kController.text) * 50000;
    total += int.parse(_20kController.text) * 20000;
    total += int.parse(_10kController.text) * 10000;
    total += int.parse(_5kController.text) * 5000;
    total += int.parse(_2kController.text) * 2000;
    total += int.parse(_1kController.text) * 1000;
    total += int.parse(_500Controller.text) * 500;
    total += int.parse(_200Controller.text) * 200;
    setState(() {
      total = total;
    });
  }
}
