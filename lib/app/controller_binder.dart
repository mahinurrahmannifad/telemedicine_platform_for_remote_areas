import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/auth_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/appointment_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/doctor_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/home_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/home_slider_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/location_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/main_bottom_nav_bar_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainBottomNavBarController());
    Get.put(SignInController());
    Get.put(HomeSliderController()).addSampleSlider();
    Get.put(LocationController());
    Get.put(AppointmentController());
    Get.put(DoctorController());
    Get.put(HomeController());
  }

}