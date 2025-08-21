import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipsWidget extends StatelessWidget {
  final Map<String, dynamic> activeFilters;
  final Function(String) onRemoveFilter;
  final VoidCallback onClearAll;

  const FilterChipsWidget({
    Key? key,
    required this.activeFilters,
    required this.onRemoveFilter,
    required this.onClearAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 6.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: activeFilters.length,
              separatorBuilder: (context, index) => SizedBox(width: 2.w),
              itemBuilder: (context, index) {
                final entry = activeFilters.entries.elementAt(index);
                return _buildFilterChip(entry.key, entry.value);
              },
            ),
          ),
          if (activeFilters.length > 1) ...[
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: onClearAll,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.error
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.error,
                    width: 1,
                  ),
                ),
                child: Text(
                  'Clear All',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, dynamic value) {
    String displayText = _getDisplayText(key, value);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            displayText,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 1.w),
          GestureDetector(
            onTap: () => onRemoveFilter(key),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 3.w,
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayText(String key, dynamic value) {
    switch (key) {
      case 'category':
        return value.toString();
      case 'cuisine':
        return value.toString();
      case 'priceRange':
        return 'EGP ${value['min']}-${value['max']}';
      case 'rating':
        return '${value}+ stars';
      case 'distance':
        return '${value}km';
      case 'openNow':
        return 'Open Now';
      case 'features':
        return (value as List).join(', ');
      default:
        return value.toString();
    }
  }
}
