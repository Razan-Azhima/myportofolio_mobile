import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  test('login requests and returns a Django REST Framework token', () async {
    final client = ApiClient(
      client: MockClient((request) async {
        expect(request.url.path, '/api/v1/auth/token/');
        expect(jsonDecode(request.body), {
          'username': 'owner',
          'password': 'secret',
        });
        return http.Response('{"token":"test-token"}', 200);
      }),
    );
    addTearDown(client.close);

    expect(await client.login('owner', 'secret'), 'test-token');
  });

  test(
    'createExperience posts writable fields with token authentication',
    () async {
      final client = ApiClient(
        client: MockClient((request) async {
          expect(request.url.path, '/api/v1/experiences/');
          expect(request.headers['authorization'], 'Token test-token');
          expect(jsonDecode(request.body), {
            'title': 'Research Assistant',
            'description': 'Supported a research project.',
            'category': 'research',
            'thumbnail': null,
            'ended_at': null,
          });
          return http.Response(
            jsonEncode({
              'id': 'd7c6fe53-430a-41f0-9e4a-81898f4e3d68',
              'title': 'Research Assistant',
              'description': 'Supported a research project.',
              'category': 'research',
              'thumbnail': null,
              'thumbnail_direct_url': '',
              'started_at': '2025-01-10T09:00:00Z',
              'ended_at': null,
              'star_count': 0,
              'is_starred': false,
            }),
            201,
          );
        }),
      );
      addTearDown(client.close);

      final created = await client.createExperience(
        const Experience(
          title: 'Research Assistant',
          description: 'Supported a research project.',
          category: 'research',
        ),
        'test-token',
      );

      expect(created.id, 'd7c6fe53-430a-41f0-9e4a-81898f4e3d68');
      expect(created.title, 'Research Assistant');
    },
  );
}
