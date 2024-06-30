import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

const jsonData = '''
    [
      {
        "nodeId": "NODE_SG_07",
        "gps": "w3gvk7",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.7858",
        "longitude":"106.716",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_01",
        "gps": "w3gvk1",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.7748",
        "longitude":"106.705",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_02",
        "gps": "w3gvkw",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.8023",
        "longitude":"106.727",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_03",
        "gps": "w3gvkx",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.8078",
        "longitude":"106.727",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_04",
        "gps": "w3gvsb",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.8133",
        "longitude":"106.738",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_05",
        "gps": "w3gvt5",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.8298",
        "longitude":"106.749",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      },
      {
        "nodeId": "NODE_SG_06",
        "gps": "w3gvsu",
        "last_update": "2024-06-30T14:45:37.123456Z",
        "latitude":"10.8353",
        "longitude":"106.738",
        "ph": "8",
        "status": "polluted",
        "tds": "466"
      }
    ]
    ''';

class NodeRepository extends GetxService {
  String randomizeProperties(String jsonData) {
    final random = Random();
    final List<dynamic> nodeList = jsonDecode(jsonData);

    for (final node in nodeList) {
      // node['gps'] = 'w3gv${List.generate(4, (index) => random.nextInt(10).toString()).join()}';
      // node['latitude'] = (random.nextDouble() * 20 + 10).toStringAsFixed(4);
      // node['longitude'] = (random.nextDouble() * 20 + 100).toStringAsFixed(3);
      node['ph'] = (4 + random.nextInt(4)).toString();
      node['tds'] = random.nextInt(1001).toString();
    }

    return jsonEncode(nodeList);
  }

  Future<String> getNodes() async {
    await Future.delayed(const Duration(seconds: 1));
    final randomizedJsonData = randomizeProperties(jsonData);
    return randomizedJsonData;
  }
}
