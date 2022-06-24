import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ui/colors/colors.dart';

class CoinShimmer extends StatelessWidget {
  const CoinShimmer({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: AppColors.secondGrey,
      highlightColor: const Color.fromARGB(255, 234, 234, 234),
      child: ListView.builder(
        itemCount: size.height ~/ 70,
        itemBuilder: ((context, index) {
        return const SingleCoinShimmer();
      }))
    );
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
      // decoration: BoxDecoration(border: Border.all()),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: AppColors.secondGrey,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 80,
                decoration: const BoxDecoration(
                    color: AppColors.secondGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 20,
                    decoration: const BoxDecoration(
                        color: AppColors.secondGrey,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 10,
                    width: 55,
                    decoration: const BoxDecoration(
                        color: AppColors.secondGrey,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 10,
                width: 80,
                decoration: const BoxDecoration(
                    color: AppColors.secondGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 10,
                width: 20,
                decoration: const BoxDecoration(
                    color: AppColors.secondGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
