import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WeeklyPicksCardWidget extends StatelessWidget {
  final Map<String, dynamic> pick;
  final String currentLanguage;
  final VoidCallback onTap;

  const WeeklyPicksCardWidget({
    Key? key,
    required this.pick,
    required this.currentLanguage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = currentLanguage == 'ar'
        ? (pick['nameAr'] as String? ?? pick['name'] as String)
        : (pick['name'] as String);
    final String description = currentLanguage == 'ar'
        ? (pick['descriptionAr'] as String? ?? pick['description'] as String)
        : (pick['description'] as String);
    final double rating = (pick['rating'] as num).toDouble();
    final String badge = pick['badge'] as String;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.15),
              offset: const Offset(0, 6),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CustomImageWidget(
                    imageUrl: pick['image'] as String,
                    width: double.infinity,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 3.w,
                  left: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.lightTheme.colorScheme.primary,
                          AppTheme.lightTheme.colorScheme.primaryContainer,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.lightTheme.shadowColor
                              .withValues(alpha: 0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          badge,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3.w,
                  right: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          rating.toStringAsFixed(1),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.w),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 1.w),
                        decoration: BoxDecoration(
                          color: AppTheme
                              .lightTheme.colorScheme.secondaryContainer
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pick['type'] as String,
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomIconWidget(
                        iconName: 'arrow_forward',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
