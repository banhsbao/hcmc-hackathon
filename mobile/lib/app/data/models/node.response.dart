class NodeResponse {
  String? nodeId;
  String? gps;
  String? lastUpdate;
  String? latitude;
  String? longitude;
  String? ph;
  String? status;
  String? tds;

  NodeResponse({
    this.nodeId,
    this.gps,
    this.lastUpdate,
    this.latitude,
    this.longitude,
    this.ph,
    this.status,
    this.tds,
  });

  NodeResponse.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    gps = json['gps'];
    lastUpdate = json['last_update'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ph = json['ph'];
    status = json['status'];
    tds = json['tds'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nodeId'] = nodeId;
    data['gps'] = gps;
    data['last_update'] = lastUpdate;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['ph'] = ph;
    data['status'] = status;
    data['tds'] = tds;
    return data;
  }
}
