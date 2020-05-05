import 'package:dev_news/models/news.dart';
import 'package:dev_news/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  final News news;
  // final controller = ScrollController();
  // SlidingUpPanelController panelController = SlidingUpPanelController();
  var bgColors = [
    Color(0xFFF2F5F7),
    Color(0xFFF8F2E5),
    Color(0xFF000000),
    Color(0xFF5A5A5C),
    Color(0xFF333333)
  ];

  NewsPage({Key key, @required this.news});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var bodyMarkdown = news.body_markdown;
    var bodyHtml = parse(news.body_html).body.text;
    var min = (bodyHtml.length / 1500).round() == 0
        ? 1
        : (bodyHtml.length / 1500).round();
    // .replaceAllMapped(
    //     RegExp("^---.+.+?\---", multiLine: true, dotAll: false, unicode: true, caseSensitive: false),
    //     (match) {
    //   return '';
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          "$min min. read",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          news.hasFlare()
              ? Center(
                  child: Card(
                    color: HexColor.fromHex(news.flare_tag['bg_color_hex']),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        news.flare_tag['name'],
                        style: TextStyle(
                            fontSize: 12,
                            color: HexColor.fromHex(
                                news.flare_tag['text_color_hex'])),
                      ),
                    ),
                  ),
                )
              : Text(''),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                launchUrl(news.url);
              })
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    news.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    news.user["profile_image_90"]))),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            news.user['username'],
                            style: Theme.of(context).textTheme.display2,
                          ),
                          Text(
                              DateFormat.yMEd()
                                  .add_jms()
                                  .format(
                                      DateTime.parse(news.published_timestamp))
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SafeArea(
                    child: MarkdownBody(
                      onTapLink: (url) => launchUrl(url),
                      // selectable: true,
                      data: bodyMarkdown,
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
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
