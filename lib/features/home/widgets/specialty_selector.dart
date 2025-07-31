import 'package:flutter/material.dart';
import 'package:telemedicine_platform_for_remote_areas/app/app_colors.dart';


class SpecialtySelector extends StatelessWidget {
  final List<String> specialties;
  final String selectedSpecialty;
  final Function(String) onSpecialtySelected;

  const SpecialtySelector({
    super.key,
    required this.specialties,
    required this.selectedSpecialty,
    required this.onSpecialtySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final isSelected = specialty == selectedSpecialty;

          return Container(
            margin: EdgeInsets.only(right: index == specialties.length - 1 ? 0 : 12),
            child: GestureDetector(
              onTap: () => onSpecialtySelected(specialty),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.themeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? AppColors.themeColor : AppColors.textSecondary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getSpecialtyIcon(specialty),
                      size: 18,
                      color: isSelected ? Colors.white : AppColors.themeColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      specialty,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getSpecialtyIcon(String specialty) {
    switch (specialty.toLowerCase()) {
      case 'cardiologist':
        return Icons.favorite;
      case 'dentist':
        return Icons.sentiment_satisfied;
      case 'pathologist':
        return Icons.biotech;
      case 'gynecologist':
        return Icons.pregnant_woman;
      case 'orthopedic':
        return Icons.accessibility;
      default:
        return Icons.medical_services;
    }
  }
}