import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

int randomNumber = 0;

class ClockScreen extends StatefulWidget {
  ClockScreen({Key key}) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      //Calls the function repeteadly after a duration
      setState(() {});
    });

    Timer.periodic(Duration(seconds: 60), (timer) {
      //Calls the function repeteadly after a duration
      setState(() {
        randomNumber++;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  List outerCircle = [Color(0xff314886), Color(0xff6F256C), Color(0xff26A1A1)];

  List innerCicle = [Color(0xff26A1A1), Color(0xff314886), Color(0xff6F256C)];

  //60 sec - 360 , 1 seec - 6 degree

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xff444974);

    var outLineBrush = Paint()
      ..color = outerCircle[randomNumber % outerCircle.length]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()
      ..color = innerCicle[randomNumber % innerCicle.length];

    var secondHandBrush = Paint()
      ..color = Colors.orange[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var mindHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.blue, Colors.amber])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Color(0xFFEAECFF)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    var hourHandBrush = Paint()
      ..shader =
          RadialGradient(colors: [Colors.pink, Colors.blue, Colors.brown])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..color = Colors.orange[500]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    var dashBrush = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outLineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minHandX, minHandY), mindHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCicleRadius = radius;
    var innerCircleRadius = radius - 14;

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCicleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCicleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;
}
