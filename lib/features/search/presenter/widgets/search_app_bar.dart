import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg-icons.dart';
import '../bloc/search_coin_bloc.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    Key? key,
  }) : super(key: key);

  final _serachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          padding: const EdgeInsets.all(10),
                          child: const SvgIcon(icon: SvgIcons.arrowLeft))),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: 30,
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
                          size: 15,
                          color: Color.fromARGB(188, 0, 0, 0)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _serachController,
                            cursorWidth: 1.0,
                            autofocus: true,
                            cursorColor: AppColors.mainGreen,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Search coin...",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 10),
                            ),
                            style: const TextStyle(fontSize: 12),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                
                                context.read<SearchCoinBloc>().add(GetSearchCoins(_serachController.text));
                              }
                            },),
                      ),
                    ],
                  ),
                ))
              ])),
    );
  }

}
