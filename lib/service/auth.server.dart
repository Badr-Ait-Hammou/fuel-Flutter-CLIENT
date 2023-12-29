import 'dart:convert';
import 'package:fuelflutter/core/utils/api_url.dart';
import 'package:fuelflutter/service/storage.service.dart';
import 'package:http/http.dart' as http;

class Authentification {
  final headers = {'Content-Type': 'application/json'};

  Future<http.Response> login(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('${ApiUrl.flaskUrl}/login'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData['access_token']);
        print(responseData['refresh_token']);
        await StorageService().setToken(responseData['access_token']);
        await StorageService().setRefreshToken(responseData['refresh_token']);
        print('object response ===> $response');
        return response;
      } else {
        print('login service failed with status code $response');
        return response;
      }
    } catch (e) {
      print('login service response $e');
      throw Exception('Failed to log in');
    }
  }

  Future<http.Response> register(
      String email, String password, String nom, String prenom) async {
    try {
      final data = {
        'email': email,
        'nom': nom,
        'password': password,
        'prenom': prenom,
      };

      final response = await http.post(Uri.parse('${ApiUrl.flaskUrl}/register'),
          headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData['access_token']);
        print(responseData['refresh_token']);
        await StorageService().setToken(responseData['access_token']);
        await StorageService().setRefreshToken(responseData['refresh_token']);
        return response;
      } else {
        print('registration service failed with status code $response');
      }
      return response;
    } catch (e) {
      print('registration service response $e');
      throw Exception('Failed to register');
    }
  }
}
