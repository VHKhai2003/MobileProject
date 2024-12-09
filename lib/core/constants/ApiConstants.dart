class ApiConstants {
  static const String baseUrl = "https://api.dev.jarvis.cx";
  static const String login = "/api/v1/auth/sign-in";
  static const String loginWithGoogle = "/api/v1/auth/google-sign-in";
  static const String googleOauthClientId =
      "599361404647-e74vpq6s2ab8q6r275s12sdhr36enq5l.apps.googleusercontent.com";
  static const String register = "/api/v1/auth/sign-up";
  static const String logout = "/api/v1/auth/sign-out";
  static const String getUser = "/api/v1/auth/me";
  static const String getUsage = "/api/v1/tokens/usage";
  static const String refreshToken = "/api/v1/auth/refresh";
  static const String getConversations = "/api/v1/ai-chat/conversations";
  static const String getConversationHistory =
      "/api/v1/ai-chat/conversations/{conversationId}/messages";
  static const String newThreadChat = "/api/v1/ai-chat";
  static const String sendMessage = "/api/v1/ai-chat/messages";
  static const String crudPrompts = "/api/v1/prompts";
  static const String replyEmail = "/api/v1/ai-email";
}
