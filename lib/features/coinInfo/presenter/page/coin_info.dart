import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ui/colors/colors.dart';
import '../utils/coin_info_line_chart_data.dart';
import '../utils/large_sample_data.dart';
import '../widgets/coinChart/coin_line_chart.dart';
import '../widgets/coinNameImage/coin_name_image.dart';
import '../widgets/coin_info_app_bar.dart';
import '../widgets/priceAndPercentage/price_and_percentage.dart';
import '../widgets/timeSlots/time_slots_parent.dart';

class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          60,
        ),
        child: const CoinInfoPageAppBar(),
      ),
      body: Container(
        height: size.height,
        color: AppColors.lightBg,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CoinNameImage(),
              PriceAndPercentage(
                percentage: 99.0,
              ),
              const SizedBox(
                height: 50,
              ),
              const CoinChart(),
              const TimeSlotsParent(),
              const SizedBox(height: 30,),
              const ExtraInfos(),
              const SizedBox(height: 30,), 
            ],
          ),
        ),
      ),
    );
  }
}

class ExtraInfos extends StatelessWidget {
  const ExtraInfos({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
        padding:
            EdgeInsets.only(left: sidePadding, right: sidePadding),
        child: Column(
          children: [
            ExtraInfo(infoName: "Rank", value: "1",),
            SizedBox(height: 20,),
            ExtraInfo(infoName: "High 24h", value: "\$ 174.90",),
            SizedBox(height: 20,),
            ExtraInfo(infoName: "Low 24h", value: "\$ 166.12",),
            SizedBox(height: 20,),
            ExtraInfo(infoName: "Vol.", value: "\$ 790,864,928,782",),
            SizedBox(height: 20,),
            ExtraInfo(infoName: "Mkt. Cap.", value: "\$ 790,864,928,782",),
          ],
        ));
  }
}

class ExtraInfo extends StatelessWidget {
  final String? value;
  final String infoName;
  const ExtraInfo({
    Key? key, required this.infoName, this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          infoName,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.mainGrey
          ),
        ),
        Expanded(child: Container()),
        Text(
          value!.toString(),
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.mainBlack
          ),
        )
      ],
    );
  }
}

class CoinChart extends StatelessWidget {
  const CoinChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CoinInfoLineChart(
        chartData: CoinInfoLineChartData(coinMarketChart: largeCoinMarketChart),
      ),
    );
  }
}
