import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/services/api/api_endpoint.dart';
import 'package:s_box/services/base/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:s_box/services/commonModels/allUsersResponse.dart';
import 'package:s_box/services/commonModels/chatListResponse.dart';
import 'package:s_box/services/commonModels/common_reposne_model.dart';
import 'package:s_box/services/commonModels/editProfileResponse.dart';
import 'package:s_box/services/commonModels/freshFacesResponse.dart';
import 'package:s_box/services/commonModels/membershipModal.dart';
import 'package:s_box/services/commonModels/messageResponse.dart';
import 'package:s_box/services/commonModels/promo_code_response.dart';
import 'package:s_box/services/commonModels/specificUserResponse.dart';
import 'package:s_box/services/commonModels/userAllData.dart';

import '../commonModels/LoginResponseEntity.dart';
import '../commonModels/ServiceDataClass.dart';
import '../commonModels/checkSlotModal.dart';

class ApiController extends BaseRepository {
  final String _accessToken = 'OGFjN2E0Yzg4ZmViODM2ZDAxOGZlZDA5OGY0MDAyNWV8VDlTajY4N0NaZzhHaE1TQQ==';
  final String _entityId = '8ac7a4c88feb836d018fed0b84160266';
  final String _host = 'https://eu-test.oppwa.com/';

  Future<Map<String, dynamic>> makePayment(String amount, String currency, String paymentBrand, String cardNumber, String holder, String expiryMonth, String expiryYear, String cvv) async {
    final url = Uri.parse('${_host}v1/payments');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'entityId': _entityId,
        'amount': amount,
        'currency': currency,
        'paymentBrand': paymentBrand,
        'card.number': cardNumber,
        'card.holder': holder,
        'card.expiryMonth': expiryMonth,
        'card.expiryYear': expiryYear,
        'card.cvv': cvv,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make payment');
    }
  }

  Future<LoginResponseEntity> loginUser(String email, String password) async {
    var uri = Uri.parse(ApiEndpoint.loginUser).replace(queryParameters: {
      'email': email,
      'password': password,
    });

    var apiResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return LoginResponseEntity.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return LoginResponseEntity(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return LoginResponseEntity(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return LoginResponseEntity(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }


  Future<CommonResponseEntity> registerUser(
      String f_name,String l_name, String username, String email, String password) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.registerUser),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'f_name': f_name,
          'l_name': l_name,
          'username': username,
          'email': email,
          'password': password,

        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      print(CommonResponseEntity.fromJson(decodedResponse));
      return CommonResponseEntity.fromJson(decodedResponse);
    }
  }

  Future<CommonResponseEntity> selectUserType(String email, String type) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.selectUser),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'user_type': type,
        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      return CommonResponseEntity.fromJson(decodedResponse);
    }
  }

  Future<CommonResponseEntity> forgotPwd(
    String email,
  ) async {
    var uri = Uri.parse(ApiEndpoint.forgotPwd).replace(queryParameters: {
      'email': email,

    });

    var apiResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (apiResponse.statusCode == 200) {
      {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CommonResponseEntity.fromJson(decodedResponse);
      }
    }else{
      print(apiResponse.statusCode);
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      return CommonResponseEntity.fromJson(decodedResponse);
    }



  }

  Future<CommonResponseEntity> verifyOTP(
  String email,
    String code,
  ) async {
    var uri = Uri.parse(ApiEndpoint.checkOTP).replace(queryParameters: {
      'email': email,
      'code':code,

    });

    var apiResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (apiResponse.statusCode == 200) {
      {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CommonResponseEntity.fromJson(decodedResponse);
      }
    }else{
      print(apiResponse.statusCode);
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      return CommonResponseEntity.fromJson(decodedResponse);
    }

  }

  Future<CommonResponseEntity> newPassword(
      String user_id,String password,String token) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.newPassword),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'id': user_id,

          'password': password,

        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      print(CommonResponseEntity.fromJson(decodedResponse));
      return CommonResponseEntity.fromJson(decodedResponse);
    }
  }

  Future<CommonResponseEntity> updatePassword(
      String user_id,String oldPassword,String password,String token) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.updatePassword),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'id': user_id,

          'old_password': oldPassword,
          'new_password': password,

        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      print(CommonResponseEntity.fromJson(decodedResponse));
      return CommonResponseEntity.fromJson(decodedResponse);
    }
  }

  Future<EditProfileResponse> updateProfile(
      String userId,
      String firstName,
      String lastName,
      String userName,
      String userEmail,
      String token, {
        File? image,
      }) async {
    final url = Uri.parse(ApiEndpoint.updateProfile);

    try {
      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
          ),
        );
      }


      request.fields['id'] = userId;
      request.fields['f_name'] = firstName;
      request.fields['l_name'] = lastName;
      request.fields['username'] = userName;
      request.fields['email'] = userEmail;
      print('Sending fields:${request.fields}');
      // print('id: $userId');
      // print('f_name: $firstName');
      // print('l_name: $lastName');
      // print('username: $userName');
      // print('email: $userEmail');

      print(request.url);
      var streamedResponse = await request.send().timeout((const Duration(seconds: 10)));
      print(streamedResponse.statusCode);


      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print('response 200: update profile: ${response.body}');
        return EditProfileResponse.fromJson(decodedResponse);
      } else if(response.statusCode==413){
        print('Failed to update profile: ${response.body}');
        return EditProfileResponse(status:false,message: 'please uplaod picture Less than 2 MB');
      }else {
        print('Failed to update profile: ${response.body}');
        return Future.error('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      return EditProfileResponse(status:false,message: 'Week Internet Connection');
    }
  }

  // Future<Map<String, dynamic>?> addTicket(String userId,
  //     String firstName,
  //     String lastName,
  //     String userName,
  //     String userEmail,
  //     String token, {
  //       File? image,
  //     }) async {
  //   final dio = Dio();
  //
  //   // print('price is ${widget.capturedImage.runtimeType}');
  //   try {
  //     final formData = FormData.fromMap({
  //       'id': 6,
  //       'f_name': userName,
  //       'l_name': lastName,
  //       'username': userName,
  //       'email': email,
  //
  //     });
  //     Options options = Options(
  //       headers: {
  //         'Authorization': 'Bearer $token', // Pass the token here
  //         'Content-Type': 'multipart/form-data', // Adjust content type if needed
  //       },
  //     );
  //     final response = await dio.put(
  //         ApiEndpoint.updateProfile,data:formData,options: options
  //       // queryParameters: {
  //       //   'driver_id': userid,
  //       //   'date': date??"",
  //       //   'pcn': pcn??"",
  //       //   'price': double.tryParse(price??'0'),
  //       //   'ticket_issuer': issuer??"",
  //       //   'image':await MultipartFile.fromFile(imageFile.path),
  //       // },
  //     );
  //     print(response.data);
  //
  //     final responseData = response.data as Map<String, dynamic>;
  //
  //     if (response.statusCode == 200) {
  //       final status = responseData['status'] as bool;
  //       final message = responseData['message'] as String;
  //
  //       if (status) {
  //         print(' response${response.data}');
  //         return response.data;
  //
  //       } else if(message=="The selected driver id is invalid."){
  //         print(' response${response.data}');
  //         return response.data;
  //
  //       } else {
  //         // Handle the case where login failed
  //         print('Login failed: $message');
  //         return {
  //           'status': status,
  //           'message': message,
  //         };
  //       }
  //     } else {
  //       // Handle error status codes (e.g., show an error message)
  //       print('API request failed with status code ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle network errors or exceptions
  //     print('API request error: $e');
  //     return null;
  //   }
  // }
  //
  // Future<CommonResponseEntity> updateProfileold(
  //     String userId, String firstName, String lastName, String userName, String userEmail, String token, {File? image}) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse(ApiEndpoint.updateProfile),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'id': int.parse(userId),
  //         'f_name': firstName,
  //         'l_name': lastName,
  //         'email': userEmail,
  //         'username': userName,
  //         'image': image != null
  //             ? await MultipartFile.fromFile(image.path)
  //             : null,
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       final decodedResponse = jsonDecode((response.body));
  //       return CommonResponseEntity.fromJson(decodedResponse);
  //     } else {
  //       // Handle the error by decoding the error response or logging it
  //       print('Failed to update profile: ${response.statusCode}');
  //       return Future.error('Failed to update profile: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //     return Future.error('Error occurred: $e');
  //   }
  // }

    Future<MembershipDataclass> addMembership(
      String user_id,String name,String price,int discount,String active_time,String expire_time,String token) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.addMembership),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'appuser_id': user_id,
          'name': name,
          'price': price,
          'discount': discount,
          'active_time': active_time,

          'expire_time': expire_time,

        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      print(MembershipDataclass.fromJson(decodedResponse));
      return MembershipDataclass.fromJson(decodedResponse);
    }
  }

  Future<ServiceDataClass> addService(
      String user_id,String name,String price,String date,String time,String duration,String token) async {
    var apiResponse = await http.post(Uri.parse(ApiEndpoint.addService),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'appuser_id': user_id,
          'name': name,
          'price': price,
          'date': date,
          'time': time,
          'duration': duration,

        }));
    {
      var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      print(ServiceDataClass.fromJson(decodedResponse));
      return ServiceDataClass.fromJson(decodedResponse);
    }
  }


  Future<CheckSlotModal> checkSlot(String date,String slot, String token) async {
    var uri = Uri.parse(ApiEndpoint.checkSlots).replace(queryParameters: {
      'date': date,
      'slot': slot,

    });

    var apiResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CheckSlotModal.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return CheckSlotModal(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CheckSlotModal(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return CheckSlotModal(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<UserAllData> getUserData(String userId, String token) async {
    var uri = Uri.parse(ApiEndpoint.userData).replace(queryParameters: {
      'id': userId,


    });

    var apiResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 30));

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return UserAllData.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return UserAllData(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return UserAllData(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return UserAllData(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<FreshFacesResponse> getAllUsers(String token) async {


    var apiResponse = await http.get(
      Uri.parse(ApiEndpoint.allUser),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return FreshFacesResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return FreshFacesResponse(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return FreshFacesResponse(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return FreshFacesResponse(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<FreshFacesResponse> getFreshFaces(String token) async {
    // var uri = Uri.parse(ApiEndpoint.freshFaces).replace(queryParameters: {
    //   'id': userId,
    //
    //
    // });

    var apiResponse = await http.get(
      Uri.parse(ApiEndpoint.freshFaces),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return FreshFacesResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return FreshFacesResponse(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return FreshFacesResponse(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return FreshFacesResponse(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<PromoCodeResponse> getPromoCode(String token,String promoCode) async {
    var uri =  Uri.parse(ApiEndpoint.promo).replace(queryParameters: {
      'promo': promoCode,


    });

    var apiResponse = await http.get(
     uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return PromoCodeResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return PromoCodeResponse(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return PromoCodeResponse(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return PromoCodeResponse(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<SpecificUserResponse> getSpecificUser(String token,String user_id) async {
    var uri =  Uri.parse(ApiEndpoint.getSpecificUser).replace(queryParameters: {
      'user_id': user_id,
    });

    var apiResponse = await http.get(
     uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return SpecificUserResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return SpecificUserResponse(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return SpecificUserResponse(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return SpecificUserResponse(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<MessageResponse> getAllMessages(String token,String user_id,String receiver_id) async {
    var uri =  Uri.parse(ApiEndpoint.getUserChat).replace(queryParameters: {
      'sender_id': user_id,
      'receiver_id': receiver_id,
    });

    var apiResponse = await http.get(
     uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return MessageResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return MessageResponse(success: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return MessageResponse(
          success: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return MessageResponse(
          success: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<ChatListResponse> getAllChats(String token,String user_id )async {
    var uri =  Uri.parse(ApiEndpoint.getChatList).replace(queryParameters: {
      'user_id': user_id,

    });

    var apiResponse = await http.get(
     uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return ChatListResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return ChatListResponse(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return ChatListResponse(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return ChatListResponse(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }
  Future<CommonResponseEntity> deleteUser(String userId, String token) async {
    var uri = Uri.parse(ApiEndpoint.deleteUser).replace(queryParameters: {
      'id': userId,


    });

    var apiResponse = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${apiResponse.statusCode}');
    print('Response body: ${apiResponse.body}');

    if (apiResponse.statusCode == 200) {
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CommonResponseEntity.fromJson(decodedResponse);
      } catch (e) {
        print('Error decoding response: $e');
        return CommonResponseEntity(status: false, message: 'Error decoding response');
      }
    } else {
      // return CommonResponseEntity(status: false, message: 'Error: ${apiResponse.body}');
      try {
        var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
        return CommonResponseEntity(
          status: false,
          message: decodedResponse['error'] ?? 'Unknown error occurred',
        );
      } catch (e) {
        print('Error decoding error response: $e');
        return CommonResponseEntity(
          status: false,
          message: 'Error: ${apiResponse.body}',
        );
      }
    }
  }

}
