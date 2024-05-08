class ModelSholatSunnah {
  String? title;
  String? content;

  ModelSholatSunnah(this.title, this.content);

  ModelSholatSunnah.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}