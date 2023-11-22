class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int lilkes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creator,
    required this.creatorUid,
    required this.lilkes,
    required this.comments,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "creator": creator,
      "creatorUid": creatorUid,
      "lilkes": lilkes,
      "comments": comments,
      "createdAt": createdAt,
    };
  }
}
