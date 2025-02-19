import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final KBApiService _kbApiService = KBApiService();
  final TokenUsageProvider _tokenUsageProvider;

  AuthProvider(this._tokenUsageProvider);

  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   serverClientId: ApiConstants.googleOauthClientId,
  //   scopes: ['email', 'profile', 'openid'],
  // );
  //
  // Future<String?> getGoogleAuthToken() async {
  //   try {
  //     print('>>> hahahaha');
  //     final GoogleSignInAccount? account = await _googleSignIn.signIn();
  //     print('>>> hihihihi');
  //     print('>>> account ${account.toString()}');
  //     // if (account != null) {
  //     //   final GoogleSignInAuthentication auth = await account.authentication;
  //     //   print('>>> idToken ${auth.idToken}');
  //     //   print('>>> accessToken ${auth.idToken}');
  //     //   return auth.idToken;
  //     // }
  //   } catch (error) {
  //     print('Google Sign-In failed: $error');
  //   }
  //   return null;
  // }

  Future<String?> loginWithGoogle(String token) async {
    try {
      final response = await _apiService.dio.post(ApiConstants.loginWithGoogle,
          data: {"token": token});
      if (response.statusCode == 200) {
        final accessToken = response.data['token']['accessToken'];
        final refreshToken = response.data['token']['refreshToken'];
        await _apiService.saveTokens(accessToken, refreshToken!);
        await _tokenUsageProvider.getUsage();
        await _tokenUsageProvider.getUser();
        return "success";
      }
      return "fail";
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        } else {
          print("Error message: ${e.message}");
          return "Please check your Internet connection.";
        }
      }
      return "Something went wrong! Please try again.";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await _apiService.dio.post(ApiConstants.login,
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        final accessToken = response.data['token']['accessToken'];
        final refreshToken = response.data['token']['refreshToken'];
        await _apiService.saveTokens(accessToken, refreshToken!);
        await _tokenUsageProvider.getUsage();
        await _tokenUsageProvider.getUser();
        await signInKnowledgeBase(accessToken);
        _tokenUsageProvider.setIsAuthenticated(true);
        return "success";
      }
      return "fail";
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        } else {
          print("Error message: ${e.message}");
          return "Please check your Internet connection.";
        }
      }
      return "Something went wrong! Please try again.";
    }
  }

  Future<void> signInKnowledgeBase(String accessToken) async {
    try {
      final response = await _kbApiService.dio.post(
          KBApiConstants.login,
          data: {
            "token": accessToken,
          }
      );
      if(response.statusCode == 200) {
        final accessToken = response.data['token']['accessToken'];
        final refreshToken = response.data['token']['refreshToken'];
        await _kbApiService.saveTokens(accessToken, refreshToken);
      }
      else {
        print('Error when sign in knowledge base');
      }
    }
    catch(e) {
      print('Catch Exception: Error when sign in knowledge base');
    }
  }

  Future<String?> register(String email, String password, String username) async {
    try {
      final response = await _apiService.dio.post(ApiConstants.register,
          data: {"email": email, "password": password, "username": username});

      if (response.statusCode == 201) {
        final user = response.data['user'];
        if (user != null) {
          return "success";
        }
        return "Invalid response format";
      }
      return "fail";
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        }
        return "Network error: ${e.message}";
      }
      return "Unknown error: $e";
    }
  }

  Future<String?> logout() async {
    _tokenUsageProvider.setIsAuthenticated(false);

    try {
      final response = await _apiService.dio.get(
        ApiConstants.logout,
        options: Options(
          extra: {'requireToken': true},
        )
      );

      if (response.statusCode == 200) {
        return "success";
      }
      return "fail";
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
        }
        return "Network error: ${e.message}";
      }
      return "Unknown error: $e";
    }
  }
}
