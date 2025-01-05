import 'package:code/core/constants/KBApiConstants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class KBApiService {
  final Dio _dio = Dio();
  static const _storage = FlutterSecureStorage();

  String? _accessToken;
  String? _refreshToken;

  Dio get dio => _dio;
  String? get token => _accessToken;

  Future<void> init() async {
    await loadTokens();
  }

  KBApiService() {
    _dio.options.baseUrl = KBApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final requireToken = options.extra['requireToken'] ?? false;

        if (requireToken) {
          if (_accessToken == null || await _isTokenExpired()) {
            await _refreshAccessToken();
          }
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));

    loadTokens();
  }

  Future<void> loadTokens() async {
    _accessToken = await _storage.read(key: 'KBAccessToken');
    _refreshToken = await _storage.read(key: 'KBRefreshToken');
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'KBAccessToken', value: accessToken);
    await _storage.write(key: 'KBRefreshToken', value: refreshToken);
  }

  Future<bool> _isTokenExpired() async {
    if (_accessToken == null) return true;
    try {
      final parts = _accessToken!.split('.');
      if (parts.length != 3) throw Exception('Invalid token format');

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      final exp = payload['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return exp - now <= 20;
    } catch (e) {
      return true;
    }
  }

  Future<void> _refreshAccessToken() async {
    await loadTokens();
    try {
      final response = await _dio.get(
        KBApiConstants.refreshToken,
        queryParameters: {
          'refreshToken': _refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['token']['accessToken'];
        _accessToken = newAccessToken;
        await saveTokens(newAccessToken, _refreshToken!);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      throw Exception('Error refreshing token: $e');
    }
  }
}
