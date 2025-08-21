import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final String? emailError;
  final String? passwordError;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
    this.emailError,
    this.passwordError,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordVisible = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(_validateForm);
    widget.passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_validateForm);
    widget.passwordController.removeListener(_validateForm);
    super.dispose();
  }

  void _validateForm() {
    final isEmailValid = widget.emailController.text.isNotEmpty &&
        (widget.emailController.text.contains('@') ||
            RegExp(r'^[0-9]+$').hasMatch(widget.emailController.text));
    final isPasswordValid = widget.passwordController.text.length >= 6;

    setState(() {
      _isFormValid = isEmailValid && isPasswordValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email/Phone input field
        _buildInputField(
          controller: widget.emailController,
          hintText: 'Email or Phone',
          iconName: 'alternate_email',
          keyboardType: TextInputType.emailAddress,
          errorText: widget.emailError,
        ),
        SizedBox(height: 2.h),

        // Password input field
        _buildInputField(
          controller: widget.passwordController,
          hintText: 'Password',
          iconName: 'lock_outline',
          isPassword: true,
          errorText: widget.passwordError,
        ),
        SizedBox(height: 1.h),

        // Forgot password link
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onForgotPassword,
            child: Text(
              'Forgot Password?',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),

        // Login button
        SizedBox(
          width: double.infinity,
          height: 6.h,
          child: ElevatedButton(
            onPressed:
                _isFormValid && !widget.isLoading ? widget.onLogin : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFormValid
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.outline,
              foregroundColor: _isFormValid
                  ? AppTheme.lightTheme.colorScheme.onPrimary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              elevation: _isFormValid ? 2 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: widget.isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(
                    'Login',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String iconName,
    TextInputType? keyboardType,
    bool isPassword = false,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: errorText != null
                  ? AppTheme.lightTheme.colorScheme.error
                  : AppTheme.lightTheme.colorScheme.outline,
              width: 1,
            ),
            color: AppTheme.lightTheme.colorScheme.surface,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword && !_isPasswordVisible,
            style: AppTheme.lightTheme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: iconName,
                  size: 20,
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: _isPasswordVisible
                              ? 'visibility_off'
                              : 'visibility',
                          size: 20,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 0.5.h),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Text(
              errorText,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.error,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
