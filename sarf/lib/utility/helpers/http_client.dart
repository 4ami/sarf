part of 'helpers_lib.dart';

final class HttpClient {
  // HttpClient._internal();

  // static final HttpClient _ = HttpClient._internal();
  // static HttpClient get instance => _;

  HttpClient();

  final String _host = CloudSource.host;

  Map<String, String> get defaultHeaders {
    return {'Content-Type': "application/json"};
  }

  Uri _buildURI(String endpoint, [Map<String, dynamic>? queryParams]) {
    return Uri.http(_host, endpoint, queryParams);
  }

  Map<String, String> _setHeaders(Map<String, String>? clientHeaders) {
    return {...defaultHeaders, ...?clientHeaders};
  }

  Future<T> post<T extends BaseResponse>({
    required BaseRequest body,
    required String endpoint,
    required T Function(dynamic json) parser,
    Map<String, String>? headers,
  }) async {
    print(_setHeaders(headers));
    final Uri uri = _buildURI(endpoint);
    http.Response response = await http.post(
      uri,
      body: body.encoded,
      headers: _setHeaders(headers),
    );

    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    if (response.statusCode == 422) {
      Map<String, dynamic> details = jsonBody['detail'][0];
      throw '${details['loc'][1]}: ${details['msg'].toString().split('Value error, ')[1]}';
    }

    return parser(jsonBody);
  }

  Future<T> put<T extends BaseResponse>({
    required BaseRequest body,
    required String endpoint,
    required T Function(dynamic json) parser,
    Map<String, String>? headers,
  }) async {
    final Uri uri = _buildURI(endpoint);
    http.Response response = await http.put(
      uri,
      body: body.encoded,
      headers: _setHeaders(headers),
    );
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    if (response.statusCode == 422) {
      Map<String, dynamic> details = jsonBody['detail']['detail'][0];
      throw '${details['loc'][1]}: ${details['msg'].toString().split('Value error, ')[1]}';
    }
    return parser(jsonBody);
  }

  Future<T> delete<T extends BaseResponse>({
    required BaseRequest body,
    required String endpoint,
    required T Function(dynamic json) parser,
    Map<String, String>? headers,
  }) async {
    final Uri uri = _buildURI(endpoint);
    http.Response response = await http.delete(
      uri,
      body: body.encoded,
      headers: _setHeaders(headers),
    );
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    if (response.statusCode == 422) {
      Map<String, dynamic> details = jsonBody['detail']['detail'][0];
      throw '${details['loc'][1]}: ${details['msg'].toString().split('Value error, ')[1]}';
    }
    return parser(jsonBody);
  }

  Future<T> get<T extends BaseResponse>({
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    required String endpoint,
    required T Function(dynamic json) parser,
    Map<String, String>? headers = const {'just': 'testing'},
  }) async {
    if (pathParams != null) {
      pathParams.forEach((k, v) {
        endpoint = endpoint.replaceAll(
          '{$k}',
          Uri.encodeComponent(v.toString()),
        );
      });
    }

    final Uri uri = _buildURI(endpoint, queryParams);
    http.Response response = await http.get(uri, headers: _setHeaders(headers));
    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    if (response.statusCode == 422) {
      Map<String, dynamic> details = jsonBody['detail']['detail'][0];
      throw '${details['loc'][1]}: ${details['msg'].toString().split('Value error, ')[1]}';
    }
    return parser(jsonBody);
  }
}
