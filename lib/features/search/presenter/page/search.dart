import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg-icons.dart';
import '../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../home/presenter/bloc/trending_coin/trending_coin_bloc.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<CoinListBloc>()),
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              size.width,
              50,
            ),
            child: SafeArea(
              child: Container(
                  height: 50,
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 0, right: sidePadding),
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
                                  child:
                                      const SvgIcon(icon: SvgIcons.arrowLeft))),
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
                                    cursorWidth: 1.0,
                                    autofocus: true,
                                    cursorColor: AppColors.mainGreen,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Search coin...",
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 10),
                                    ),
                                    style: const TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ))
                      ])),
            ),
          ),
          body: Container(
              color: Colors.white,
              child: BlocBuilder<CoinListBloc, CoinListState>(
                builder: (context, state) {
                  print(state);
                  if (state is CoinListLoaded) {
                    return Container(
                      color: Colors.greenAccent,
                      width: 200,
                      height: 200,
                    );
                  }
                  return Container();
                },
              )),
        ));
  }
}
