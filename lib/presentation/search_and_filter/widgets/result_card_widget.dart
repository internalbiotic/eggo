import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ResultCardWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const ResultCardWidget({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: CustomImageWidget(
            imageUrl: item['image'] ?? '',
            width: double.infinity,
            height: 25.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 2.h,
          right: 4.w,
          child: GestureDetector(
            onTap: onFavorite,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface
                    .withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: (item['isFavorite'] as bool? ?? false)
                    ? 'favorite'
                    : 'favorite_border',
                color: (item['isFavorite'] as bool? ?? false)
                    ? AppTheme.lightTheme.colorScheme.error
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 5.w,
              ),
            ),
          ),
        ),
        if (item['type'] == 'restaurant')
          Positioned(
            top: 2.h,
            left: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Restaurant',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        else
          Positioned(
            top: 2.h,
            left: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Tourism',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item['name'] ?? '',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 2.w),
              _buildRatingWidget(),
            ],
          ),
          SizedBox(height: 1.h),
          if (item['cuisine'] != null)
            Text(
              item['cuisine'] ?? '',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          SizedBox(height: 1.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                '${item['distance']}km away',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (item['priceRange'] != null)
                Text(
                  item['priceRange'] ?? '',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              _buildStatusChip(),
              const Spacer(),
              _buildQuickActions(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconWidget(
          iconName: 'star',
          color: Colors.amber,
          size: 4.w,
        ),
        SizedBox(width: 1.w),
        Text(
          '${item['rating'] ?? 0.0}',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip() {
    final bool isOpen = item['isOpen'] as bool? ?? false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: isOpen
            ? AppTheme.lightTheme.colorScheme.tertiaryContainer
                .withValues(alpha: 0.2)
            : AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: isOpen
              ? AppTheme.lightTheme.colorScheme.tertiaryContainer
              : AppTheme.lightTheme.colorScheme.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Handle call action
          },
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'phone',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 4.w,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        GestureDetector(
          onTap: () {
            // Handle directions action
          },
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.secondary
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'directions',
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 4.w,
            ),
          ),
        ),
      ],
    );
  }
}
