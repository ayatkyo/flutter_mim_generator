import 'dart:convert';

class Meme {
  String id;
  String name;
  String url;
  int width;
  int height;

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
  });

  factory Meme.fromMap(Map<String, dynamic> data) => Meme(
    id: data['id'] as String,
    name: data['name'] as String,
    url: data['url'] as String,
    width: data['width'] as int,
    height: data['height'] as int,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'url': url,
    'width': width,
    'height': height,
  };

  factory Meme.fromJson(String data) {
    return Meme.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  Meme copyWith({
    String? id,
    String? name,
    String? url,
    int? width,
    int? height,
    int? boxCount,
  }) {
    return Meme(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
