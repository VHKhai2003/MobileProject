class KBApiConstants {
  static const String baseUrl = "https://knowledge-api.dev.jarvis.cx";
  static const String login = "/kb-core/v1/auth/external-sign-in";
  static const String refreshToken = "/kb-core/v1/auth/refresh";
  static const String crudKnowledge = "/kb-core/v1/knowledge";
  static const String getUnits = "/kb-core/v1/knowledge/{id}/units";
  static const String importWeb = "/kb-core/v1/knowledge/{id}/web";
  static const String importConfluence = "/kb-core/v1/knowledge/{id}/confluence";
  static const String importSlack = "/kb-core/v1/knowledge/{id}/slack";
  static const String importDrive = "/kb-core/v1/knowledge/{id}/google-drive";
  static const String importFile = "/kb-core/v1/knowledge/{id}/local-file";
}
