import 'package:flutter/cupertino.dart';

getNewButton(String char)
{
  return Container(
    width: 58,
    height: 58,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(13),
      boxShadow: [
        BoxShadow(
          offset: Offset(12, 11),
          blurRadius: 26,
          color: Color(0xffaaaaaa).withOpacity(0.1),
        )
      ],
    ),
    //
    child: Center(
      child: Text(
        char,
        style: TextStyle(
          fontFamily: 'ProductSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xff0962FF),
        ),
      ),
    ),
  );
}