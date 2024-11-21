class ApiConstants {
  static const String baseUrl = "https://api.dev.jarvis.cx";
  static const String getUsage = "/api/v1/tokens/usage";
  static const String refreshToken = "/api/v1/auth/refresh";
  static const String getConversations = "/api/v1/ai-chat/conversations";
  static const String getConversationHistory = "/api/v1/ai-chat/conversations/{conversationId}/messages";
  static const String newThreadChat = "/api/v1/ai-chat";
  static const String sendMessage = "/api/v1/ai-chat/messages";
  static const String crudPrompts = "/api/v1/prompts";
}
