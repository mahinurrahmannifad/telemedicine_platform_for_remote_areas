import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/app/assets_path.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/slider_database_helper.dart';
import '../data/models/slider_model.dart';


class HomeSliderController extends GetxController {
  bool _loading = true;
  List<SliderModel> _sliders = [];

  bool get isLoading => _loading;
  List<SliderModel> get sliders => _sliders;

  Future<void> loadSliders() async {
    _loading = true;
    update();

    _sliders = await SliderDatabaseHelper.fetchSliders();

    _loading = false;
    update();
  }

  Future<void> addSampleSlider() async {
    await SliderDatabaseHelper.insertSlider(
      SliderModel(
        assetPath: AssetsPath.bannerSvg,
      ),
    );
    await loadSliders();
  }
}
