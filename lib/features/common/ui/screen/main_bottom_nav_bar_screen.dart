import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/ui/screens/sign_in_screen.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/ui/screens/home_screen.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  static const String name= '/main-bottom-nav-bar-screen';

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final List<Widget> _screens=[
     HomeScreen(),
    // const SearchScreen(),
    // const Appointments(),
    // const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.find<HomeSliderController>().getSliders();
      // Get.find<CategoryController>().getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
          builder: (controller) {
            return _screens[controller.selectedIndex];
          }
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
          builder: (controller) {
            return NavigationBar(
              selectedIndex: controller.selectedIndex,
              onDestinationSelected: (int index) {
                if (controller.shouldNavigate(index)) {
                  controller.changeIndex(index);
                }
                else {
                  Get.to(() => const SignInScreen());
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Appointments'),
                NavigationDestination(
                    icon: Icon(Icons.supervised_user_circle), label: 'Profile'),
              ],
            );
          }
      ),
    );
  }
}
