import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';

class RLTBotAndKBProvider with ChangeNotifier {
  final KBApiService _kbApiService = KBApiService();

  List<Knowledge> knowledges = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  bool hasNext = false;

  Future<void> getAssistantKnowledges({
    required String assistantId,
    String? query,
    String order = 'DESC',
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.get(
        KBApiConstants.getAssistantKnowledges
            .replaceAll('{assistantId}', assistantId),
        queryParameters: {
          if (query != null && query.isNotEmpty) 'q': query,
          'order': order,
          if (orderField != null && orderField.isNotEmpty)
            'order_field': orderField,
          'offset': offset,
          'limit': limit.clamp(1, 50),
        },
        options: Options(
          headers: {
            'x-jarvis-guid': null,
          },
          extra: {"requireToken": true},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (offset == 0) {
          knowledges.clear();
        }

        final List<dynamic> knowledgeList = data['data'] ?? [];

        final List<Knowledge> newKnowledges = knowledgeList.map((item) {
          return Knowledge.fromMap(item);
        }).toList();

        knowledges.addAll(newKnowledges);
        notifyListeners();

        hasNext = data['meta']?['hasNext'] ?? false;
      }
    } catch (e) {
      print('Error loading assistant knowledges: $e');
      hasError = true;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> importKnowledgeToAssistant(
      String assistantId, String knowledgeId) async {
    try {
      final response = await _kbApiService.dio.post(
        KBApiConstants.botAndKB
            .replaceAll('{assistantId}', assistantId)
            .replaceAll('{knowledgeId}', knowledgeId),
        options: Options(
          headers: {
            'x-jarvis-guid': null,
          },
          extra: {"requireToken": true},
        ),
      );

      final success = response.statusCode == 200 || response.statusCode == 201;
      if (success) {
        await getAssistantKnowledges(assistantId: assistantId);
      }
      return success;
    } catch (e) {
      print('Error importing knowledge to assistant: $e');
      return false;
    }
  }

  Future<bool> deleteKnowledgeFromAssistant(
      String assistantId, String knowledgeId) async {
    try {
      final response = await _kbApiService.dio.delete(
        KBApiConstants.botAndKB
            .replaceAll('{assistantId}', assistantId)
            .replaceAll('{knowledgeId}', knowledgeId),
        options: Options(
          headers: {
            'x-jarvis-guid': null,
          },
          extra: {"requireToken": true},
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting knowledge from assistant: $e');
      return false;
    }
  }

  void clearKnowledges() {
    knowledges.clear();
    hasNext = false;
    notifyListeners();
  }

  void removeKnowledge(String knowledgeId) {
    knowledges.removeWhere((k) => k.id == knowledgeId);
    notifyListeners();
  }
}
