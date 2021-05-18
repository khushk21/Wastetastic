import 'package:http/http.dart' as http;

/// Controller Class to handle network interaction
class NetworkMgr {
  /// The URL of the site to be accessed using HTTP
  String url;

  /// Named Constructor to initialize the URL to be accessed
  NetworkMgr(String url) : url = url;

  /// Obtains the response from the URL
  ///
  /// Makes use of the HTTP protocol in order to obtain a response from the API
  /// hosted on [url. Returns body of the HTTP response.
  static Future<String> getDataFromURL(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print('Error connecting');
    }
  }
}
