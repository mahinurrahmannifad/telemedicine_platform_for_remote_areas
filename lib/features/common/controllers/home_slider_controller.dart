import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/slider_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/slider_model.dart';

class HomeSliderController extends GetxController {
  bool _getSlidersInProgress = false;
  List<SliderModel> _sliderList = [];
  String? _errorMessage;

  List<SliderModel> get sliders => _sliderList;
  bool get getSlidersInProgress => _getSlidersInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getSliders() async {
    _getSlidersInProgress = true;
    update();

    try {
      _sliderList = await SliderDatabaseHelper.getSliders();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load sliders';
      return false;
    } finally {
      _getSlidersInProgress = false;
      update();
    }
  }

  Future<void> addSlider(SliderModel slider) async {
    await SliderDatabaseHelper.insertSlider(slider);
    await getSliders();
  }

  Future<void> resetSliders() async {
    await SliderDatabaseHelper.deleteAllSliders();
    await getSliders();
  }
}
