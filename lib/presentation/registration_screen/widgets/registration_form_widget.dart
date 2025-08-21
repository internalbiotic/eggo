import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RegistrationFormWidget extends StatefulWidget {
  final Function(String email, String phone, String password, String fullName,
      String language) onRegister;
  final bool isLoading;

  const RegistrationFormWidget({
    Key? key,
    required this.onRegister,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  bool _isPasswordVisible = false;
  String _selectedLanguage = 'English';
  String _passwordStrength = '';
  Color _strengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = '';
        _strengthColor = Colors.grey;
      });
      return;
    }

    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    setState(() {
      switch (score) {
        case 0:
        case 1:
          _passwordStrength = 'Weak';
          _strengthColor = AppTheme.lightTheme.colorScheme.error;
          break;
        case 2:
        case 3:
          _passwordStrength = 'Medium';
          _strengthColor = AppTheme.lightTheme.colorScheme.tertiary;
          break;
        case 4:
        case 5:
          _passwordStrength = 'Strong';
          _strengthColor = AppTheme.lightTheme.colorScheme.tertiaryContainer;
          break;
      }
    });
  }

  bool _isFormValid() {
    return _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _formKey.currentState?.validate() == true;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Please enter your full name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name Field
          TextFormField(
            controller: _fullNameController,
            validator: _validateFullName,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'person',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) => setState(() {}),
          ),
          SizedBox(height: 2.h),

          // Email Field
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'email',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) => setState(() {}),
          ),
          SizedBox(height: 2.h),

          // Phone Number Field
          TextFormField(
            controller: _phoneController,
            validator: _validatePhone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '+20',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'phone',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                  ],
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) => setState(() {}),
          ),
          SizedBox(height: 2.h),

          // Password Field
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Create a password',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'lock',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                icon: CustomIconWidget(
                  iconName:
                      _isPasswordVisible ? 'visibility' : 'visibility_off',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
            ),
            textInputAction: TextInputAction.done,
            onChanged: (value) => setState(() {}),
          ),

          // Password Strength Indicator
          _passwordController.text.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 1.h, left: 4.w),
                  child: Row(
                    children: [
                      Text(
                        'Password strength: ',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                      Text(
                        _passwordStrength,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: _strengthColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),

          SizedBox(height: 3.h),

          // Language Preference
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preferred Language',
                  style: AppTheme.lightTheme.textTheme.labelMedium,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedLanguage = 'English'),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                            color: _selectedLanguage == 'English'
                                ? AppTheme.lightTheme.colorScheme.primary
                                    .withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: _selectedLanguage == 'English'
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme.lightTheme.colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🇺🇸', style: TextStyle(fontSize: 4.w)),
                              SizedBox(width: 2.w),
                              Text(
                                'English',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: _selectedLanguage == 'English'
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                  fontWeight: _selectedLanguage == 'English'
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedLanguage = 'Arabic'),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                            color: _selectedLanguage == 'Arabic'
                                ? AppTheme.lightTheme.colorScheme.primary
                                    .withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: _selectedLanguage == 'Arabic'
                                  ? AppTheme.lightTheme.colorScheme.primary
                                  : AppTheme.lightTheme.colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🇪🇬', style: TextStyle(fontSize: 4.w)),
                              SizedBox(width: 2.w),
                              Text(
                                'العربية',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: _selectedLanguage == 'Arabic'
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                  fontWeight: _selectedLanguage == 'Arabic'
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: _isFormValid() && !widget.isLoading
                  ? () => widget.onRegister(
                        _emailController.text,
                        _phoneController.text,
                        _passwordController.text,
                        _fullNameController.text,
                        _selectedLanguage,
                      )
                  : null,
              child: widget.isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.lightTheme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      'Create Account',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
