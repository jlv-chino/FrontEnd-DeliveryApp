import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoflutter/src/models/response_api.dart';
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

  ImagePicker picker = ImagePicker();
  File? imageFile;

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

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          goToHomePage();
        }else{
          Get.snackbar('Registro fállido', responseApi.message ?? '');
        }

      });
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
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

    if (imageFile == null) {
      Get.snackbar('Formulrio no válido', 'Seleccionar imagen de perfil');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERÍA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
            'CÁMARA',
          style: TextStyle(
              color: Colors.black
          ),)
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opción'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }
}
