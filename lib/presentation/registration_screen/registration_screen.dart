import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/registration_form_widget.dart';
import './widgets/social_registration_widget.dart';
import './widgets/terms_privacy_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _welcomeAnimationController;
  late Animation<double> _welcomeAnimation;

  // Mock user data for demonstration
  final List<Map<String, dynamic>> _existingUsers = [
    {
      "email": "ahmed.hassan@gmail.com",
      "phone": "1234567890",
      "fullName": "Ahmed Hassan",
      "language": "Arabic"
    },
    {
      "email": "sarah.mohamed@yahoo.com",
      "phone": "0987654321",
      "fullName": "Sarah Mohamed",
      "language": "English"
    }
  ];

  @override
  void initState() {
    super.initState();
    _welcomeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _welcomeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _welcomeAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _welcomeAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration(
    String email,
    String phone,
    String password,
    String fullName,
    String language,
  ) async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user already exists
      final existingUser = _existingUsers.any((user) =>
          (user["email"] as String).toLowerCase() == email.toLowerCase() ||
          (user["phone"] as String) == phone);

      if (existingUser) {
        _showErrorMessage('An account with this email or phone already exists');
        return;
      }

      // Simulate successful registration
      _showWelcomeAnimation();

      // Navigate to discovery dashboard after animation
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/discovery-dashboard');
        }
      });
    } catch (e) {
      _showErrorMessage('Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignUp() async {
    setState(() => _isLoading = true);

    try {
      // Simulate Google sign up process
      await Future.delayed(const Duration(seconds: 1));

      _showWelcomeAnimation();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/discovery-dashboard');
        }
      });
    } catch (e) {
      _showErrorMessage('Google sign up failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleFacebookSignUp() async {
    setState(() => _isLoading = true);

    try {
      // Simulate Facebook sign up process
      await Future.delayed(const Duration(seconds: 1));

      _showWelcomeAnimation();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/discovery-dashboard');
        }
      });
    } catch (e) {
      _showErrorMessage('Facebook sign up failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showWelcomeAnimation() {
    _welcomeAnimationController.forward();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AnimatedBuilder(
        animation: _welcomeAnimation,
        builder: (context, child) => Transform.scale(
          scale: _welcomeAnimation.value,
          child: AlertDialog(
            backgroundColor: AppTheme.lightTheme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'check_circle',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 12.w,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Welcome to EgGo!',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Your account has been created successfully',
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),

                  // EgGo Logo
                  Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.lightTheme.colorScheme.primary,
                          AppTheme.lightTheme.colorScheme.primaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'EgGo',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 6.w,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Welcome Text
                  Text(
                    'Create Your Account',
                    style:
                        AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Join EgGo to discover the best restaurants and attractions in Egypt',
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Registration Form
                  RegistrationFormWidget(
                    onRegister: _handleRegistration,
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: 3.h),

                  // Social Registration
                  SocialRegistrationWidget(
                    onGoogleSignUp: _handleGoogleSignUp,
                    onFacebookSignUp: _handleFacebookSignUp,
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: 4.h),

                  // Terms and Privacy
                  const TermsPrivacyWidget(),

                  SizedBox(height: 3.h),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: _isLoading
                            ? null
                            : () {
                                Navigator.pushReplacementNamed(
                                    context, '/login-screen');
                              },
                        child: Text(
                          'Login',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
