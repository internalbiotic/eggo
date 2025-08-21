import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CuisineFilterWidget extends StatefulWidget {
  final String currentLanguage;
  final Function(String)? onCuisineSelected;

  const CuisineFilterWidget({
    Key? key,
    required this.currentLanguage,
    this.onCuisineSelected,
  }) : super(key: key);

  @override
  State<CuisineFilterWidget> createState() => _CuisineFilterWidgetState();
}

class _CuisineFilterWidgetState extends State<CuisineFilterWidget>
    with SingleTickerProviderStateMixin {
  String _selectedCuisine = '';
  bool _showInternationalSubs = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> _cuisineTypes = [
    {'en': 'Egyptian Cuisine', 'ar': 'المطبخ المصري'},
    {'en': 'Mediterranean', 'ar': 'متوسطي'},
    {'en': 'Asian', 'ar': 'آسيوي'},
    {'en': 'International', 'ar': 'عالمي'},
  ];

  final List<Map<String, String>> _internationalSubs = [
    {'en': 'Fried Chicken', 'ar': 'دجاج مقلي'},
    {'en': 'Pizza', 'ar': 'بيتزا'},
    {'en': 'Pasta', 'ar': 'مكرونة'},
    {'en': 'Burgers', 'ar': 'برجر'},
    {'en': 'Sushi', 'ar': 'سوشي'},
    {'en': 'Seafood', 'ar': 'مأكولات بحرية'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.onSurface.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              widget.currentLanguage == 'ar' ? 'نوع المطبخ' : 'Cuisine Filter',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 1.5.h),
          SizedBox(
            height: 6.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: _cuisineTypes.length,
              itemBuilder: (context, index) {
                final cuisine = _cuisineTypes[index];
                final isSelected = _selectedCuisine == cuisine['en'];
                final displayName =
                    cuisine[widget.currentLanguage] ?? cuisine['en']!;

                return Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: GestureDetector(
                    onTap: () => _onCuisineSelected(cuisine['en']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.surface,
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withAlpha(77),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppTheme.lightTheme.colorScheme.primary
                                      .withAlpha(77),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          displayName,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.onPrimary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showInternationalSubs) ...[
            SizedBox(height: 2.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      widget.currentLanguage == 'ar'
                          ? 'الخيارات العالمية'
                          : 'International Options',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 5.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemCount: _internationalSubs.length,
                      itemBuilder: (context, index) {
                        final subOption = _internationalSubs[index];
                        final displayName = subOption[widget.currentLanguage] ??
                            subOption['en']!;

                        return Padding(
                          padding: EdgeInsets.only(right: 2.5.w),
                          child: GestureDetector(
                            onTap: () => _onSubOptionSelected(subOption['en']!),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.8.h),
                              decoration: BoxDecoration(
                                color: AppTheme
                                    .lightTheme.colorScheme.primaryContainer
                                    .withAlpha(77),
                                border: Border.all(
                                  color: AppTheme.lightTheme.colorScheme.primary
                                      .withAlpha(128),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  displayName,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _onCuisineSelected(String cuisine) {
    HapticFeedback.selectionClick();

    setState(() {
      if (_selectedCuisine == cuisine) {
        _selectedCuisine = '';
        _showInternationalSubs = false;
        _animationController.reverse();
      } else {
        _selectedCuisine = cuisine;
        if (cuisine == 'International') {
          _showInternationalSubs = true;
          _animationController.forward();
        } else {
          _showInternationalSubs = false;
          _animationController.reverse();
        }
      }
    });

    // Notify parent widget about the selection
    widget.onCuisineSelected?.call(cuisine);
  }

  void _onSubOptionSelected(String subOption) {
    HapticFeedback.lightImpact();

    // Notify parent widget about the sub-option selection
    widget.onCuisineSelected?.call('International: $subOption');

    // Show a brief feedback to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.currentLanguage == 'ar'
              ? 'تم اختيار $subOption'
              : 'Selected $subOption',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }
}
