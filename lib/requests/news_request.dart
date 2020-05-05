import 'package:http/http.dart' as http;

class NewsRequest {
  final String url = 'https://dev.to/api/articles';

  Future<http.Response> fetchNews(int page) {
    return http.get("$url?page=$page");
  }

  Future<http.Response> fetchNewsById(int id) {
    return http.get("$url/$id");
  }
}
