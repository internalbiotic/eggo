import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  final String currentLanguage;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onDirections;

  const RestaurantCardWidget({
    Key? key,
    required this.restaurant,
    required this.currentLanguage,
    required this.onTap,
    required this.onFavorite,
    required this.onShare,
    required this.onDirections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = currentLanguage == 'ar'
        ? (restaurant['nameAr'] as String? ?? restaurant['name'] as String)
        : (restaurant['name'] as String);
    final double rating = (restaurant['rating'] as num).toDouble();
    final String priceRange = restaurant['priceRange'] as String;
    final String distance = restaurant['distance'] as String;
    final bool isFavorite = restaurant['isFavorite'] as bool? ?? false;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showQuickActions(context),
      child: Container(
        width: 70.w,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
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
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CustomImageWidget(
                    imageUrl: restaurant['image'] as String,
                    width: double.infinity,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface
                            .withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: isFavorite ? 'favorite' : 'favorite_border',
                        color: isFavorite
                            ? AppTheme.lightTheme.colorScheme.error
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2.w,
                  left: 2.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      distance,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.w),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return CustomIconWidget(
                            iconName:
                                index < rating.floor() ? 'star' : 'star_border',
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            size: 16,
                          );
                        }),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        rating.toStringAsFixed(1),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        priceRange,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.w),
                  Text(
                    restaurant['cuisine'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            _buildQuickActionTile(
              context,
              icon: 'favorite',
              title: currentLanguage == 'ar'
                  ? 'إضافة للمفضلة'
                  : 'Add to Favorites',
              onTap: () {
                Navigator.pop(context);
                onFavorite();
              },
            ),
            _buildQuickActionTile(
              context,
              icon: 'share',
              title: currentLanguage == 'ar' ? 'مشاركة' : 'Share',
              onTap: () {
                Navigator.pop(context);
                onShare();
              },
            ),
            _buildQuickActionTile(
              context,
              icon: 'directions',
              title: currentLanguage == 'ar'
                  ? 'الحصول على الاتجاهات'
                  : 'Get Directions',
              onTap: () {
                Navigator.pop(context);
                onDirections();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.colorScheme.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
