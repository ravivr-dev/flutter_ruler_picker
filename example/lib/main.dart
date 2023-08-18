// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruler Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ruler Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // _MyHomePageState2 createState() => _MyHomePageState2();
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState2 extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 40000,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(100), child: Text("index:${index}"));
            }));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  RulerPickerController? _rulerPickerController;

  int currentValue = (15000~/500);

  int valueVisibleOnScreen = 15000;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: 0);
  }

  Widget _buildBtn(int value) {
    return InkWell(
      onTap: () {
        _rulerPickerController?.value = value;
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              valueVisibleOnScreen.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 80),
            ),
            SizedBox(height: 50),
            RulerPicker(
              marker: const ScaleMarkerWidget(),
              rulerBackgroundColor: Color(0xFFE2DDCD),
              controller: _rulerPickerController!,
              beginValue: 0,
              endValue: 50000,
              initValue: currentValue,
              scaleLineStyleList: const [
                ScaleLineStyle(
                    color: Color(0xff3A3A3A), width: 2, height: 60, scale: 0),
                ScaleLineStyle(
                    color: Color(0xff3A3A3A), width: 2, height: 41, scale: 5),
                ScaleLineStyle(
                    color: Color(0xff3A3A3A), width: 2, height: 30, scale: -1)
              ],
              // onBuildRulerScalueText: (index, scaleValue) {
              //   return ''.toString();
              // },
              onValueChange: (value) {
                setState(() {
                  currentValue = value;

                  valueVisibleOnScreen = value*500;
                });
              },

              onBuildRulerScalueText: (index, rulerScaleValue) {
                return (rulerScaleValue *500).toString();
              },

              width: MediaQuery.of(context).size.width,
              height: 98,
              rulerMarginTop: 0,
              // marker: Container(
              //     width: 8,
              //     height: 50,
              //     decoration: BoxDecoration(
              //         color: Colors.red.withAlpha(100),
              //         borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBtn(30),
                SizedBox(width: 10),
                _buildBtn(50),
                SizedBox(width: 10),
                _buildBtn(100),
                SizedBox(width: 10),
                _buildBtn(40000),
                SizedBox(width: 10),
                _buildBtn(50000),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ScaleMarkerWidget extends StatelessWidget {
  const ScaleMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      width: 16 * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: CustomPaint(
              painter: TrianglePainter(),
              child: const SizedBox(
                width: 20,
                height: 20,
              ),
            ),
          ),
          CustomPaint(
            painter: TrianglePainter(),
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Top vertex
    path.lineTo(size.width, size.height); // Bottom right vertex
    path.lineTo(0, size.height); // Bottom left vertex
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

