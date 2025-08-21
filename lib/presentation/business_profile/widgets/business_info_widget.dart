import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class BusinessInfoWidget extends StatelessWidget {
  final Map<String, dynamic> businessData;

  const BusinessInfoWidget({
    Key? key,
    required this.businessData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            businessData['description'] as String? ??
                'No description available.',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 3.h),
          if (businessData['menuItems'] != null) ...[
            Text(
              'Menu Highlights',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.5.h),
            ...(businessData['menuItems'] as List).map((item) => _MenuItemTile(
                  name: item['name'] as String,
                  description: item['description'] as String,
                  price: item['price'] as String,
                )),
          ],
          if (businessData['amenities'] != null) ...[
            SizedBox(height: 3.h),
            Text(
              'Amenities',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.5.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: (businessData['amenities'] as List)
                  .map((amenity) => _AmenityChip(amenity: amenity as String))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final String name;
  final String description;
  final String price;

  const _MenuItemTile({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            price,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final String amenity;

  const _AmenityChip({
    Key? key,
    required this.amenity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        amenity,
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: AppTheme.lightTheme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
