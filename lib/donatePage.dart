import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Page2 extends StatefulWidget {
  Page2();
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String medName;
  File _image;
  DateTime _exDate;
  final GlobalKey<FormState> _dKey = GlobalKey<FormState>();

  void donate() {
    const url = "https://trial-362bf.firebaseio.com/d.json";
    print("heek");

    if (_dKey.currentState.validate()) {
      http.post(url,body: json.encode({
       'medName': medName,
        'image': base64Encode(_image.readAsBytesSync()),
        //'_exDate': _exDate.toString()
      }))
        .then((response) {
        var id=json.decode(response.body)['name'];
      });
      final StorageReference storageReference =
          FirebaseStorage().ref().child("donations/new.jpg");

      final StorageUploadTask uploadTask = storageReference.putFile(_image);

    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void _exDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 5))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _exDate = pickedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    var donation = Scaffold(
        appBar: AppBar(
          title: Text(
            "Donate Medicine",
            style: TextStyle(fontFamily: "McLaren"),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _dKey,
              autovalidate: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25.0),
                    Container(
                      height: 100,
                      child: Text("\nMEDICINE DETAILS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "McLaren",
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
                            "Upload Image ",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    ),
                    if (_image == null)
                      Text('No image taken!')
                    else
                      Image.file(
                        _image,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    SizedBox(height: 25.0),
                    MaterialButton(
                      color: Colors.deepPurple,
                      minWidth: 100,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: _exDatePicker,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select Expiration Date",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.calendar_today)
                        ],
                      ),
                    ),
                    Text(_exDate == null
                        ? 'Expiry date Not Chosen!'
                        : 'Expiry Date: ${DateFormat.yMd().format(_exDate)}'),
                    SizedBox(height: 25.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.teal,
                      child: MaterialButton(
                        minWidth: 100,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: donate,
                        child: Text("Donate",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
            ),
          ),
        ));
    return donation;
  }
}
