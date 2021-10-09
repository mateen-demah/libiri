import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  final double balance;

  Balance(this.balance);

  @override
  State<StatefulWidget> createState() => BalanceState();
}

class BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name of user",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Account balance: ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      widget.balance.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // IconButton(
          //   icon: Image.asset("assets/images/imoji1.png"),
          //   onPressed: () => print("Refresh icon pressed"),
          // ),
          IconButton(
            onPressed: () => print("refresh icon pressed"),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}
