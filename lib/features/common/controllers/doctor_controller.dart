// import 'package:flutter/material.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';
//
// class DoctorController extends ChangeNotifier {
//   final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;
//
//   Doctor? _selectedDoctor;
//   bool _isLoading = false;
//
//   Doctor? get selectedDoctor => _selectedDoctor;
//   bool get isLoading => _isLoading;
//
//   Future<void> loadDoctorProfile(String doctorId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _selectedDoctor = await _databaseService.getDoctorById(doctorId);
//     } catch (e) {
//       debugPrint('Error loading doctor profile: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void clearSelectedDoctor() {
//     _selectedDoctor = null;
//     notifyListeners();
//   }
// }


import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';

class DoctorController extends GetxController {
  final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;

  var selectedDoctor = Rxn<Doctor>();
  var isLoading = false.obs;

  Future<void> loadDoctorProfile(String doctorId) async {
    isLoading.value = true;
    try {
      selectedDoctor.value = await _databaseService.getDoctorById(doctorId);
    } catch (e) {
      print('Error loading doctor profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearSelectedDoctor() {
    selectedDoctor.value = null;
  }
}
