import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BusinessHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> businessData;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;

  const BusinessHeaderWidget({
    Key? key,
    required this.businessData,
    required this.onBackPressed,
    required this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 35.h,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      leading: Container(
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          onPressed: onBackPressed,
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Colors.white,
            size: 6.w,
          ),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: onSharePressed,
            icon: CustomIconWidget(
              iconName: 'share',
              color: Colors.white,
              size: 6.w,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomImageWidget(
              imageUrl: businessData['headerImage'] as String? ?? '',
              width: double.infinity,
              height: 35.h,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 2.h,
              left: 4.w,
              right: 4.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          businessData['name'] as String? ?? 'Business Name',
                          style: AppTheme.lightTheme.textTheme.headlineMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      businessData['isVerified'] == true
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'verified',
                                    color: Colors.white,
                                    size: 4.w,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'Verified',
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          businessData['category'] as String? ?? 'Category',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: Colors.amber,
                            size: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${businessData['rating'] ?? 0.0}',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '(${businessData['reviewCount'] ?? 0} reviews)',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Text(
                        businessData['priceRange'] as String? ?? '\$\$',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${businessData['distance'] ?? 0.0} km away',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
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
