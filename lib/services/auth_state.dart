import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

class AuthState extends ChangeNotifier {
  AuthState(this._apiClient);

  final ApiClient _apiClient;
  String? _token;

  bool get isAuthenticated => _token != null;

  Future<void> login(String username, String password) async {
    _token = await _apiClient.login(username, password);
    notifyListeners();
  }

  Future<Experience> createExperience(Experience experience) {
    final token = _token;
    if (token == null) {
      throw const ApiException('Silakan login untuk menambah pengalaman.');
    }
    return _apiClient.createExperience(experience, token);
  }

  Future<void> logout() async {
    final token = _token;
    if (token == null) return;

    await _apiClient.logout(token);
    _token = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _apiClient.close();
    super.dispose();
  }
}
