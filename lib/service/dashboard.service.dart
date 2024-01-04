import 'dart:convert';
import 'package:fuelflutter/model/operation.model.dart';
import 'package:fuelflutter/service/storage.service.dart';
import 'package:fuelflutter/service/user.service.dart';
import 'package:http/http.dart' as http;
import '../core/utils/api_url.dart';
import '../model/chart.dart';
class DashboardService {
  Future<List<TransactionData>> getUserTransactions() async {
    try {
      final token = await StorageService().getToken();
      final Map<String, dynamic>? decodedToken = await UserService().decodeToken();
      if (decodedToken != null && decodedToken.containsKey('sub')) {
        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };
        final userid = decodedToken['id'];
        final response = await http.get(
          Uri.parse('${ApiUrl.springUrl}/api/fuel/user/id/$userid'),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final List<dynamic> dataList = json.decode(response.body);
          final List<TransactionData> transactions = dataList
              .map((data) => TransactionData.fromJson(data))
              .toList();
          print('Transactions List:');
          for (var transaction in transactions) {
            print('ID: ${transaction.id}, Amount: ${transaction.price}, Date: ${transaction.date}');
          }
          return transactions;
        } else {
          throw Exception('Failed to load transactions');
        }
      } else {
        throw Exception('Decoded token does not contain a valid "sub" key');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }

  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      final token = await StorageService().getToken();
      final response = await http.delete(
        Uri.parse('${ApiUrl.springUrl}/api/fuel/delete/$transactionId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete transaction');
      }
    } catch (e) {
      throw Exception('Error deleting transaction: $e');
    }
  }

  Future<List<ChartDataOne>> getPieOne() async {
    try {
      final token = await StorageService().getToken();
      final Map<String, dynamic>? decodedToken =
      await UserService().decodeToken();
      if (decodedToken != null && decodedToken.containsKey('id')) {
        final headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse('${ApiUrl.springUrl}/api/fuel/pie/${decodedToken['id']}'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          return data.map((item) => ChartDataOne.fromJson(item)).toList();
        } else {
          throw Exception('Failed to load fuel prices');
        }
      }
    } catch (e) {
      throw Exception('Error fetching fuel prices: $e');
    }

    throw Exception('Unexpected error occurred');
    }
}
