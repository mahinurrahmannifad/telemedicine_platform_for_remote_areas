
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/auth_controller.dart';

class MainBottomNavBarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    update();
  }

  bool shouldNavigate(int index) {
    if (index == 2 || index == 3) {
      return Get.find<AuthController>().isValidUser();
    }
    return true;
  }

  void moveToCategory() {
    changeIndex(1);
  }

  void backToHome() {
    changeIndex(0);
  }
}