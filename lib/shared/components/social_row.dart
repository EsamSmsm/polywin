import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _url;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Image(image: AssetImage('assets/images/web.png')),
            onTap: () {
              launchURL('https://polywinegypt.com/index-5.html');
            },
          ),
          GestureDetector(
            child: Image(image: AssetImage('assets/images/facebook.png')),
            onTap: () {
              launchURL('https://www.facebook.com/polywin.eg/');
            },
          ),
          GestureDetector(
            child: Image(image: AssetImage('assets/images/instagram.png')),
            onTap: () {
              launchURL(
                  'https://instagram.com/polywin.eg?utm_medium=copy_link');
            },
          ),
          GestureDetector(
            child: Image(image: AssetImage('assets/images/youtube.png')),
            onTap: () {
              launchURL(
                  'https://www.youtube.com/channel/UCQ-9Fjo8-1CFtFG6A4I8tbg');
            },
          )
        ],
      ),
    );
  }
}
