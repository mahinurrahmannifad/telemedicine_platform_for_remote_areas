// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/appointment/ui/screens/appointment.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/doctor_controller.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/messaging/ui/screens/chat_screen.dart';
// import 'package:telemedicine_platform_for_remote_areas/features/video_call/ui/screens/video_call_screen.dart';
//
//
// class DoctorProfile extends StatefulWidget {
//   final String doctorId;
//
//   const DoctorProfile({
//     super.key,
//     required this.doctorId,
//   });
//
//   @override
//   State<DoctorProfile> createState() => _DoctorProfileState();
// }
//
// class _DoctorProfileState extends State<DoctorProfile> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<DoctorController>().loadDoctorProfile(widget.doctorId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Consumer<DoctorController>(
//         builder: (context, controller, child) {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final doctor = controller.selectedDoctor;
//           if (doctor == null) {
//             return const Center(child: Text('Doctor not found'));
//           }
//
//           return CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 300,
//                 pinned: true,
//                 backgroundColor: AppColors.themeColor,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       CachedNetworkImage(
//                         imageUrl: doctor.imageUrl,
//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) => Container(
//                           color: AppColors.themeColor.withValues(alpha: 0.3),
//                           child: const Icon(
//                             Icons.person,
//                             size: 100,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withValues(alpha:0.7),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         left: 20,
//                         right: 20,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               doctor.name,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Text(
//                               doctor.qualification,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 RatingBarIndicator(
//                                   rating: doctor.rating,
//                                   itemBuilder: (context, index) => const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                   ),
//                                   itemCount: 5,
//                                   itemSize: 20.0,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   '${doctor.rating} (${doctor.experience} exp)',
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildInfoCards(doctor),
//                       const SizedBox(height: 24),
//                       _buildAboutSection(doctor),
//                       const SizedBox(height: 24),
//                       _buildActionButtons(doctor),
//                       const SizedBox(height: 100), // Bottom padding for fixed buttons
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: Consumer<DoctorController>(
//         builder: (context, controller, child) {
//           final doctor = controller.selectedDoctor;
//           if (doctor == null) return const SizedBox.shrink();
//
//           return Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: AppColors.cardColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () => _startVideoCall(doctor.id),
//                     icon: const Icon(Icons.videocam),
//                     label: const Text('Video Call'),
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: AppColors.themeColor),
//                       foregroundColor: AppColors.themeColor,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () => _bookAppointment(doctor),
//                     icon: const Icon(Icons.calendar_today),
//                     label: const Text('Book Appointment'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.themeColor,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildInfoCards(doctor) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildInfoCard(
//             'Working Time',
//             doctor.workingTime,
//             Icons.access_time,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _buildInfoCard(
//             'Consultation Fee',
//             '${doctor.consultationFee} BDT',
//             Icons.payment,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoCard(String title, String value, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             color: AppColors.themeColor,
//             size: 24,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               color: AppColors.textSecondary,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textPrimary,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAboutSection(doctor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'About Doctor',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.cardColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Text(
//             doctor.about,
//             style: const TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary,
//               height: 1.5,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButtons(doctor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quick Actions',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _buildActionButton(
//                 'Send Message',
//                 Icons.message,
//                     () => _openChat(doctor.id),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildActionButton(
//                 'View Reviews',
//                 Icons.star,
//                     () => _viewReviews(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.themeColor.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: AppColors.themeColor.withValues(alpha: 0.3),
//           ),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               color: AppColors.themeColor,
//               size: 24,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.themeColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _openChat(String doctorId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//           receiverId: doctorId,
//           receiverName: context.read<DoctorController>().selectedDoctor?.name ?? 'Doctor',
//         ),
//       ),
//     );
//   }
//
//   void _startVideoCall(String doctorId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VideoCallScreen(
//           channelName: 'call_$doctorId',
//           isIncoming: false,
//         ),
//       ),
//     );
//   }
//
//   void _bookAppointment(doctor) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AppointmentBookingScreen(doctor: doctor),
//       ),
//     );
//   }
//
//   void _viewReviews() {
//     // Navigate to reviews screen
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Reviews feature coming soon!'),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';
import 'package:telemedicine_platform_for_remote_areas/features/appointment/ui/screens/appointment.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/doctor_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/messaging/ui/screens/chat_screen.dart';
import 'package:telemedicine_platform_for_remote_areas/features/video_call/ui/screens/video_call_screen.dart';

class DoctorProfile extends StatelessWidget {
  final String doctorId;
  DoctorProfile({super.key, required this.doctorId});

  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    // Load doctor profile once
    controller.loadDoctorProfile(doctorId);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final doctor = controller.selectedDoctor.value;
        if (doctor == null) {
          return const Center(child: Text('Doctor not found'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColors.themeColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: doctor.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.themeColor.withValues(alpha: 0.3),
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            doctor.qualification,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: doctor.rating,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${doctor.rating} (${doctor.experience} exp)',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCards(doctor),
                    const SizedBox(height: 24),
                    _buildAboutSection(doctor),
                    const SizedBox(height: 24),
                    _buildActionButtons(context, doctor),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final doctor = controller.selectedDoctor.value;
        if (doctor == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _startVideoCall(context, doctor.id),
                  icon: const Icon(Icons.videocam),
                  label: const Text('Video Call'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.themeColor),
                    foregroundColor: AppColors.themeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _bookAppointment(context, doctor),
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Book Appointment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCards(doctor) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Working Time',
            doctor.workingTime,
            Icons.access_time,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            'Consultation Fee',
            '${doctor.consultationFee} BDT',
            Icons.payment,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.themeColor, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Doctor',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            doctor.about,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Send Message',
                Icons.message,
                    () => _openChat(context, doctor.id),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'View Reviews',
                Icons.star,
                    () => _viewReviews(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.themeColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.themeColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.themeColor, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _openChat(BuildContext context, String doctorId) {
    final name = controller.selectedDoctor.value?.name ?? 'Doctor';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(receiverId: doctorId, receiverName: name),
      ),
    );
  }

  void _startVideoCall(BuildContext context, String doctorId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(channelName: 'call_$doctorId', isIncoming: false),
      ),
    );
  }

  void _bookAppointment(BuildContext context, doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentBookingScreen(doctor: doctor),
      ),
    );
  }

  void _viewReviews(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reviews feature coming soon!')),
    );
  }
}
