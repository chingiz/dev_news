import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['technology', 'programming', 'startup', 'devnews'],
    childDirected: true,
    nonPersonalizedAds: false,
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-2887480300361202/7717399535",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _interstitialAd = createInterstitialAd()..load();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "About",
          style: Theme.of(context).appBarTheme.textTheme.body1,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage("assets/app_icon.png"),
                height: 200,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "DevNews is open source Flutter application that using dev.to api to fetch articles.",
              style: Theme.of(context)
                  .appBarTheme
                  .textTheme
                  .body1
                  .copyWith(fontSize: 24),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.verified_user),
                  SizedBox(width: 8),
                  Text(
                    "Version 1.0",
                    style: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.code),
                    SizedBox(width: 8),
                    Text(
                      "Open source 🚀",
                      style: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .body1
                          .copyWith(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _interstitialAd?.show();
              },
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.brightness_1),
                    SizedBox(width: 8),
                    Text(
                      "Support me 🎗",
                      style: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .body1
                          .copyWith(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                launchUrl("https://dev.to/chingiz");
              },
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.favorite),
                    SizedBox(width: 8),
                    Text(
                      "Made with ❤️ by Chingiz",
                      style: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .body1
                          .copyWith(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
