import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class AppClient {
  AppClient._();

  static AppClient get _instance => AppClient._();

  static AppClient get instance => _instance;

  static const mUrl = "https://659f86b15023b02bfe89c737.mockapi.io/api/v1/";
  static const timeOut = Duration(seconds: 2);
  static final HttpClient _sharedHttpClient = HttpClient()
    ..connectionTimeout = timeOut
    ..idleTimeout = timeOut;

  static HttpClient get _httpClient {
    HttpClient? client;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }());
    return client ?? _sharedHttpClient;
  }

  Stream<T> getStream<T>({
    required String endpoint,
    required T Function(dynamic json) success,
  }) async* {
    final request = await _httpClient.getUrl(Uri.parse(mUrl + endpoint));
    final response = await request.close();
    final mController = StreamController<T>();
    final List<int> chunks = [];

    response.listen(
      (chunk) {
        chunks.addAll(chunk);
      },
      onDone: () {
        final stringDecode = utf8.decode(chunks);
        final mJson = json.decode(stringDecode);

        mController
          ..sink
          ..add(success(mJson));

        mController.close();
      },
      onError: mController.close,
    );

    yield* mController.stream;
  }

  Future<T> get<T>({
    required String endpoint,
    required T Function(dynamic json) success,
  }) async {
    try {
      final request = await _httpClient.getUrl(Uri.parse(mUrl + endpoint));
      final response = await request.close();
      final mData = await response.transform(utf8.decoder).join("");

      final data = json.decode(mData);
      return success(data);
    } finally {}
  }
}
