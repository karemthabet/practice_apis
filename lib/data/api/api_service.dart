import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:practice_apis/data/api/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static late SharedPreferences pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '';
  }

  static final Dio _dio = Dio();
  static const String baseUrl = 'https://gorest.co.in/public/v2/';
  static String token = '';

  static Future<Either<Failure, dynamic>> get(
      {required String endPoint}) async {
    try {
      var response = await _dio.get(
        '$baseUrl$endPoint',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return right(response.data);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      return left(ServerFailure(
          errMessage: 'Oops, there is an error. Please try again'));
    }
  }
}
