import 'package:flutter/material.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/utile/Custom_Text.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField( {
    this.addIcon = false,
    this.obscure = false,
    super.key,
    required this.controller,
    this.validator,
    required this.title,
    this.onChange,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final bool obscure;
  final bool addIcon;
  final void Function(String)? onChange;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure1 = true;
  @override
  void initState() {
    isObscure1 = widget.obscure;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      obscureText: isObscure1,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObscure1 = !isObscure1;
              // isObscure1 = !isObscure1;
            });
          },
          child: widget.addIcon
              ? isObscure1
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.remove_red_eye_outlined)
              : SizedBox(),
        ),
        filled: true,
        fillColor: AppColor.grayColor,
        hint: CustomText(
          title: widget.title,
          hight: 0.02,
          color: const Color.fromARGB(255, 178, 175, 175),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
