import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.focusNode, this.focusNodeNext, required this.fieldName});
  final FocusNode focusNode;
  final FocusNode? focusNodeNext;
  final String fieldName;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      cursorColor: Colors.indigoAccent,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: widget.fieldName == "Confirm password" ?
        'Retype your new password' :
        'Enter your ${widget.fieldName.toLowerCase()}',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
        ),
        prefixIcon: Icon(
            widget.fieldName == "Confirm password" ?
            Icons.check_box_outlined :
            Icons.password
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      onSubmitted: (value) {
        widget.focusNodeNext == null ? FocusScope.of(context).unfocus() :
        FocusScope.of(context).requestFocus(widget.focusNodeNext);
      },
    );
  }
}
