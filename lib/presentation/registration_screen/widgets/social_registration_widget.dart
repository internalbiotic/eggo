import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialRegistrationWidget extends StatelessWidget {
  final VoidCallback onGoogleSignUp;
  final VoidCallback onFacebookSignUp;
  final bool isLoading;

  const SocialRegistrationWidget({
    Key? key,
    required this.onGoogleSignUp,
    required this.onFacebookSignUp,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with text
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppTheme.lightTheme.colorScheme.outline,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or sign up with',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppTheme.lightTheme.colorScheme.outline,
                thickness: 1,
              ),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Social Login Buttons
        Row(
          children: [
            // Google Sign Up
            Expanded(
              child: OutlinedButton(
                onPressed: isLoading ? null : onGoogleSignUp,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 1.8.h),
                  side: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageWidget(
                      imageUrl:
                          'https://developers.google.com/identity/images/g-logo.png',
                      width: 5.w,
                      height: 5.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Google',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 4.w),

            // Facebook Sign Up
            Expanded(
              child: OutlinedButton(
                onPressed: isLoading ? null : onFacebookSignUp,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 1.8.h),
                  side: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5.w,
                      height: 5.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1877F2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'f',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Facebook',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
