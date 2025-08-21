import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/language_toggle.dart';
import './widgets/login_form.dart';
import './widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  String _currentLanguage = 'en';
  String? _emailError;
  String? _passwordError;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@eggo.com': 'admin123',
    'user@eggo.com': 'user123',
    'tourist@eggo.com': 'tourist123',
    '01234567890': 'mobile123',
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    setState(() {
      _currentLanguage = _currentLanguage == 'en' ? 'ar' : 'en';
    });
  }

  void _clearErrors() {
    if (_emailError != null || _passwordError != null) {
      setState(() {
        _emailError = null;
        _passwordError = null;
      });
    }
  }

  String _getLocalizedText(String englishText, String arabicText) {
    return _currentLanguage == 'en' ? englishText : arabicText;
  }

  Future<void> _handleLogin() async {
    _clearErrors();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validation
    if (email.isEmpty) {
      setState(() {
        _emailError = _getLocalizedText(
            'Email or phone is required', 'البريد الإلكتروني أو الهاتف مطلوب');
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError =
            _getLocalizedText('Password is required', 'كلمة المرور مطلوبة');
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _passwordError = _getLocalizedText(
            'Password must be at least 6 characters',
            'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/discovery-dashboard');
      }
    } else {
      // Invalid credentials
      HapticFeedback.heavyImpact();

      setState(() {
        _emailError = _getLocalizedText(
            'Invalid email or phone', 'البريد الإلكتروني أو الهاتف غير صحيح');
        _passwordError =
            _getLocalizedText('Invalid password', 'كلمة المرور غير صحيحة');
        _isLoading = false;
      });
    }
  }

  void _handleForgotPassword() {
    // Navigate to password recovery (placeholder)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _getLocalizedText('Password recovery feature coming soon',
              'ميزة استرداد كلمة المرور قريباً'),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _getLocalizedText('$provider login coming soon',
              'تسجيل الدخول عبر $provider قريباً'),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/registration-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),

                // Language toggle in top-right
                Align(
                  alignment: Alignment.centerRight,
                  child: LanguageToggle(
                    currentLanguage: _currentLanguage,
                    onToggle: _toggleLanguage,
                  ),
                ),

                SizedBox(height: 4.h),

                // EgGo Logo
                Container(
                  width: 30.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
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
                      style: AppTheme.lightTheme.textTheme.headlineMedium
                          ?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                // Welcome text
                Text(
                  _getLocalizedText('Welcome Back!', 'أهلاً بعودتك!'),
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 1.h),

                Text(
                  _getLocalizedText(
                      'Sign in to discover Egypt\'s best restaurants and attractions',
                      'سجل دخولك لاكتشاف أفضل المطاعم والمعالم في مصر'),
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 4.h),

                // Login Form
                LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isLoading: _isLoading,
                  onLogin: _handleLogin,
                  onForgotPassword: _handleForgotPassword,
                  emailError: _emailError,
                  passwordError: _passwordError,
                ),

                SizedBox(height: 4.h),

                // Social Login Buttons
                SocialLoginButtons(
                  onGoogleLogin: () => _handleSocialLogin('Google'),
                  onAppleLogin: () => _handleSocialLogin('Apple'),
                  onFacebookLogin: () => _handleSocialLogin('Facebook'),
                ),

                SizedBox(height: 4.h),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getLocalizedText('New user? ', 'مستخدم جديد؟ '),
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToSignUp,
                      child: Text(
                        _getLocalizedText('Sign Up', 'إنشاء حساب'),
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
