import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextLink extends StatelessWidget {
  const TextLink(
      {Key? key, required this.linkText, required this.url, TextStyle? style})
      : textStyle = style ?? const TextStyle(color: Colors.blue),
        super(key: key);
  final String linkText;
  final String url;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: linkText,
            style: textStyle,
            recognizer: TapGestureRecognizer()..onTap = () => launch(url))
      ],
    ));
  }
}
