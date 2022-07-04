
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/icons/icons.dart';
import '../../bloc/coin_list_bloc.dart';
import '../../cubit/scrollposition_cubit.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
    required this.context,
    required this.scrollController,
  }) : super(key: key);

  final BuildContext context;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return const PersoIcon(icon: PersoIcons.arrowScrollUp);
                // onPressed: () {
                //   scrollController.animateTo(
                //     0,
                //     duration: const Duration(milliseconds: 200),
                //     curve: Curves.fastOutSlowIn,
                //   );
                // },
        
    
  }
}
