class ModelWudhu {
  String? title;
  String? content;

  ModelWudhu(this.title, this.content);

  ModelWudhu.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}
