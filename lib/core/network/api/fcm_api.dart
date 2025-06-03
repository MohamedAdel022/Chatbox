import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'fcm_api.g.dart';

@RestApi(baseUrl: "https://fcm.googleapis.com/v1/projects/firstproject-dyyqpw")
abstract class FcmApi {
  factory FcmApi(Dio dio) = _FcmApi;

  @POST("/messages:send")
  Future<void> sendNotification(
    @Header("Authorization") String authorization,
    @Body() Map<String, dynamic> body,
  );
}
