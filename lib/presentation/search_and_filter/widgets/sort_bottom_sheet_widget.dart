import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SortBottomSheetWidget extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SortBottomSheetWidget({
    Key? key,
    required this.currentSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      {
        'key': 'relevance',
        'title': 'Relevance',
        'subtitle': 'Best match for your search'
      },
      {
        'key': 'distance',
        'title': 'Distance',
        'subtitle': 'Closest to your location'
      },
      {'key': 'rating', 'title': 'Rating', 'subtitle': 'Highest rated first'},
      {
        'key': 'price_low',
        'title': 'Price: Low to High',
        'subtitle': 'Most affordable first'
      },
      {
        'key': 'price_high',
        'title': 'Price: High to Low',
        'subtitle': 'Most expensive first'
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Sort by',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ...sortOptions.map((option) {
            final isSelected = currentSort == option['key'];
            return GestureDetector(
              onTap: () {
                onSortChanged(option['key'] as String);
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option['title'] as String,
                            style: AppTheme.lightTheme.textTheme.bodyLarge
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            option['subtitle'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 6.w,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
