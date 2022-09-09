import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg-icons.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            size.width,
            50,
          ),
          child: SafeArea(
            child: Container(
                height: 50,
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const SvgIcon(icon: SvgIcons.arrowLeft))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SvgIcon(
                                icon: SvgIcons.search,
                                color: Color.fromARGB(188, 0, 0, 0)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      autofocus: true,
                                      cursorColor: AppColors.mainGreen,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search coin...",
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ])),
          ),
        ),
        body: Container(
          color: Colors.red,
        ));
  }
}
