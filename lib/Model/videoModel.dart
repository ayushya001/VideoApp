

class videoModel {
  videoModel({
    required this.title,
    required this.time,
    required this.videoId,
    required this.videoUrl,
    required this.location,
    required this.thumbnailUrl,
    required this.by,
    required this.uploaderpic,
  });
  late final String title;
  late final String time;
  late final String videoId;
  late final String videoUrl;
  late final String location;
  late final String thumbnailUrl;
  late final String by;
  late final String uploaderpic;

  videoModel.fromJson(Map<String, dynamic> json){
    title = json['title']?? '';
    time = json['time']?? '';
    videoId = json['videoId']?? '';
    videoUrl = json['videoUrl']?? '';
    location = json['location']?? '';
    thumbnailUrl = json['thumbnailUrl']?? '';
    by = json['by']?? '';
    uploaderpic = json['uploaderpic']?? '';


  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['time'] = time;
    _data['videoId'] = videoId;
    _data['videoUrl'] = videoUrl;
    _data['location'] = location;
    _data['thumbnailUrl'] = thumbnailUrl;
    _data['by'] = by;
    _data['uploaderpic'] = uploaderpic;
    return _data;
  }
}