import 'package:dev_news/core/news_provider.dart';
import 'package:dev_news/models/news.dart';
import 'package:dev_news/pages/about_page.dart';
import 'package:dev_news/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  List<String> popupMenu = <String>["About", "Dark"];
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).loadNews(page);
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          print("Hits this line ${scrollController.position.pixels}");
          page++;
          Provider.of<NewsProvider>(context, listen: false).loadNews(page);
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchNewsById(BuildContext context, int newsId) async {
    showLoadingDialog();
    var newsProvider = Provider.of<NewsProvider>(context, listen: false);
    await newsProvider.fetchNewsById(newsId);
    News news = newsProvider.getNewsById();
    if (news != null) {
      hideLoadingDialog();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsPage(news: newsProvider.getNewsById()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              pinned: true,
              backgroundColor: backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                collapseMode: CollapseMode.none,
                title: Text(
                  "Dev News",
                  style: Theme.of(context).appBarTheme.textTheme.body1,
                ),
              ),
              actions: <Widget>[
                PopupMenuButton(
                  onSelected: (selected) async {
                    if (selected == "About") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutPage(),
                        ),
                      );
                    } else {
                      if (isDark(context)) {
                        ThemeModeHandler.of(context)
                            .setThemeMode(ThemeMode.light);
                        popupMenu[1] = "Dark";
                      } else {
                        ThemeModeHandler.of(context)
                            .setThemeMode(ThemeMode.dark);
                        popupMenu[1] = "Light";
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return popupMenu.map((choice) {
                      return PopupMenuItem<String>(
                          value: choice, child: Text(choice));
                    }).toList();
                  },
                )
              ],
            ),
          ];
        },
        body: Container(
          color: backgroundColor,
          child: LiquidPullToRefresh(
            onRefresh: () async {
              Provider.of<NewsProvider>(context, listen: false).clearNews();
              page = 1;
              Provider.of<NewsProvider>(context, listen: false).loadNews(page);
            },
            child: ListView.separated(
              padding: EdgeInsets.only(top: 0),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              controller: scrollController,
              itemCount: Provider.of<NewsProvider>(context).allNews.length,
              itemBuilder: (_, index) {
                return myNewsItem(
                    _, Provider.of<NewsProvider>(context).allNews[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget myNewsItem(_, News news) {
    return InkWell(
      onTap: () {
        fetchNewsById(_, news.id);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      news.title.replaceAll("\n", ""),
                      style: Theme.of(_).textTheme.display1,
                    ),
                  ),
                ),
                news.hasFlare()
                    ? Card(
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
                      )
                    : Text('')
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
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
                          style: Theme.of(_).textTheme.display2,
                        ),
                        Text(
                            DateFormat.yMEd()
                                .add_jms()
                                .format(
                                    DateTime.parse(news.published_timestamp))
                                .toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.comment, size: 20, color: Colors.blueGrey),
                    SizedBox(width: 4),
                    Text(
                      "${news.comments_count}",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.favorite_border,
                        size: 20, color: Colors.blueGrey),
                    SizedBox(width: 4),
                    Text("${news.positive_reactions_count}",
                        style: TextStyle(color: Colors.blueGrey))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isDark(_) {
    if (ThemeModeHandler.of(_).themeMode != ThemeMode.dark) return false;
    return true;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
