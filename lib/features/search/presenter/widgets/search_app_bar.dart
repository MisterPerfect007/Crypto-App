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


  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);

    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

    return SafeArea(
      child: Container(
          height: 50,
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.mainGrey.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 0.5,
                  spreadRadius: 0),
            ],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      color: theme.disabledColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _serachController,
                        cursorColor: AppColors.mainGreen,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Search coin... 👀",
                          hintStyle: TextStyle(
                              /* fontStyle: FontStyle.italic, */ fontSize: 14, color: theme.primaryColor),
                        ),
                        style: const TextStyle(fontSize: 16),
                        onFieldSubmitted: (value) {
                          triggerSearch();
                        },
                      ),
                    ),
                  ),
                )),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: AppColors.mainGreen,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      onTap: () {
                        triggerSearch();
                      },
                      splashColor: Colors.white.withOpacity(0.2),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: const SvgIcon(
                          icon: SvgIcons.search,
                          color: Colors.white,
                          // size: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ])),
    );
  }

  ///Handle search
  void triggerSearch() {
    String value = _serachController.text.trim();
    if (value.isNotEmpty) {
      context.read<SearchCoinBloc>().add(GetSearchCoins(value));
    }
  }
}
