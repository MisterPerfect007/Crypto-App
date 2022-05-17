import 'package:flutter/material.dart';


class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: SafeArea(
          child: Container(
            color: Colors.green[100],
            padding: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
            ),
            height: 50,
            child: Row(children: [
              const Text(
                "Coin List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              Container(
                child: Image.asset('assets/icons/home.png'),
              )
            ]),
          ),
        ),
      ),
      body: Text("APP"),
    );
  }
}
