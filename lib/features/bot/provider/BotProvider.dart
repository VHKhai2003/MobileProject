import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BotProvider with ChangeNotifier {
  final KBApiService _kbApiService = KBApiService();

  List<Bot> bots = [];
  bool hasNext = false;
  int offset = 0;
  bool isLoading = true;

  BotProvider();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearListBot() {
    offset = 0;
    bots.clear();
    notifyListeners();
  }

  Future<void> loadBots(String keyword) async {
    setLoading(true); // Add this
    try {
      final response =
          await _kbApiService.dio.get(KBApiConstants.crudBot, // Verify endpoint
              queryParameters: {
                "order": "DESC",
                "order_field": "updatedAt",
                "offset": offset,
                "limit": 20,
                "q": keyword
              },
              options: Options(extra: {"requireToken": true}));

      if (response.statusCode == 200) {
        print(response.data); // Debug response
        bots.addAll(List<Bot>.from(
            response.data["data"].map((item) => Bot.fromMap(item))));
        offset = bots.length;
        hasNext = response.data["meta"]["hasNext"];
        notifyListeners();
      }
    } catch (e) {
      print("Error loading bots: $e"); // Add error details
    }
    setLoading(false); // Add this
  }

  Future<Bot> getBotById(String botId) async {
    try {
      final response = await _kbApiService.dio.get(
          '${KBApiConstants.crudBot}/$botId',
          options: Options(extra: {"requireToken": true}));
      if (response.statusCode == 200) {
        return Bot.fromMap(response.data);
      } else {
        throw Exception('Failed to fetch bot data');
      }
    } catch (e) {
      print('Error getting bot by ID: $e');
      rethrow;
    }
  }

  Future<bool> createBot(
      String name, String instructions, String description) async {
    try {
      final response = await _kbApiService.dio.post(KBApiConstants.crudBot,
          data: {
            "assistantName": name,
            "instructions": instructions,
            "description": description
          },
          options: Options(extra: {"requireToken": true}));
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Catch error when create bot");
      return false;
    }
  }

  Future<bool> updateBot(
      String id, String name, String instructions, String description) async {
    try {
      final response = await _kbApiService.dio.patch(
          '${KBApiConstants.crudBot}/$id', // /kb-core/v1/ai-assistant/{assistantId}
          data: {
            "assistantName": name,
            "instructions": instructions,
            "description": description
          },
          options: Options(extra: {"requireToken": true}));

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating bot: $e");
      return false;
    }
  }

  Future<bool> deleteBot(String id) async {
    try {
      final response = await _kbApiService.dio.delete(
          '${KBApiConstants.crudBot}/$id',
          options: Options(extra: {"requireToken": true}));
      return response.statusCode == 200;
    } catch (e) {
      print("Catch error when delete bot");
      return false;
    }
  }
}
