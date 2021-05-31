import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/ui/screens/survey/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpinTextFieldNumber extends StatefulWidget {
  final TextEditingController textController;
  final ValueChanged<String> onChangeValue;
  SpinTextFieldNumber({Key key, this.textController, this.onChangeValue})
      : super(key: key);

  @override
  _SpinTextFieldNumberState createState() => _SpinTextFieldNumberState();
}

class _SpinTextFieldNumberState extends State<SpinTextFieldNumber> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = widget.textController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        InkWell(
          onTap: () {
            if (int.parse(_textEditingController.text) > 0) {
              _textEditingController.text =
                  (int.parse(_textEditingController.text) - 1).toString();
            }

            widget.onChangeValue(_textEditingController.text);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: ColorConstants.cepColorBackground)),
            ),
            child: Icon(
              Icons.remove,
              color: ColorConstants.cepColorBackground,
              size: 16,
            ),
          ),
        ),
        Container(
          height: 39,
          width: size.width * 0.15,
          child: Center(
            child: TextField(
              controller: _textEditingController,
              style: TextStyle(
                  color: ColorConstants.cepColorBackground, fontSize: 14),
              decoration: inputDecorationTextFieldCEP(""),
              // onSubmitted: (String value) {
              //   _textEditingController.text = value;
              //   widget.onChangeValue(_textEditingController.text);
              // },
              // onChanged: (value) {
              //   _textEditingController.text = value;
              //   widget.onChangeValue(_textEditingController.text);
              // },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                widget.onChangeValue(_textEditingController.text);
              },

              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _textEditingController.text =
                (int.parse(_textEditingController.text) + 1).toString();
            widget.onChangeValue(_textEditingController.text);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: ColorConstants.cepColorBackground)),
            ),
            child: Icon(
              Icons.add_outlined,
              color: ColorConstants.cepColorBackground,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
