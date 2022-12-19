import 'package:flutter/material.dart';
import 'package:flutter_rocket_launches/app/rocket_launches_app.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const RocketLaunchesApp());
}
