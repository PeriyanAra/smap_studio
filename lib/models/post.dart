class Post {
  int id;
  String title;
  String content;
  String takenAt;
  bool isVideo;
  String base;
  String file;
  String preview;
  String poster;
  int postId;

  Post({
    this.id,
    this.title,
    this.content,
    this.takenAt,
    this.isVideo,
    this.base,
    this.file,
    this.preview,
    this.poster,
    this.postId
  });



  Post.fromApiJson(json) {
    this.id = json['id'];
    this.title = json['title'];
    this.content = json['content'];
    this.takenAt = json['takenAt'];
    this.isVideo = json['is_video'];
    this.base = json['base'];
    this.file = json['file'];
    this.preview = json['preview'];
    this.poster = json['poster'];
    this.postId = json['postId'];
  }
}