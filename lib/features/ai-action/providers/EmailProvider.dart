import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/ai-action/models/EmailResponse.dart';
import 'package:code/features/ai-action/models/SuggestIdeas.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EmailProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final TokenUsageProvider _tokenUsageProvider;

  EmailProvider(this._tokenUsageProvider);

  EmailResponse? _emailResponse;
  bool _isDisplayReply = false;
  SuggestIdeas? _suggestIdeas;
  bool _isLoadingSuggestIdeas = false;

  EmailResponse? get emailResponse => _emailResponse;
  bool get isDisplayReply => _isDisplayReply;
  SuggestIdeas? get suggestIdeas => _suggestIdeas;
  bool get isLoadingSuggestIdeas => _isLoadingSuggestIdeas;

  void setEmailResponse (EmailResponse? value) {
    _emailResponse = value;
    notifyListeners();
  }
  void setIsDisplayReply(bool value) {
    _isDisplayReply = value;
    notifyListeners();
  }
  void setIsLoadingSuggestIdeas(bool value) {
    _isLoadingSuggestIdeas = value;
    notifyListeners();
  }

  Future<void> replyEmail(String email, String action, String mainIdea, String length, String formality, String tone) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstants.replyEmail,
        data: {
          "email": email,
          "action": action,
          "mainIdea": mainIdea,
          "metadata": {
            "context": [],
            "subject": "",
            "sender": "",
            "receiver": "",
            "style": {
              "length": length,
              "formality": formality,
              "tone": tone
            },
            "language": ""
          }
        },
        options: Options(
          extra: {'requireToken': true},
        )
      );
      if (response.statusCode == 200) {
        print(response.data);
        _emailResponse = EmailResponse.fromJson(response.data);
        _tokenUsageProvider.setTokenUsage(_emailResponse!.remainingUsage);
        notifyListeners();
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        } else {
          print("Error message: ${e.message}");
        }
      }
    }
  }

  Future<void> getSuggestIdeas(String email) async {
    setIsLoadingSuggestIdeas(true);
    try {
      final response = await _apiService.dio.post(
          ApiConstants.suggestIdeasReplyEmail,
          data: {
            "email": email,
            "action": "Suggest 3 ideas for this email",
            "metadata": {
              "context": [],
              "subject": "",
              "sender": "",
              "receiver": "",
              "language": ""
            }
          },
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _suggestIdeas = SuggestIdeas.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        } else {
          print("Error message: ${e.message}");
        }
      }
    } finally {
      setIsLoadingSuggestIdeas(false);
    }
  }

}
