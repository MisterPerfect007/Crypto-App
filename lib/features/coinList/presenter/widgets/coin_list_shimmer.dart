import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_container_shimmer.dart';

class CoinShimmer extends StatelessWidget {
  const CoinShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: size.height ~/ 70,
        itemBuilder: ((context, index) {
          return const SingleCoinShimmer();
        }));
  }
}

class SingleCoinShimmer extends StatelessWidget {
  const SingleCoinShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    return Container(
      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
      ),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: 50,
      child: Row(
        children: [
          const ContainerShimmer(width: 40, height: 40, radius: 40),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ContainerShimmer(width: 80, height: 10, radius: 5),
              const SizedBox(height: 5),
              Row(
                children: const [
                  ContainerShimmer(width: 20, height: 10, radius: 5),
                  SizedBox(
                    width: 5
                  ),
                  ContainerShimmer(width: 55, height: 10, radius: 5),
                ],
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              ContainerShimmer(height: 10, width: 80, radius: 5),
              SizedBox(
                height: 5,
              ),
              ContainerShimmer(height: 10, width: 20, radius: 5),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
