import 'package:flutter/material.dart';

import 'balance.dart';

class UserInfo extends StatelessWidget {
  final double screenHeight;

  UserInfo(this.screenHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.12,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.001,
          horizontal: MediaQuery.of(context).size.width * 0.001),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25
          ),
        ),
        elevation: 4,
        shadowColor: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              iconSize: screenHeight * 0.07,
              padding: EdgeInsets.all(screenHeight * 0.01),
              onPressed: () => print("icon button pressed"),
              icon: CircleAvatar(
                child: Image.asset(
                  "assets/images/imoji1.png",
                  fit: BoxFit.cover,
                ),
                minRadius: screenHeight * 0.05,
                //backgroundColor: Colors.blue,
              ),
            ),
            Balance(25.25),
          ],
        ),
      ),
    );
  }
}
