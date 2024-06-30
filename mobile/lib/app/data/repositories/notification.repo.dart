import 'dart:convert';

import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/models/notification.response.dart';

final jsonData = '''
    [
      {
          "notifyId": {
              "S": "8beeb140-58c1-42c3-bf64-3b6fdf095ca9"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "${DateTime.now().toIso8601String()}"
          }
      },
      {
          "notifyId": {
              "S": "f93eee88-bfca-47d6-8853-2a52ccf3dba5"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "${DateTime.now().add(const Duration(seconds: 32)).toIso8601String()}"
          }
      },
      {
          "notifyId": {
              "S": "50e574f4-b618-4139-8a55-0b4bd68e1e0c"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:39.295856"
          }
      },
      {
          "notifyId": {
              "S": "27197bb5-dc3d-48cd-ad89-7bb69b6ae18e"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:38.626531"
          }
      },
      {
          "notifyId": {
              "S": "78151183-56f6-4582-8132-753795265f68"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:39.599420"
          }
      },
      {
          "notifyId": {
              "S": "cf93fdf0-f60a-4cc0-b029-43c0229ad9d7"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:30.364837"
          }
      },
      {
          "notifyId": {
              "S": "52a595ec-c859-4787-ba56-1f279573161e"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:14.453622"
          }
      },
      {
          "notifyId": {
              "S": "5c57082d-146d-4d6c-b584-0133140e855b"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:30.693000"
          }
      },
      {
          "notifyId": {
              "S": "a52c2fc7-d647-4fb3-b38f-4fdb95629814"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:31.020616"
          }
      },
      {
          "notifyId": {
              "S": "af60a14e-43ae-4940-9c19-c7380a32b8b4"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:14.150818"
          }
      },
      {
          "notifyId": {
              "S": "d16e022c-e9f0-4b8b-a3cd-f2c45d0cbb4a"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:11.880818"
          }
      },
      {
          "notifyId": {
              "S": "21a34586-de7d-40a4-8e59-0e1669bcc086"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:32.332799"
          }
      },
      {
          "notifyId": {
              "S": "021ecb11-16e2-467a-86e5-e837c68ca2ae"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:12.511819"
          }
      },
      {
          "notifyId": {
              "S": "d1515aa2-b3b5-46de-b9f9-f58778970e62"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:40.583029"
          }
      },
      {
          "notifyId": {
              "S": "1665be0d-5433-40d1-992d-448675993748"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:12.839623"
          }
      },
      {
          "notifyId": {
              "S": "077d0a38-c13e-455b-ac02-b35d653e542f"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:37.654971"
          }
      },
      {
          "notifyId": {
              "S": "c6e2e0ae-5c5b-42c2-b1c2-3787b7b028b4"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:32.005151"
          }
      },
      {
          "notifyId": {
              "S": "34b522c1-bfac-494e-8e31-e6066bbfd86b"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:14.781736"
          }
      },
      {
          "notifyId": {
              "S": "3d95e674-f389-4624-9339-d9367c7a5966"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:38.967880"
          }
      },
      {
          "notifyId": {
              "S": "321af0f5-de74-44a7-9204-1e3dfe695c29"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:39.926667"
          }
      },
      {
          "notifyId": {
              "S": "018e42ba-45ea-4bfe-9d28-03cd7d714dec"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:32.660867"
          }
      },
      {
          "notifyId": {
              "S": "0f354b8a-865b-4c7a-b47a-ec8c2a220686"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:31.348792"
          }
      },
      {
          "notifyId": {
              "S": "cead3c37-cbc6-431d-9370-f4de278cace1"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:40:29.656948"
          }
      },
      {
          "notifyId": {
              "S": "1cded962-ab86-45cf-be85-5626a8b426a0"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:13.495391"
          }
      },
      {
          "notifyId": {
              "S": "27140609-2049-46e1-9c3c-fe19e97a47c8"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:38.335801"
          }
      },
      {
          "notifyId": {
              "S": "4379f4fd-a258-4b56-a7ca-88123e72aa66"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:41:40.255150"
          }
      },
      {
          "notifyId": {
              "S": "e48c5a1c-b54a-4bcf-bcf6-cb78c12c0e61"
          },
          "data": {
              "S": "{'title': 'Water Pollution Alert', 'body': 'Hi bao, the water near you is currently polluted. Please be careful!'}"
          },
          "userId": {
              "S": "test-user-02"
          },
          "title": {
              "S": "Water Pollution Alert"
          },
          "body": {
              "S": "Hi bao, the water near you is currently polluted. Please be careful!"
          },
          "timestamp": {
              "S": "2024-06-29T19:37:13.167706"
          }
      }
    ]
    ''';

class NotificationRepository extends GetxService {
  Future<List<NotificationResponse>> getUserNotifications() async {
    await Future.delayed(const Duration(seconds: 2));
    final data = jsonDecode(jsonData) as List<dynamic>;
    return data.map((e) => NotificationResponse.fromJson(e)).toList();
  }

  void onRefresh() {}
}
