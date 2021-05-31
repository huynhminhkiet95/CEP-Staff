import 'package:flutter/material.dart';

class CusTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType textInputType;
  final VoidCallback onEditingComplete;
  const CusTextFormField({Key key, this.title, this.controller,this.textInputType, this.onEditingComplete}) : super(key: key);

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
          controller: controller,
          style: TextStyle(color: Colors.blue),
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: title,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          onEditingComplete: onEditingComplete,
          keyboardType: textInputType,

        )
      ],
    );
  }
}
