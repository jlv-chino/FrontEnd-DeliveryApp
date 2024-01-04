import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectoflutter/src/models/user.dart';
import 'package:proyectoflutter/src/providers/users_provider.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      User user = User(
          email: email,
          name: name,
          lastname: lastName,
          phone: phone,
          password: password,
          id: '',
          image: '');

      Response response = await usersProvider.create(user);

      print('RESPONSE: ${response.body}');

      Get.snackbar('Formulario', 'Formulario correcto');
    }
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Error en email', 'Email campo vacío');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error en email', 'Email no válido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Error en nombre', 'Nombre campo vacío');
      return false;
    }

    if (lastName.isEmpty) {
      Get.snackbar('Error en apellido', 'Apellido campo vacío');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Error en teléfono', 'Teléfono campo vacío');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Error en password', 'Password campo vacío');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar(
          'Error en confirmar password', 'Confirmar password campo vacío');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulrio no válido', 'Password distintos');
      return false;
    }

    return true;
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {},
        child: Text('GALERIA')
    );
  }
}
