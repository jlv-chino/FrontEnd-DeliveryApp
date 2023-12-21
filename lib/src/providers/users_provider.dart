import 'package:get/get.dart';
import 'package:proyectoflutter/src/environment/environment.dart';
import 'package:proyectoflutter/src/models/user.dart';

import '../models/response_api.dart';

class UsersProvider extends GetConnect {

  String url = Environment.API_URL + 'api/users';

  Future<Response> create(User user) async{

    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    );

    return response;

  }

  Future<ResponseApi> login(String email, String password) async{

    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    );

    if(response.body == null){
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;

  }

}