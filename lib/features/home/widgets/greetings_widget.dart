import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_platform_for_remote_areas/core/widgets/centered_circular_progress_indicator.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/controllers/location_controller.dart';
import 'package:telemedicine_platform_for_remote_areas/features/common/data/models/location_model.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const CenteredCircularProgressIndicator();
        }

        final user = controller.user;
        if (user == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("User not found", style: TextStyle(fontSize: 16)),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 👇 Now this whole left side is clickable
              GestureDetector(
                onTap: () => _showLocationDialog(context, user),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${user.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// You can keep this notification icon if you want
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.notifications_outlined),
              )
            ],
          ),
        );
      },
    );
  }

  void _showLocationDialog(BuildContext context, LocationModel user) {
    final nameController = TextEditingController(text: user.name);
    final locationController = TextEditingController(text: user.location);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Your Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final location = locationController.text.trim();

                if (name.isNotEmpty && location.isNotEmpty) {
                  final newUser = LocationModel(name: name, location: location);
                  await Get.find<LocationController>().setUser(newUser);
                }

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
