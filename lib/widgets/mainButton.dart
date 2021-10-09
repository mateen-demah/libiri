import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/historyProvider.dart';

import 'sendDialog.dart';
import 'withdrawDialog.dart';
import 'scanQr.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double screenHeight;

  MainButton(this.text, this.screenHeight);

  Widget switchWithText() {
    switch (text) {
      case "Send":
        {
          return SendDialog(screenHeight);
        }
        break;
      case "Pay":
        {
          return ScanQr();
        }
        break;
      case "Withdraw":
        {
          return WithdrawDialog(screenHeight);
        }
        break;
    }
  }

  void showTxDialogSheet(BuildContext context, buttonText){
    final txData = Provider.of<HistoryProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)),
      isScrollControlled: buttonText == "Send"? true: false,
      builder: (context) {
        return switchWithText();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: ButtonTheme(
          height: screenHeight * 0.08,
          child: RaisedButton(
            child: FittedBox(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            onPressed: () {
              showTxDialogSheet(context, text);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
