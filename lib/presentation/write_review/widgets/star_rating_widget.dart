import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StarRatingWidget extends StatefulWidget {
  final int initialRating;
  final Function(int) onRatingChanged;

  const StarRatingWidget({
    Key? key,
    this.initialRating = 0,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  State<StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _currentRating = 0;
  int _hoverRating = 0;

  final List<String> _ratingLabels = [
    '',
    'Poor',
    'Fair',
    'Good',
    'Very Good',
    'Excellent'
  ];

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _updateRating(int rating) {
    if (_currentRating != rating) {
      HapticFeedback.selectionClick();
      setState(() {
        _currentRating = rating;
      });
      widget.onRatingChanged(rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Rate your experience',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            final isSelected = starIndex <= _currentRating;
            final isHovered = starIndex <= _hoverRating;

            return GestureDetector(
              onTap: () => _updateRating(starIndex),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hoverRating = starIndex),
                onExit: (_) => setState(() => _hoverRating = 0),
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  child: CustomIconWidget(
                    iconName: isSelected || isHovered ? 'star' : 'star_border',
                    color: isSelected || isHovered
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline,
                    size: 8.w,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 1.h),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _currentRating > 0
              ? Text(
                  _ratingLabels[_currentRating],
                  key: ValueKey(_currentRating),
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
