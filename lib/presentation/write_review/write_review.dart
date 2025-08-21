import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/photo_upload_widget.dart';
import './widgets/review_guidelines_widget.dart';
import './widgets/review_text_input_widget.dart';
import './widgets/star_rating_widget.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview>
    with TickerProviderStateMixin {
  int _rating = 0;
  String _reviewText = '';
  List<XFile> _selectedImages = [];
  bool _isSubmitting = false;
  double _uploadProgress = 0.0;
  bool _hasUnsavedChanges = false;
  late AnimationController _submitAnimationController;
  late Animation<double> _submitAnimation;

  // Mock business data
  final Map<String, dynamic> _businessData = {
    "id": 1,
    "name": "Koshary Abou Tarek",
    "category": "Egyptian Restaurant",
    "image":
        "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "address": "16 Maarouf St, Bab Al Louq, Cairo",
    "rating": 4.5,
    "reviewCount": 1247,
  };

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _submitAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _submitAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  void _onRatingChanged(int rating) {
    setState(() {
      _rating = rating;
      _hasUnsavedChanges = true;
    });
    _saveDraft();
  }

  void _onTextChanged(String text) {
    setState(() {
      _reviewText = text;
      _hasUnsavedChanges = true;
    });
    _saveDraft();
  }

  void _onImagesChanged(List<XFile> images) {
    setState(() {
      _selectedImages = images;
      _hasUnsavedChanges = true;
    });
    _saveDraft();
  }

  void _saveDraft() {
    // Auto-save draft functionality
    final draftData = {
      'businessId': _businessData['id'],
      'rating': _rating,
      'text': _reviewText,
      'imageCount': _selectedImages.length,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // In a real app, this would save to local storage
    debugPrint('Draft saved: ${jsonEncode(draftData)}');
  }

  bool _canSubmitReview() {
    return _rating > 0 && _reviewText.trim().length >= 10 && !_isSubmitting;
  }

  Future<void> _submitReview() async {
    if (!_canSubmitReview()) return;

    _submitAnimationController.forward().then((_) {
      _submitAnimationController.reverse();
    });

    setState(() {
      _isSubmitting = true;
      _uploadProgress = 0.0;
    });

    try {
      // Simulate image upload progress
      for (int i = 0; i < _selectedImages.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _uploadProgress = (i + 1) / _selectedImages.length * 0.8;
        });
      }

      // Simulate review submission
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        _uploadProgress = 1.0;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      // Show success dialog
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _uploadProgress = 0.0;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.secondary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 12.w,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Review Submitted!',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Thank you for sharing your experience. Your review will be published after moderation.',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Done'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // In a real app, this would open share dialog
                    },
                    child: Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'error_outline',
              color: AppTheme.lightTheme.colorScheme.error,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            Text(
              'Submission Failed',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Unable to submit your review. Please check your connection and try again.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitReview();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Discard Review?',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'You have unsaved changes. Are you sure you want to discard your review?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Keep Writing'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
            ),
            child: Text(
              'Discard',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.onError),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.pop(context);
              }
            },
            icon: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
          title: Text(
            'Write Review',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Business info header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow
                        .withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageWidget(
                      imageUrl: _businessData['image'],
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _businessData['name'],
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          _businessData['category'],
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${_businessData['rating']} (${_businessData['reviewCount']} reviews)',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
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

            // Review form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Star rating
                    StarRatingWidget(
                      initialRating: _rating,
                      onRatingChanged: _onRatingChanged,
                    ),

                    SizedBox(height: 4.h),

                    // Text input
                    ReviewTextInputWidget(
                      text: _reviewText,
                      onTextChanged: _onTextChanged,
                      maxLength: 500,
                    ),

                    SizedBox(height: 4.h),

                    // Photo upload
                    PhotoUploadWidget(
                      selectedImages: _selectedImages,
                      onImagesChanged: _onImagesChanged,
                    ),

                    SizedBox(height: 4.h),

                    // Guidelines
                    const ReviewGuidelinesWidget(),

                    SizedBox(height: 6.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow
                    .withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isSubmitting) ...[
                  Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Uploading review...',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              '${(_uploadProgress * 100).toInt()}%',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        LinearProgressIndicator(
                          value: _uploadProgress,
                          backgroundColor: AppTheme
                              .lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                AnimatedBuilder(
                  animation: _submitAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _submitAnimation.value,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _canSubmitReview() ? _submitReview : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: _canSubmitReview()
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme.lightTheme.colorScheme.outline,
                          ),
                          child: _isSubmitting
                              ? SizedBox(
                                  height: 5.w,
                                  width: 5.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Post Review',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: _canSubmitReview()
                                        ? AppTheme
                                            .lightTheme.colorScheme.onPrimary
                                        : AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
