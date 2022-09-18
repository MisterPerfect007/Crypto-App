import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg_icons.dart';
import '../bloc/search_coin_bloc.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _serachController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _lastTextFieldValue = "";

  ///To track the search request time
  int time = 0;
  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      time++;
    });
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

    return SafeArea(
      child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 0, right: sidePadding),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.mainGrey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 0.2),
            ],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 50,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: const SvgIcon(
                            icon: SvgIcons.chevronLeft,
                            size: 25,
                            color: AppColors.mainGreen,
                          ))),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    // top:5,
                    // bottom: 5
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
                        size: 25,
                        // color: Color.fromARGB(188, 0, 0, 0)
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _serachController,
                            // cursorWidth: 1.0,
                            autofocus: true,
                            cursorColor: AppColors.mainGreen,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Search coin...",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            style: const TextStyle(fontSize: 16),
                            onChanged: (value) => handleOnChange(value, time),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ])),
    );
  }

  ///Handle search
  ///[value] is the query parameter for search
  ///we use [requestTime] to know latest request so to show it's reponse to the user
  void handleOnChange(String value, int requestTime) {
    String currentValue = _serachController.text.trim();
    if (value.isNotEmpty &&
            _lastTextFieldValue !=
                currentValue /* This check is to prevent Api call when keyboard dismiss */
        ) {
      _lastTextFieldValue = currentValue;

      context
          .read<SearchCoinBloc>()
          .add(GetSearchCoins(_serachController.text, requestTime));
    }
  }
}
