import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medisent/dList.dart';
import 'package:medisent/donatePage.dart';
import 'package:medisent/models/donation.dart';

final List<Donation> _donations = [];

class Page1 extends StatefulWidget {
  final Function _createRoute;
  Page1(this._createRoute);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Widget build(BuildContext context) {
    final _User = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MediSent",
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 130,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'MediSent ',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "McLaren"),
                        ),
                        Icon(
                          Icons.fiber_smart_record,
                          color: Colors.lime,
                        )
                      ],
                    ),
                    Text(
                      "Help One Help Another",
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(
              height: 190,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    "assets/images/Logo.PNG",
                    height: 80,
                  ),
                ),
                accountEmail: Text(_User.toString()),
                accountName: _User.toString().compareTo("Guest")==0
                    ? Text("Guest")
                    : Text(_User.toString()
                        .substring(0, _User.toString().indexOf("@"))),
              ),
            ),
            ListTile(
              title: Text('Donate'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(widget._createRoute("donate"));
              },
            ),
            ListTile(
              title: Text('Request'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(widget._createRoute("request"));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(this.context, '/');
              },
            )
          ],
        ),
      ),
      body: Center(child: Text("hello world")),
    );
  }
}
