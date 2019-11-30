import 'dart:io';

import 'package:flutter/foundation.dart';
class Donation{
  final String id;
  final String medName;
  final File medImg;
  final DateTime exDate;
  final String userName;
  
  Donation({
    @required this.id,
    @required this.medName,
    @required this.medImg,
    @required this.exDate,
    @required this.userName,
  });
}