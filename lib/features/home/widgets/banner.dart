import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telemedicine_platform_for_remote_areas/app/assets_path.dart';

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPath.bannerSvg,
      //width: 120,
    );
  }
}