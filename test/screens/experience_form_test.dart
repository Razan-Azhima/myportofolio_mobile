import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('submits a validated Experience to the backend', (tester) async {
    final requests = <http.Request>[];
    final authState = AuthState(
      ApiClient(
        client: MockClient((request) async {
          requests.add(request);
          if (request.url.path == '/api/v1/auth/token/') {
            return http.Response('{"token":"test-token"}', 200);
          }
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
      ),
    );
    addTearDown(authState.dispose);
    await authState.login('owner', 'secret');

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: authState,
        child: const MaterialApp(home: ExperienceFormPage()),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Research Assistant',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Supported a research project.',
    );
    await tester.tap(find.text('Simpan pengalaman'));
    await tester.pumpAndSettle();

    expect(find.text('Pengalaman berhasil ditambahkan'), findsOneWidget);
    expect(requests.last.url.path, '/api/v1/experiences/');
    expect(requests.last.headers['authorization'], 'Token test-token');
    expect(jsonDecode(requests.last.body)['title'], 'Research Assistant');
  });
}
