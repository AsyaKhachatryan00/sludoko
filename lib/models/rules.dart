class Rules {
  final String text;

  Rules({required this.text});

  factory Rules.fromJson(Map<String, dynamic> json) =>
      Rules(text: json['text']);

      
}
