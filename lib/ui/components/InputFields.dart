import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final TextEditingController textController;
  final String hint;
  final bool obscure;
  final IconData icon;
  final FocusNode focusNode;
  final key;

  InputFieldArea({this.hint, this.obscure, this.icon,this.textController,this.focusNode,this.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      focusNode:focusNode,
      controller: textController,
      obscureText: obscure,
      autovalidate: false,
      onSaved: (String value){

        textController.text = value;
      },
      onFieldSubmitted: (String value)
      {
        textController.text = value;
        
      },
      validator: (String value) {
                if (value.isEmpty)
                {
                     return "value is not emtry";
                }
                return null;
      },

      style: const TextStyle(
          color:Colors.black,
        ),
        decoration: new InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 15.0),
          
          contentPadding: const EdgeInsets.only(
              top: 15.0, right: 30.0, bottom: 15.0, left: 15.0), 
        )
    );
    
  }
}
