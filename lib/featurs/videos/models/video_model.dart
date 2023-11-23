class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final String id;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creator,
    required this.creatorUid,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json, String videoId)
      : title = json["title"],
        description = json["description"],
        fileUrl = json["fileUrl"],
        thumbnailUrl = json["thumbnailUrl"],
        creatorUid = json["creatorUid"],
        id = videoId,
        likes = json["likes"],
        comments = json["comments"],
        createdAt = json["createdAt"],
        creator = json["creator"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "creator": creator,
      "id": id,
      "creatorUid": creatorUid,
      "lilkes": likes,
      "comments": comments,
      "createdAt": createdAt,
    };
  }
}
