import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/loaction_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/location_model.dart';

class LocationController extends GetxController {
  LocationModel? _user;
  bool _loading = true;

  LocationModel? get user => _user;
  bool get isLoading => _loading;

  @override
  void onInit() {
    super.onInit();
    loadUser(); // Automatically load on controller init
  }

  /// Loads the user from the database
  Future<void> loadUser() async {
    _loading = true;
    update();

    _user = await LocationDatabaseHelper.fetchUser();

    _loading = false;
    update();
  }

  /// Saves the new user info and updates state
  Future<void> setUser(LocationModel userModel) async {
    _loading = true;
    update();

    print("Saving user: ${userModel.name}, ${userModel.location}");

    await LocationDatabaseHelper.insertUser(userModel);
    _user = await LocationDatabaseHelper.fetchUser();

    print("Fetched after saving: ${_user?.name}, ${_user?.location}");

    _loading = false;
    update();
  }
}
