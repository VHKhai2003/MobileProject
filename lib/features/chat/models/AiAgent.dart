class AiAgent {
  String id;
  String name;
  String image;
  AiAgent(this.id, this.name, this.image);

  static AiAgent base_ai_models_label = AiAgent("base-ai-models-label", "Base AI models", 'assets/icons/gpt-4o-mini.png');
  static AiAgent assistant_label = AiAgent("assistant-label", "Assistants", 'assets/icons/gpt-4o-mini.png');
  static AiAgent gpt_4o_mini = AiAgent("gpt-4o-mini", "GPT-4o mini", 'assets/icons/gpt-4o-mini.png');
  static AiAgent gpt_4o = AiAgent("gpt-4o", "GPT-4o", 'assets/icons/gpt-4o.png');
  static AiAgent gemini_15_flash = AiAgent("gemini-1.5-flash-latest", "Gemini 1.5 Flash", 'assets/icons/gemini-15-flash.webp');
  static AiAgent gemini_15_pro = AiAgent("gemini-1.5-pro-latest", "Gemini 1.5 Pro", 'assets/icons/gemini-15-pro.png');
  static AiAgent claude_3_haiku = AiAgent("claude-3-haiku-20240307", "Claude 3 Haiku", 'assets/icons/claude-3-haiku.jpg');
  static AiAgent claude_35_sonnet = AiAgent("claude-3-sonnet-20240229", "Claude 3.5 Sonnet", 'assets/icons/claude-3-haiku.jpg');

  static AiAgent? findById(String id) {
    if (id == gpt_4o_mini.id) return gpt_4o_mini;
    if (id == gpt_4o.id) return gpt_4o;
    if (id == gemini_15_flash.id) return gemini_15_flash;
    if (id == gemini_15_pro.id) return gemini_15_pro;
    if (id == claude_3_haiku.id) return claude_3_haiku;
    if (id == claude_35_sonnet.id) return claude_35_sonnet;
    return null;
  }

  static AiAgent? findByName(String name) {
    if (name == gpt_4o_mini.name) return gpt_4o_mini;
    if (name == gpt_4o.name) return gpt_4o;
    if (name == gemini_15_flash.name) return gemini_15_flash;
    if (name == gemini_15_pro.name) return gemini_15_pro;
    if (name == claude_3_haiku.name) return claude_3_haiku;
    if (name == claude_35_sonnet.name) return claude_35_sonnet;
    return null;
  }
}