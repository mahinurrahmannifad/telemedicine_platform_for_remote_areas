import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/loaction_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/location_model.dart';


class LocationController extends GetxController {
  LocationModel? _user;
  bool _loading = true;

  LocationModel? get user => _user;
  bool get isLoading => _loading;

  Future<void> loadUser() async {
    _loading = true;
    update();
    _user = await LocationDatabaseHelper.fetchUser();
    if (_user == null) {
      final dummy = LocationModel(name: "Mahinur", location: "Tongi, Gazipur");
      await LocationDatabaseHelper.insertUser(dummy);
      _user = await LocationDatabaseHelper.fetchUser();
    }
    _loading = false;
    update();
  }

  Future<void> setUser(LocationModel userModel) async {
    await LocationDatabaseHelper.insertUser(userModel);
    await loadUser();
  }
}
