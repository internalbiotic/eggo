import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TermsPrivacyWidget extends StatelessWidget {
  const TermsPrivacyWidget({Key? key}) : super(key: key);

  void _showTermsOfService(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 1.h),
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terms of Service',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: AppTheme.lightTheme.colorScheme.outline),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      'Acceptance of Terms',
                      'By creating an account with EgGo, you agree to be bound by these Terms of Service and all applicable laws and regulations.',
                    ),
                    _buildSection(
                      'User Accounts',
                      'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
                    ),
                    _buildSection(
                      'Content and Reviews',
                      'Users may submit reviews and content. You retain ownership of your content but grant EgGo a license to use, display, and distribute it.',
                    ),
                    _buildSection(
                      'Prohibited Activities',
                      'Users may not engage in fraudulent activities, spam, harassment, or any illegal activities while using our platform.',
                    ),
                    _buildSection(
                      'Privacy and Data',
                      'Your privacy is important to us. Please review our Privacy Policy to understand how we collect and use your information.',
                    ),
                    _buildSection(
                      'Termination',
                      'We reserve the right to terminate accounts that violate these terms or engage in prohibited activities.',
                    ),
                    _buildSection(
                      'Contact Information',
                      'For questions about these terms, please contact us at legal@eggo.com or through our support channels.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 1.h),
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy Policy',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: AppTheme.lightTheme.colorScheme.outline),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      'Information We Collect',
                      'We collect information you provide directly, such as account details, reviews, and preferences. We also collect location data to provide personalized recommendations.',
                    ),
                    _buildSection(
                      'How We Use Your Information',
                      'Your information helps us provide personalized restaurant and tourism recommendations, improve our services, and communicate important updates.',
                    ),
                    _buildSection(
                      'Location Data',
                      'We use your location to show nearby restaurants and attractions. You can control location permissions in your device settings.',
                    ),
                    _buildSection(
                      'Data Sharing',
                      'We do not sell your personal information. We may share data with business partners to provide services and with authorities when required by law.',
                    ),
                    _buildSection(
                      'Data Security',
                      'We implement industry-standard security measures to protect your personal information from unauthorized access and misuse.',
                    ),
                    _buildSection(
                      'Your Rights',
                      'You have the right to access, update, or delete your personal information. Contact us to exercise these rights.',
                    ),
                    _buildSection(
                      'Contact Us',
                      'For privacy-related questions, contact us at privacy@eggo.com or through our app support channels.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 1.h),
          Text(
            content,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            height: 1.4,
          ),
          children: [
            const TextSpan(text: 'By creating an account, you agree to our '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => _showTermsOfService(context),
                child: Text(
                  'Terms of Service',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const TextSpan(text: ' and '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => _showPrivacyPolicy(context),
                child: Text(
                  'Privacy Policy',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
