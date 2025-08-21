import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReviewsSectionWidget extends StatelessWidget {
  final Map<String, dynamic> businessData;
  final VoidCallback onWriteReview;

  const ReviewsSectionWidget({
    Key? key,
    required this.businessData,
    required this.onWriteReview,
  }) : super(key: key);

  void _openFullScreenGallery(
      BuildContext context, List<String> photos, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenPhotoGallery(
          photos: photos,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviews = businessData['reviews'] as List<dynamic>? ?? [];
    final rating = businessData['rating'] as double? ?? 0.0;
    final reviewCount = businessData['reviewCount'] as int? ?? 0;

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'star',
                    color: Colors.amber,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Reviews',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onWriteReview,
                child: Text(
                  'Write Review',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Rating summary
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTheme.lightTheme.textTheme.headlineMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Row(
                          children: List.generate(5, (index) {
                            return CustomIconWidget(
                              iconName: index < rating.floor()
                                  ? 'star'
                                  : 'star_border',
                              color: Colors.amber,
                              size: 5.w,
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '$reviewCount reviews',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          // Reviews list
          if (reviews.isNotEmpty) ...[
            ...reviews.take(3).map((review) => _ReviewCard(
                  review: review as Map<String, dynamic>,
                  onPhotoTap: (photos, index) =>
                      _openFullScreenGallery(context, photos, index),
                )),
            if (reviews.length > 3) ...[
              SizedBox(height: 2.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to all reviews screen
                  },
                  child: Text(
                    'View all ${reviews.length} reviews',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ] else ...[
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  CustomIconWidget(
                    iconName: 'rate_review',
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.4),
                    size: 12.w,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'No reviews yet',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Be the first to share your experience!',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface
                          .withValues(alpha: 0.5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final Function(List<String>, int) onPhotoTap;

  const _ReviewCard({
    Key? key,
    required this.review,
    required this.onPhotoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photos = (review['photos'] as List<dynamic>?)?.cast<String>() ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                child: review['userAvatar'] != null
                    ? ClipOval(
                        child: CustomImageWidget(
                          imageUrl: review['userAvatar'] as String,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        (review['userName'] as String? ?? 'U')[0].toUpperCase(),
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'] as String? ?? 'Anonymous',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            final rating = review['rating'] as int? ?? 0;
                            return CustomIconWidget(
                              iconName: index < rating ? 'star' : 'star_border',
                              color: Colors.amber,
                              size: 4.w,
                            );
                          }),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          review['date'] as String? ?? '',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            review['comment'] as String? ?? '',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          if (photos.isNotEmpty) ...[
            SizedBox(height: 2.h),
            SizedBox(
              height: 15.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onPhotoTap(photos, index),
                    child: Container(
                      width: 20.w,
                      margin: EdgeInsets.only(right: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageWidget(
                          imageUrl: photos[index],
                          width: 20.w,
                          height: 15.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FullScreenPhotoGallery extends StatefulWidget {
  final List<String> photos;
  final int initialIndex;

  const _FullScreenPhotoGallery({
    Key? key,
    required this.photos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<_FullScreenPhotoGallery> createState() =>
      _FullScreenPhotoGalleryState();
}

class _FullScreenPhotoGalleryState extends State<_FullScreenPhotoGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'close',
            color: Colors.white,
            size: 6.w,
          ),
        ),
        title: Text(
          '${_currentIndex + 1} of ${widget.photos.length}',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.photos.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Center(
              child: CustomImageWidget(
                imageUrl: widget.photos[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
