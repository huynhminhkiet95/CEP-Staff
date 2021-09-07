import 'package:flutter/material.dart';
import 'package:qr_code_demo/utils/always_disabled_focus_node.dart';

class CusTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType textInputType;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;
  final Function() onTab;
  final Function(String) validator;
  const CusTextFormField(
      {Key key,
      this.title,
      this.controller,
      this.textInputType,
      this.onEditingComplete,
      this.focusNode,
      this.onTab,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xff9596ab)),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          enableInteractiveSelection: false, // will disable paste operation
          focusNode: focusNode,
          controller: controller,
          onTap: onTab,
          style: TextStyle(color: Colors.blue),
          validator: validator,

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide(color: Colors.grey[300]),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide(color: Colors.grey[300]),
            ),
            contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
            hintText: title,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            errorStyle: TextStyle(color: Colors.red, fontSize: 12),
          ),
          onEditingComplete: onEditingComplete,
          keyboardType: textInputType,
        )
      ],
    );
  }
}
