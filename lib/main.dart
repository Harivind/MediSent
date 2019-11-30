import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medisent/welcomePage.dart';
import './donatePage.dart';
import './requestPage.dart';

main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => GestureDetector(
            child: MyHomePage(),
            onTap: () => FocusScope.of(context).unfocus(),
          ),
      '/welcome': (context) => Page1(_createRoute),
      //'/welcome/donate': (context) => Page2(),
      //'/welcome/request': (context) => Page3(),
    },
    darkTheme: ThemeData.dark(),
    theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'McLaren',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white)))),
  ));
}

Route _createRoute(String s) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (s.compareTo("donate") == 0) {
        return Page2();
      } else if (s.compareTo("request") == 0)
        return Page3();
      else
        return Page1(_createRoute);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String uname, pass;
  DateTime _date;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _autoValidate = false;
  void _login() {
    if (_formKey.currentState.validate()) {
      Navigator.pushReplacementNamed(this.context, '/welcome',
          arguments: uname);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      uname = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      showCursor: true,
      obscureText: false,
      style: style,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (val) {
        uname = val;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = Container(
        height: 100,
        child: TextFormField(
          obscureText: true,
          style: style,
          validator: (val) {
            if (val.isEmpty) return "Incorrect Password!";
            return null;
          },
          onSaved: (val) {
            pass = val;
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _login();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    Widget FormUI() {
      return new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 190.0,
              child: Image.asset(
                "assets/images/logo2.PNG",
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 80.0),
            emailField,
            SizedBox(height: 25.0),
            passwordField,
            loginButon,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("Guest Login"),
                  onPressed: () {
                    uname = "Guest";
                    Navigator.pushReplacementNamed(this.context, '/welcome',
                        arguments: uname);
                  },
                ),
              ],
            )
          ]);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: new Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: FormUI(),
              )
            )
          )
        )
      )
    );
  }
}
