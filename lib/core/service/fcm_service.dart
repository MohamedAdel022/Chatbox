import 'package:chat/constants.dart';
import 'package:chat/core/network/api/fcm_api.dart';
import 'package:chat/core/network/dio_client.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FcmService {
  final FcmApi _fcmApi;
  FcmService() : _fcmApi = FcmApi(DioClient().dio);
  Future<String> _getAccessToken() async {
    final jsonString = await rootBundle.loadString(KnotificationKey);
    final accountCredentials =
        auth.ServiceAccountCredentials.fromJson(jsonString);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client =
        await auth.clientViaServiceAccount(accountCredentials, scopes);
    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }

  Future<void> sendNotification({
    required String recipientFCMToken,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    try {
      final accessToken = await _getAccessToken();
      final authorization = 'Bearer $accessToken';

      final requestBody = {
        'message': {
          'token': recipientFCMToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': data,
        },
      };

      await _fcmApi.sendNotification(authorization, requestBody);
    } catch (e) {
      throw Exception('Failed to send notification: $e');
    }
  }
}
