// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/widgets/appointment_card.dart';
// import 'package:telemedicine_platform_for_remote_areas/core/widgets/doctor_card.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/appointment/ui/screens/appointment.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/appointment_controller.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/home_controller.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/doctors/ui/screens/doctor_profile.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/home_carousel_slider.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/greetings_widget.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/specialty_selector.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<HomeController>().initialize();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Consumer<HomeController>(
//           builder: (context, controller, child) {
//             if (controller.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 36),
//                     const GreetingsWidget(),
//                     const SizedBox(height: 4),
//                     const HomeCarouselSlider(),
//                     const SizedBox(height: 16),
//                     _buildUpcomingAppointments(controller.upcomingAppointments),
//                     const SizedBox(height: 32),
//                     _buildSpecialistSection(controller),
//                     const SizedBox(height: 32),
//                     _buildTopDoctorsSection(controller.getTopDoctors()),
//                   ],
//                 ),
//               ),
//             );
//
//           },
//         ),
//       ),
//     );
//   }
//   Widget _buildUpcomingAppointments(List<Appointment> appointments) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Upcoming Appointments',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.amber,
//           ),
//         ),
//         const SizedBox(height: 16),
//         if (appointments.isEmpty)
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.amber,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: const Center(
//               child: Text(
//                 'No upcoming appointments',
//                 style: TextStyle(
//                   color: Colors.amber,
//                 ),
//               ),
//             ),
//           )
//         else
//           ...appointments.map((appointment) => AppointmentCard(
//             appointment: appointment,
//             onCancel: () => _handleCancelAppointment(appointment.id),
//             onReschedule: () => _handleRescheduleAppointment(appointment.id),
//           )),
//       ],
//     );
//   }
//
//   Widget _buildSpecialistSection(HomeController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Specialist',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.amber,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to all specialists
//               },
//               child: const Text(
//                 'View All',
//                 style: TextStyle(
//                   color: Colors.amber,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         SpecialtySelector(
//           specialties: controller.specialties,
//           selectedSpecialty: controller.selectedSpecialty,
//           onSpecialtySelected: controller.selectSpecialty,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTopDoctorsSection(List<Doctor> doctors) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Top Doctors',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.amber,
//           ),
//         ),
//         const SizedBox(height: 16),
//         ...doctors.map((doctor) => DoctorCard(
//           doctor: doctor,
//           onTap: () => _navigateToDoctorProfile(doctor),
//           onBookAppointment: () => _navigateToBookingScreen(doctor),
//         )),
//       ],
//     );
//   }
//
//   void _navigateToDoctorProfile(Doctor doctor) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DoctorProfile(doctorId: doctor.id),
//       ),
//     );
//   }
//
//   void _navigateToBookingScreen(Doctor doctor) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AppointmentBookingScreen(doctor: doctor),
//       ),
//     );
//   }
//
//   void _handleCancelAppointment(String appointmentId) {
//     // Show confirmation dialog and cancel appointment
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Cancel Appointment'),
//         content: const Text('Are you sure you want to cancel this appointment?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               context.read<HomeController>().initialize(); // Refresh data
//             },
//             child: const Text('Yes, Cancel'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _handleRescheduleAppointment(String appointmentId) async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 90)),
//     );
//
//     if (!mounted) return; // Check after first async operation
//     if (date == null) return;
//
//     final time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (!mounted) return; // Check after second async operation
//     if (time == null) return;
//
//     final newDateTime = DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//
//     final success = await context
//         .read<AppointmentController>()
//         .rescheduleAppointment(appointmentId, newDateTime);
//
//     if (!mounted) return; // Check after third async operation
//
//     if (success) {
//       context.read<HomeController>().initialize(); // Refresh data
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Appointment rescheduled successfully')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to reschedule appointment')),
//       );
//     }
//   }
//
//
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/appointment_card.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/doctor_card.dart';
import 'package:telemedicine_platform_for_remote_areas/features/appointment/ui/screens/appointment.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/appointment_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/home_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/appointment_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/doctor_model.dart';
import 'package:telemedicine_platform_for_remote_areas/features/doctors/ui/screens/doctor_profile.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/home_carousel_slider.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/greetings_widget.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/specialty_selector.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final AppointmentController appointmentController = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const GreetingsWidget(),
                  const SizedBox(height: 8),
                  const HomeCarouselSlider(),
                  const SizedBox(height: 16),
                  _buildUpcomingAppointments(homeController.upcomingAppointments),
                  const SizedBox(height: 16),
                  _buildSpecialistSection(),
                  const SizedBox(height: 16),
                  _buildTopDoctorsSection(homeController.getTopDoctors()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildUpcomingAppointments(List<Appointment> appointments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Appointments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 16),
        if (appointments.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                'No upcoming appointments',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        else
          ...appointments.map((appointment) => AppointmentCard(
            appointment: appointment,
            onCancel: () => _handleCancelAppointment(appointment.id),
            onReschedule: () => _handleRescheduleAppointment(appointment.id),
          )),
      ],
    );
  }

  Widget _buildSpecialistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Specialist',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all specialists
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() => SpecialtySelector(
          specialties: homeController.specialties,
          selectedSpecialty: homeController.selectedSpecialty.value,
          onSpecialtySelected: homeController.selectSpecialty,
        )),
      ],
    );
  }

  Widget _buildTopDoctorsSection(List<Doctor> doctors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Doctors',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 16),
        ...doctors.map((doctor) => DoctorCard(
          doctor: doctor,
          onTap: () => _navigateToDoctorProfile(doctor),
          onBookAppointment: () => _navigateToBookingScreen(doctor),
        )),
      ],
    );
  }

  void _navigateToDoctorProfile(Doctor doctor) {
    Get.to(() => DoctorProfile(doctorId: doctor.id));
  }

  void _navigateToBookingScreen(Doctor doctor) {
    Get.to(() => AppointmentBookingScreen(doctor: doctor));
  }

  void _handleCancelAppointment(String appointmentId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              homeController.initialize(); // Refresh data
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRescheduleAppointment(String appointmentId) async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final success = await appointmentController.rescheduleAppointment(appointmentId, newDateTime);

    if (success) {
      homeController.initialize(); // Refresh data
      Get.snackbar('Success', 'Appointment rescheduled successfully');
    } else {
      Get.snackbar('Error', 'Failed to reschedule appointment');
    }
  }
}

