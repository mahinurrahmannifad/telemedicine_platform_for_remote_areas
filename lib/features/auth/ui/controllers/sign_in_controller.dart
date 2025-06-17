import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/user_db_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/data/models/sign_in_request_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/data/models/user_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInRequestModel request) async {
    _inProgress = true;
    update();

    final userData = await UserDBHelper().getUser(request.email.trim());

    if (userData == null) {
      _errorMessage = "User not found.";
      _inProgress = false;
      update();
      return false;
    }

    final hashedInputPassword = sha256
        .convert(utf8.encode(request.password))
        .toString();
    if (userData['password'] != hashedInputPassword) {
      _errorMessage = "Incorrect password.";
      _inProgress = false;
      update();
      return false;
    }

    final user = UserModel(
      email: userData['email'],
      id: '',
      firstName: '',
      lastName: '',
      phone: '',
      avatarUrl: '',
      city: '',
      // add other fields as needed
    );

    await Get.find<AuthController>().saveUserData('offline_token', user);

    _errorMessage = null;
    _inProgress = false;
    update();
    return true;
  }
}
