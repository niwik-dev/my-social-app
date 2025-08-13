class AiChatTopics{
  final List<AiChatPrompt> topics;

  AiChatTopics({this.topics = const []});

  factory AiChatTopics.fromJson(Map<String, dynamic> json) {
    return AiChatTopics(
      topics: (json['topics'] as List)
          .map((topic) => AiChatPrompt.fromJson(topic))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}

class AiChatPrompt {
  final String name;
  final String prompt;

  AiChatPrompt({required this.name, required this.prompt});

  factory AiChatPrompt.fromJson(Map<String, dynamic> json) {
    return AiChatPrompt(
      name: json['name'] as String,
      prompt: json['prompt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'prompt': prompt,
    };
  }
}