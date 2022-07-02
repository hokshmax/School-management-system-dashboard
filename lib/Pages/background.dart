import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class back extends CustomPainter{

  int hexToInt(String hex)
  {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
  Paint _paint,paint2,paint3;
  back() {
    _paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;
    paint2=Paint()..color=Colors.lightBlue[100]..style=PaintingStyle.fill;
    paint3=Paint()..color=Color.fromRGBO(223, 248, 255, 28)..style=PaintingStyle.fill;


  }
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var path2 = Path();
    var path3 = Path();



    canvas.drawRect(Offset(20, size.height/2) &  Size(size.width, size.height/2), paint3);

    path2.moveTo(150 , size.height/2);
    path2.lineTo(size.height/1.3, size.height);
    path2.lineTo(size.height/2, size.width);
    path2.close();
    canvas.drawPath(path2, paint2);



    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, _paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}