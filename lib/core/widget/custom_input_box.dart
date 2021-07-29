import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

getCustomInputBox(String label, String inputHint, TextEditingController controller)
{
  final checkBoxIcon = 'assets/images/checkbox.svg';
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Product Sans',
              fontSize: 12,
              color: Color(0xff8f9db5),
            ),
          ),
        ),
      ),
      //
      Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
        child: TextFormField(
          controller: controller,
          obscureText: label == 'Password' ? true : false,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xff0962ff),
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: inputHint,
            hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[350],
                fontWeight: FontWeight.w600),
            contentPadding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            focusColor: Color(0xff0962ff),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color(0xff0962ff)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: (Colors.grey[350])!,
              ),
            ),
            suffixIcon: controller.text.isNotEmpty?Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,top: 12,bottom: 12),
                child: SvgPicture.asset(
                  checkBoxIcon,
                  height: 1,
                ),
              ),
            ):Visibility(
              visible: false,
              child: SvgPicture.asset(checkBoxIcon),
            )
            ,
          ),
        ),
      ),
      //
    ],
  );
}