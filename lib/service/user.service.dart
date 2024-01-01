import 'dart:convert';
import 'package:fuelflutter/core/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:fuelflutter/model/fuel.model.dart';
import 'package:fuelflutter/service/storage.service.dart';

import '../model/user.model.dart';

class UserService {
  Future<Map<String, dynamic>?> decodeToken() async {
    final token = await StorageService().getToken();
    if (token != null) {
      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = base64.decode(base64.normalize(parts[1]));
          final payloadString = utf8.decode(payload);
          return json.decode(payloadString);
        }
      } catch (e) {
        print('Error decoding token: $e');
      }
    }

    return null;
  }

  Future<FuelModel> getFuelPrices() async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.flaskUrl}/prices'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return FuelModel.fromJson(data);
      } else {
        throw Exception('Failed to load fuel prices');
      }
    } catch (e) {
      throw Exception('Error fetching fuel prices: $e');
    }
  }

  Future<UserModel> getUserInfo() async {
    try {
      final Map<String, dynamic>? decodedToken = await decodeToken();
      if (decodedToken != null && decodedToken.containsKey('id')) {
        final userId = decodedToken['id'];
        final token = await StorageService().getToken();
        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };
        final response = await http.get(Uri.parse('${ApiUrl.springUrl}/api/users/$userId'),headers: headers,);
        if (response.statusCode == 200) {
          final Map<String, dynamic> userData = json.decode(response.body);
          return UserModel.fromJson(userData);
        } else {
          throw Exception('Failed to load user information');
        }
      } else {
        throw Exception('User ID not found in the decoded token');
      }
    } catch (e) {
      throw Exception('Error fetching user information: $e');
    }
  }

  Future<http.Response> submitFuelConsumption(String type, double prix) async {
    try {
      final token = await StorageService().getToken();
      final Map<String, dynamic>? decodedToken = await decodeToken();
      if (decodedToken != null && decodedToken.containsKey('sub')) {
        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        final data = {
          "type": type,
          "totale": prix,
          "user": {"id": decodedToken['id']}
        };

        final response = await http.post(
          Uri.parse('${ApiUrl.springUrl}/api/fuel/'),
          headers: headers,
          body: json.encode(data), 
        );
        print(
            'Request response: $response response status ${response.statusCode}');
        return response;
      } else {
        return http.Response('User id not found', 400);
      }
    } catch (e) {
      return http.Response('Error submitting fuel consumption: $e', 500);
    }
  }


  Future<UserModel?> updateProfile(String updatedNom, String updatedPrenom) async {
    try {
      final token = await StorageService().getToken();
      final Map<String, dynamic>? decodedToken = await decodeToken();
      final userId = decodedToken?['id'];
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final data = {
        'nom': updatedNom,
        'prenom': updatedPrenom,
      };

      final response = await http.put(
        Uri.parse('${ApiUrl.springUrl}/api/users/update/$userId'),
        headers: headers,
        body: json.encode(data),
      );
      print('Update Profile Response: ${response.body}');
      print('Update Profile Status Code: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> updatedUserData = json.decode(response.body);
          return UserModel.fromJson(updatedUserData);
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to update profile: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Update Profile Error: $e');
      throw Exception('Error updating profile: $e');
    }
  }


}
