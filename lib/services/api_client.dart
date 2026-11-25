import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri(String path) {
    final baseUrl = apiBaseUrl.replaceFirst(RegExp(r'/+$'), '');
    return Uri.parse('$baseUrl/api/v1/$path');
  }

  Future<http.Response> _send(Future<http.Response> Function() request) async {
    try {
      return await request();
    } on http.ClientException catch (error) {
      throw ApiException('Tidak dapat terhubung ke server: ${error.message}');
    }
  }

  Object? _decodeResponse(http.Response response) {
    if (response.body.isEmpty) return null;

    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw const ApiException('Server mengirim respons yang tidak valid.');
    }
  }

  void _checkResponse(http.Response response, Object? body) {
    if (response.statusCode >= 200 && response.statusCode < 300) return;

    if (body is Map<String, dynamic>) {
      final detail = body['detail'];
      if (detail is String && detail.isNotEmpty) {
        throw ApiException(detail);
      }

      final errors = body.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join('\n');
      if (errors.isNotEmpty) throw ApiException(errors);
    }

    throw ApiException('Permintaan gagal (HTTP ${response.statusCode}).');
  }

  Future<String> login(String username, String password) async {
    final response = await _send(
      () => _client.post(
        _uri('auth/token/'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      ),
    );
    final body = _decodeResponse(response);
    _checkResponse(response, body);

    if (body is! Map<String, dynamic> || body['token'] is! String) {
      throw const ApiException('Respons login tidak berisi token.');
    }
    return body['token'] as String;
  }

  Future<Experience> createExperience(
    Experience experience,
    String token,
  ) async {
    final response = await _send(
      () => _client.post(
        _uri('experiences/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(experience.toJson()),
      ),
    );
    final body = _decodeResponse(response);
    _checkResponse(response, body);

    if (body is! Map<String, dynamic>) {
      throw const ApiException('Respons Experience dari server tidak valid.');
    }
    return Experience.fromJson(body);
  }

  Future<void> logout(String token) async {
    final response = await _send(
      () => _client.post(
        _uri('auth/logout/'),
        headers: {'Authorization': 'Token $token'},
      ),
    );
    final body = _decodeResponse(response);
    _checkResponse(response, body);
  }

  void close() => _client.close();
}
