import 'package:flutter/material.dart';
import 'package:libiri/providers/infoProvider.dart';
import 'package:provider/provider.dart';

class SelectActiveSim extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SelectActiveSimState();
}

class SelectActiveSimState extends State<SelectActiveSim>{
  @override
  Widget build(BuildContext context) {
    final simData = Provider.of<InfoProvider>(context);
    Map<String, dynamic> simInfo = simData.info;
    return Container();
  }
}