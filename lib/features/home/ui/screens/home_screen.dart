import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/home_carousel_slider.dart';
import 'package:telemedicine_platform_for_remote_areas/features/home/widgets/greetings_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //_buildSearchTextField(),
              const SizedBox(height: 36),
              const GreetingsWidget(),
              const SizedBox(height: 4),
              const HomeCarouselSlider(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

