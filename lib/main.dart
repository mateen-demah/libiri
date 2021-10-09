import 'dart:async';

import 'package:flutter/material.dart';
import 'package:libiri/providers/infoProvider.dart';
import 'package:provider/provider.dart';
import 'package:sim_data/sim_data.dart';
import 'package:permission_handler/permission_handler.dart';

import './widgets/mainButton.dart';
import './widgets/userInfo.dart';
import './widgets/txHistory.dart';
import './widgets/selectActiveSim.dart';

import './models/transactions.dart';

import './providers/historyProvider.dart';
import './providers/infoProvider.dart';

void main() {
  //Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HistoryProvider(),),
        ChangeNotifierProvider.value(value: InfoProvider(),),
      ],
      child: MaterialApp(
        title: 'Libiri',
        theme: ThemeData(
          backgroundColor: Colors.grey,
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Libiri'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions;
  SimData simData;

  Future<void> _getSimData() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      bool isGranted = await Permission.phone
          .request()
          .isGranted;
      if (!isGranted) return;
    }
    simData = await SimDataPlugin.getSimData();
  }

  @override
  void initState() {
    super.initState();
    _getSimData();
  }

  @override
  Widget build(BuildContext context) {
    final infoData = Provider.of<InfoProvider>(context);

    final appBar = AppBar(
      title: Center(child: Text(widget.title)),
      actions: [
        SelectActiveSim(),
      ],
    );
    final screenHeight =
        MediaQuery
            .of(context)
            .size
            .height - appBar.preferredSize.height;

    // updating sim info
    if (simData != null) {
      for (SimCard sim in simData.cards) {
        infoData.updateInfo("operator${sim.slotIndex + 1}", sim.carrierName, notify:false);
        infoData.updateInfo("numOfSims", simData.cards.length, notify:false);
      }
    }

      return Scaffold(
        appBar: appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserInfo(screenHeight),
            TxHistory(screenHeight),
            Row(
              children: <Widget>[
                MainButton("Send", screenHeight),
                MainButton("Pay", screenHeight),
                MainButton("Withdraw", screenHeight),
              ],
            ),
          ],
        ),
      );
    }
  }
