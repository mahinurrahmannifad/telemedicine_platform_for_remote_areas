// import 'package:flutter/material.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';
//
//
// class HomeController extends ChangeNotifier {
//   final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;
//
//   List<Doctor> _doctors = [];
//   List<Appointment> _upcomingAppointments = [];
//   String _selectedSpecialty = 'Cardiologist';
//   bool _isLoading = false;
//
//   List<Doctor> get doctors => _doctors;
//   List<Appointment> get upcomingAppointments => _upcomingAppointments;
//   String get selectedSpecialty => _selectedSpecialty;
//   bool get isLoading => _isLoading;
//
//   List<String> get specialties => ['Cardiologist', 'Dentist', 'Pathologist', 'Gynecologist', 'Orthopedic'];
//
//   Future<void> initialize() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       await loadDoctors();
//       await loadUpcomingAppointments();
//     } catch (e) {
//       debugPrint('Error initializing home: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> loadDoctors() async {
//     try {
//       _doctors = await _databaseService.getAllDoctors();
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error loading doctors: $e');
//     }
//   }
//
//   Future<void> loadUpcomingAppointments() async {
//     try {
//       // Using a dummy patient ID for demo purposes
//       _upcomingAppointments = await _databaseService.getAppointmentsByPatientId('patient_1');
//       _upcomingAppointments = _upcomingAppointments
//           .where((appointment) => appointment.status == AppointmentStatus.scheduled)
//           .toList();
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Error loading appointments: $e');
//     }
//   }
//
//   void selectSpecialty(String specialty) {
//     _selectedSpecialty = specialty;
//     notifyListeners();
//   }
//
//   List<Doctor> getDoctorsBySelectedSpecialty() {
//     return _doctors.where((doctor) => doctor.specialty == _selectedSpecialty).toList();
//   }
//
//   List<Doctor> getTopDoctors() {
//     final sortedDoctors = List<Doctor>.from(_doctors);
//     sortedDoctors.sort((a, b) => b.rating.compareTo(a.rating));
//     return sortedDoctors.take(10).toList();
//   }
// }


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';

class HomeController extends GetxController {
  final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;

  // Observables
  var doctors = <Doctor>[].obs;
  var upcomingAppointments = <Appointment>[].obs;
  var selectedSpecialty = 'Cardiologist'.obs;
  var isLoading = false.obs;

  List<String> get specialties => [
    'Cardiologist',
    'Dentist',
    'Pathologist',
    'Gynecologist',
    'Orthopedic'
  ];

  @override
  void onInit() {
    super.onInit();
    initialize(); // Load data automatically when the controller is created
  }

  Future<void> initialize() async {
    isLoading.value = true;
    try {
      await loadDoctors();
      await loadUpcomingAppointments();
    } catch (e) {
      debugPrint('Error initializing home: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDoctors() async {
    try {
      doctors.value = await _databaseService.getAllDoctors();
    } catch (e) {
      debugPrint('Error loading doctors: $e');
    }
  }

  Future<void> loadUpcomingAppointments() async {
    try {
      final data = await _databaseService.getAppointmentsByPatientId('patient_1');
      upcomingAppointments.value =
          data.where((appointment) => appointment.status == AppointmentStatus.scheduled).toList();
    } catch (e) {
      debugPrint('Error loading appointments: $e');
    }
  }

  void selectSpecialty(String specialty) {
    selectedSpecialty.value = specialty;
  }

  List<Doctor> getDoctorsBySelectedSpecialty() {
    return doctors.where((doctor) => doctor.specialty == selectedSpecialty.value).toList();
  }

  List<Doctor> getTopDoctors() {
    final sortedDoctors = List<Doctor>.from(doctors);
    sortedDoctors.sort((a, b) => b.rating.compareTo(a.rating));
    return sortedDoctors.take(10).toList();
  }
}
