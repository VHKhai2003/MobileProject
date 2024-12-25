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
    setLoading(true);
    _kbApiService.loadTokens();
    try {
      final response = await _kbApiService.dio.get(KBApiConstants.crudBot,
          queryParameters: {
            "order": "DESC",
            "order_field": "updatedAt",
            "offset": 0,
            "limit": 20,
            "q": keyword
          },
          options: Options(extra: {"requireToken": true}));

      if (response.statusCode == 200) {
        bots.clear();
        bots.addAll(List<Bot>.from(
            response.data["data"].map((item) => Bot.fromMap(item))));
        offset = bots.length;
        hasNext = response.data["meta"]["hasNext"];
        notifyListeners();
      }
    } catch (e) {
      print("Error loading bots: $e");
    }
    setLoading(false);
  }

  Future<Bot> getBot(String id) async {
    try {
      final response = await _kbApiService.dio.get(
        '${KBApiConstants.crudBot}/$id',
        options: Options(extra: {"requireToken": true}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Bot.fromMap(response.data);
      } else {
        throw Exception('Failed to load bot details: No data');
      }
    } catch (e) {
      print("Error getting bot: $e");
      throw Exception('Failed to load bot details');
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

  Future<bool> updateBot(String id, String? name, String? instructions,
      String? description) async {
    try {
      final Map<String, dynamic> data = {};
      if (name != null) data['assistantName'] = name;
      if (instructions != null) data['instructions'] = instructions;
      if (description != null) data['description'] = description;

      final response = await _kbApiService.dio.patch(
          '${KBApiConstants.crudBot}/$id',
          data: data,
          options: Options(extra: {"requireToken": true}));

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating bot: $e");
      return false;
    }
  }

  Future<List<dynamic>> getConfigurations(String assistantId) async {
    try {
      final response = await _kbApiService.dio.get(
        '${KBApiConstants.botIntegration}/$assistantId/configurations',
        options: Options(
          extra: {"requireToken": true},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        print(response.data);
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load bot configurations: No data');
      }
    } catch (e) {
      print("Error getting bot configurations: $e");
      throw Exception('Failed to load bot configurations');
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

  Future<bool> verifyTelegramBot(String assistantId, String botToken) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/telegram/validation',
        data: {"botToken": botToken},
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error verifying telegram bot: $e");
      return false;
    }
  }

  Future<bool> verifySlackBot(
    String assistantId, {
    required String botToken,
    required String clientId,
    required String clientSecret,
    required String signingSecret,
  }) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/slack/validation',
        data: {
          "botToken": botToken,
          "clientId": clientId,
          "clientSecret": clientSecret,
          "signingSecret": signingSecret,
        },
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error verifying slack bot: $e");
      return false;
    }
  }

  Future<bool> verifyMessengerBot(
    String assistantId, {
    required String botToken,
    required String pageId,
    required String appSecret,
  }) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/messenger/validation',
        data: {
          "botToken": botToken,
          "pageId": pageId,
          "appSecret": appSecret,
        },
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error verifying messenger bot: $e");
      return false;
    }
  }

  Future<bool> publishMessengerBot(
    String assistantId, {
    required String botToken,
    required String pageId,
    required String appSecret,
  }) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/messenger/publish/$assistantId',
        data: {
          "botToken": botToken,
          "pageId": pageId,
          "appSecret": appSecret,
        },
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error publishing messenger bot: $e");
      return false;
    }
  }

  Future<bool> publishSlackBot(
    String assistantId, {
    required String botToken,
    required String clientId,
    required String clientSecret,
    required String signingSecret,
  }) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/slack/publish/$assistantId',
        data: {
          "botToken": botToken,
          "clientId": clientId,
          "clientSecret": clientSecret,
          "signingSecret": signingSecret,
        },
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error publishing slack bot: $e");
      return false;
    }
  }

  Future<bool> publishTelegramBot(String assistantId, String botToken) async {
    try {
      final response = await _kbApiService.dio.post(
        '${KBApiConstants.botIntegration}/telegram/publish/$assistantId',
        data: {"botToken": botToken},
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error publishing telegram bot: $e");
      return false;
    }
  }

  Future<bool> disconnectBot(String assistantId, String type) async {
    try {
      final response = await _kbApiService.dio.delete(
        '${KBApiConstants.botIntegration}/$assistantId/$type',
        options: Options(extra: {"requireToken": true}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error disconnecting bot: $e");
      return false;
    }
  }
}
