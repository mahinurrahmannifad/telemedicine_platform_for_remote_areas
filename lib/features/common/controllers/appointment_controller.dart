import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/core/database/doctor_database_helper.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
import 'package:uuid/uuid.dart';

class AppointmentController extends ChangeNotifier {
  final DoctorDatabaseService _databaseService = DoctorDatabaseService.instance;
  final Uuid _uuid = const Uuid();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> bookAppointment({
    required String doctorId,
    required DateTime dateTime,
    String notes = '',
    int duration = 30,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final appointment = Appointment(
        id: _uuid.v4(),
        doctorId: doctorId,
        patientId: 'patient_1', // Demo patient ID
        dateTime: dateTime,
        status: AppointmentStatus.scheduled,
        notes: notes,
        duration: duration,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _databaseService.insertAppointment(appointment);
      return true;
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final appointments = await _databaseService.getAppointmentsByPatientId('patient_1');
      final appointment = appointments.firstWhere((a) => a.id == appointmentId);

      final updatedAppointment = appointment.copyWith(
        status: AppointmentStatus.cancelled,
        updatedAt: DateTime.now(),
      );

      await _databaseService.updateAppointment(updatedAppointment);
      return true;
    } catch (e) {
      debugPrint('Error cancelling appointment: $e');
      return false;
    }
  }

  Future<bool> rescheduleAppointment(String appointmentId, DateTime newDateTime) async {
    try {
      final appointments = await _databaseService.getAppointmentsByPatientId('patient_1');
      final appointment = appointments.firstWhere((a) => a.id == appointmentId);

      final updatedAppointment = appointment.copyWith(
        dateTime: newDateTime,
        status: AppointmentStatus.rescheduled,
        updatedAt: DateTime.now(),
      );

      await _databaseService.updateAppointment(updatedAppointment);
      return true;
    } catch (e) {
      debugPrint('Error rescheduling appointment: $e');
      return false;
    }
  }
}