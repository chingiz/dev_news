import 'dart:convert';

import 'package:dev_news/models/news.dart';
import 'package:dev_news/requests/news_request.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<News> _allNews = [];
  List<News> get allNews => _allNews;
  int pageNumber = 1;
  News _news;
  News get news => _news;

  Future<bool> loadNews(int page) async {
    await NewsRequest().fetchNews(page).then(
      (data) {
        Iterable list = json.decode(data.body);
        if (data.statusCode == 200) {
          appendNews(list.map((model) => News.fromJson(model)).toList());
        }
      },
    );
    return isReady();
  }

  Future<bool> fetchNewsById(int id) async {
    await NewsRequest().fetchNewsById(id).then(
      (data) {
        if (data.statusCode == 200) {
          setNewsById(News.fromJson(json.decode(data.body)));
        }
      },
    );
    return isReadyById();
  }

  void setNewsById(value) {
    _news = value;
    notifyListeners();
  }

  News getNewsById() {
    return _news;
  }

  void appendNews(value) {
    _allNews.addAll(value);
    notifyListeners();
  }

  void clearNews() {
    _allNews.clear();
    notifyListeners();
  }

  bool isReady() {
    return _allNews != null ? true : false;
  }

  bool isReadyById() {
    return _news != null ? true : false;
  }
}
