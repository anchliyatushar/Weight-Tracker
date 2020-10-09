import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:stack_finance_assignment/utils/strings.dart';

class MyWeightIndicator extends StatefulWidget {
  @override
  _MyWeightIndicatorState createState() => _MyWeightIndicatorState();
}

class _MyWeightIndicatorState extends State<MyWeightIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weight",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                )),
            SizedBox(
              height: 20,
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(progressBarColors: [
                  my_primary_light_color,
                  my_accent_color
                ]),
              ),
              innerWidget: (value) {
                return Center(
                    child: Text(
                  "${value.toStringAsFixed(1)} Kgs",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ));
              },
              min: 0,
              max: 200,
              onChange: (value) {
                print(value);
                setState(() {});
              },
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Height",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                )),
            SizedBox(
              height: 20,
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(progressBarColors: [
                  my_primary_light_color,
                  my_accent_color
                ]),
              ),
              innerWidget: (value) {
                return Center(
                    child: Text(
                  "${value.toStringAsFixed(1)} ft",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ));
              },
              min: 0,
              initialValue: 5,
              max: 9,
              onChange: (value) {
                print(value);
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
