import 'package:flutter/material.dart';

class BmiMarker extends StatelessWidget {
  final double bmi;
  const BmiMarker(this.bmi);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              "${bmi.toStringAsFixed(1)}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              getText(bmi.floor()),
              style: TextStyle(
                  color: getColor(bmi.floor()),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 40,
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: index == bmi.floor()
                        ? EdgeInsets.all(0)
                        : EdgeInsets.only(top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width / 70,
                    color: getColor(index),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 2,
                  );
                },
                itemCount: (MediaQuery.of(context).size.width - 40).round())),
      ],
    );
  }
}

String getText(int index) {
  if (index <= 18) {
    return "You're Underweight";
  }
  if (index > 18 && index < 25) {
    return "You're Healty";
  }
  if (index >= 25 && index <= 30) {
    return "You're Overweight";
  } else {
    return "You're Obese";
  }
}

getColor(int index) {
  if (index <= 18) {
    return Colors.blueGrey;
  }
  if (index > 18 && index < 25) {
    return Colors.teal;
  }
  if (index >= 25 && index <= 30) {
    return Colors.yellow[700];
  } else {
    return Colors.red[700];
  }
}
