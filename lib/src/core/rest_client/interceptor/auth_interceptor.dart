// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:html';

import 'package:dio/dio.dart';

import '../../global/constants.dart';
import '../../global/global_context.dart';
import '../../storage/storage.dart';

class AuthInterceptor extends Interceptor {
  final Storage storage;
  AuthInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = storage.getData(SessionStorageKeys.accessToken.key);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      GlobalContext.instance.loginExpire();
      return;
    } else {
      handler.next(err);
    }
  }
}
