import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final String currentLanguage;
  final Function(int) onTap;

  const BottomNavigationWidget({
    Key? key,
    required this.currentIndex,
    required this.currentLanguage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navigationItems = [
      {
        'icon': 'explore',
        'labelEn': 'Discovery',
        'labelAr': 'استكشاف',
      },
      {
        'icon': 'search',
        'labelEn': 'Search',
        'labelAr': 'بحث',
      },
      {
        'icon': 'favorite',
        'labelEn': 'Favorites',
        'labelAr': 'المفضلة',
      },
      {
        'icon': 'person',
        'labelEn': 'Profile',
        'labelAr': 'الملف الشخصي',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.1),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 8.h,
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: navigationItems.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item = entry.value;
              final bool isSelected = currentIndex == index;
              final String label = currentLanguage == 'ar'
                  ? item['labelAr'] as String
                  : item['labelEn'] as String;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSelected ? 2.w : 1.5.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme
                                    .lightTheme.colorScheme.primaryContainer
                                    .withValues(alpha: 0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomIconWidget(
                            iconName: item['icon'] as String,
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                            size: isSelected ? 26 : 24,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTheme.lightTheme.textTheme.labelSmall!
                              .copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
