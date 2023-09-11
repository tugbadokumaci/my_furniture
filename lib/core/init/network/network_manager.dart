// import 'dart:io';

// import 'package:my_furniture/core/base/model/base_error.dart';
// import 'package:my_furniture/core/base/model/base_model.dart';
// import 'package:my_furniture/core/constants/app/app_constants.dart';
// import 'package:dio/dio.dart';

// class NetworkManager {
//   static NetworkManager? _instance;
//   static NetworkManager get instance => _instance ??= NetworkManager._init();

//   NetworkManager._init();

//   Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: ApplicationConstants.BASE_URL,
//       headers: {
//         'Content-Type': 'application/json',
//         'charset': 'utf-8',
//         'Access-Control-Allow': '*',
//         // val: LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)
//       },
//     ),
//   );

//   // _dio.interceptors.add(
//   //   InterceptorsWrapper(
//   //     onRequest: (Request options){
//   //       options.path += 'api';
//   //       return options;
//   //     }
//   //     ,
//   //     onError: (error) {
//   //   return BaseError(error.message);
//   // }
//   // ));

//   // Dio _dio;

//   Future<void> dioGet<T extends BaseModel>(String path, T model) async {
//     final response = await _dio.get(path);

//     switch (response.statusCode) {
//       case HttpStatus.ok:
//         final responseBody = response.data;
//         if (responseBody is List) {
//           return responseBody.map((e) => model.fromJson(e)).toList();
//         } else if (responseBody is Map) {
//           return model.fromJson(responseBody);
//         }
//         return responseBody;
//       default:
//     }
//   }

//   Future<Response> get(String path) async {
//     final response = await _dio.get(path);
//     return response;
//   }
// }
