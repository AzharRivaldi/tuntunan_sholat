class ModelTayammum {
  String? title;
  String? content;

  ModelTayammum(this.title, this.content);

  ModelTayammum.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}
