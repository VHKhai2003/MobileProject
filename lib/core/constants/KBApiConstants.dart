class KBApiConstants {
  static const String baseUrl = "https://knowledge-api.dev.jarvis.cx";
  static const String login = "/kb-core/v1/auth/external-sign-in";
  static const String refreshToken = "/kb-core/v1/auth/refresh";
  static const String crudKnowledge = "/kb-core/v1/knowledge";
  static const String getUnits = "/kb-core/v1/knowledge/{id}/units";
  static const String crudBot = "/kb-core/v1/ai-assistant";
  static const String importWeb = "/kb-core/v1/knowledge/{id}/web";
  static const String importConfluence =
      "/kb-core/v1/knowledge/{id}/confluence";
  static const String importSlack = "/kb-core/v1/knowledge/{id}/slack";
  static const String importDrive = "/kb-core/v1/knowledge/{id}/google-drive";
  static const String importFile = "/kb-core/v1/knowledge/{id}/local-file";
  static const String getAssistantKnowledges =
      "/kb-core/v1/ai-assistant/{assistantId}/knowledges";
  static const String botAndKB =
      "/kb-core/v1/ai-assistant/{assistantId}/knowledges/{knowledgeId}";
  static const String createThreadBot = "/kb-core/v1/ai-assistant/thread";
  static const String updateNewThread =
      "/kb-core/v1/ai-assistant/thread/playground";
  static const String askBot = "/kb-core/v1/ai-assistant/{assistantId}/ask";
  static const String retrieveMess =
      "/kb-core/v1/ai-assistant/thread/{openAiThreadId}/messages";
  static const String getThead =
      "/kb-core/v1/ai-assistant/{assistantId}/threads";
  static const String botIntegration = '/kb-core/v1/bot-integration';
  static const String guidelineImportConfluence = "https://jarvis.cx/help/knowledge-base/connectors/confluence/";
  static const String guidelineImportSlack = "https://jarvis.cx/help/knowledge-base/connectors/slack/";
  static const String guidelineImportGGDrive = "https://jarvis.cx/help/knowledge-base/connectors/google-drive/";
}
