class NotificationResponse {
  NotifyId? notifyId;
  NotifyId? data;
  NotifyId? userId;
  NotifyId? title;
  NotifyId? body;
  NotifyId? timestamp;

  NotificationResponse({
    this.notifyId,
    this.data,
    this.userId,
    this.title,
    this.body,
    this.timestamp,
  });

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    notifyId =
        json['notifyId'] != null ? NotifyId.fromJson(json['notifyId']) : null;
    data = json['data'] != null ? NotifyId.fromJson(json['data']) : null;
    userId = json['userId'] != null ? NotifyId.fromJson(json['userId']) : null;
    title = json['title'] != null ? NotifyId.fromJson(json['title']) : null;
    body = json['body'] != null ? NotifyId.fromJson(json['body']) : null;
    timestamp =
        json['timestamp'] != null ? NotifyId.fromJson(json['timestamp']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notifyId != null) {
      data['notifyId'] = notifyId!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (body != null) {
      data['body'] = body!.toJson();
    }
    if (timestamp != null) {
      data['timestamp'] = timestamp!.toJson();
    }
    return data;
  }
}

class NotifyId {
  String? s;

  NotifyId({this.s});

  NotifyId.fromJson(Map<String, dynamic> json) {
    s = json['S'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['S'] = s;
    return data;
  }
}
