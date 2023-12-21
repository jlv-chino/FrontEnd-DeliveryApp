import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proyectoflutter/src/models/response_api.dart';
import 'package:proyectoflutter/src/providers/users_provider.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        Get.snackbar('Login exitoso', responseApi.message ?? '');
      }else{
        Get.snackbar('Login fállido', responseApi.message ?? '');
      }
    }
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Error en email', 'Email campo vacío');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error en email', 'Email no válido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Error en password', 'Formulario no válido');
      return false;
    }

    return true;
  }
}
