import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var medName;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Request Medicine",style: TextStyle(fontFamily: "McLaren"),),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(       
                  mainAxisSize: MainAxisSize.max,         
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25.0),
                    Container(
                      height: 100,
                      child: Text("\nMedicine Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Montserrat",
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    TextFormField(
                      showCursor: true,
                      style: style,
                      validator: (val) {
                        if (val.isEmpty) return "This field cannot be Empty";
                        medName = val;
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onSaved: (val) {
                        medName = val;
                      },
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Medicine Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                    ),
                    SizedBox(height: 25.0),
                    MaterialButton(
                      color: Colors.deepPurple,
                      minWidth: 100,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        getImage();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Upload Prescription ",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    ),
                    if (_image == null)
                      Container(
                          child: Image.asset(
                        'assets/images/Wait.png',
                        fit: BoxFit.cover,
                        height: 100,
                      ))
                    else
                      Image.file(
                        _image,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    SizedBox(height: 25.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.teal,
                      child: MaterialButton(
                        minWidth: 100,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {},
                        child: Text("Request Medicine",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 25.0),
                  ]
              ),
            ),
          ),
        ));
  }
}
