
import 'package:flutter/material.dart';

import 'extra_info.dart';

class ExtraInfos extends StatelessWidget {
  const ExtraInfos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
        width: size.width,
        child: Column(
          children: const [
            ExtraInfo(
              infoName: "Rank",
              value: "1",
            ),
            SizedBox(
              height: 20,
            ),
            ExtraInfo(
              infoName: "High 24h",
              value: "\$ 174.90",
            ),
            SizedBox(
              height: 20,
            ),
            ExtraInfo(
              infoName: "Low 24h",
              value: "\$ 166.12",
            ),
            SizedBox(
              height: 20,
            ),
            ExtraInfo(
              infoName: "Vol.",
              value: "\$790,864,928,782,790,864,928,782,790,864",
            ),
            SizedBox(
              height: 20,
            ),
            ExtraInfo(
              infoName: "Mkt. Cap.",
              value: "\$ 790,864,928,782",
            ),
          ],
        ));
  }
}
