import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReviewTextInputWidget extends StatefulWidget {
  final String text;
  final Function(String) onTextChanged;
  final int maxLength;

  const ReviewTextInputWidget({
    Key? key,
    required this.text,
    required this.onTextChanged,
    this.maxLength = 500,
  }) : super(key: key);

  @override
  State<ReviewTextInputWidget> createState() => _ReviewTextInputWidgetState();
}

class _ReviewTextInputWidgetState extends State<ReviewTextInputWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isArabic = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _focusNode = FocusNode();
    _detectLanguage(widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _detectLanguage(String text) {
    if (text.isEmpty) return;

    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    final hasArabic = arabicRegex.hasMatch(text);

    if (hasArabic != _isArabic) {
      setState(() {
        _isArabic = hasArabic;
      });
    }
  }

  void _onTextChanged(String value) {
    _detectLanguage(value);
    widget.onTextChanged(value);
  }

  Color _getCounterColor() {
    final remaining = widget.maxLength - _controller.text.length;
    if (remaining < 50) {
      return AppTheme.lightTheme.colorScheme.error;
    } else if (remaining < 100) {
      return AppTheme.lightTheme.colorScheme.tertiary;
    }
    return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Share your experience',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Tell others about your visit, food quality, service, and atmosphere',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.outline,
              width: _focusNode.hasFocus ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: 6,
            maxLength: widget.maxLength,
            textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: _isArabic
                  ? AppTheme.lightTheme.colorScheme.secondary
                  : AppTheme.lightTheme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: _isArabic
                  ? 'شارك تجربتك مع الآخرين...'
                  : 'Share your experience with others...',
              hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.6),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(4.w),
              counterText: '',
            ),
            onChanged: _onTextChanged,
            onTap: () {
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum 10 characters',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: _controller.text.length >= 10
                    ? AppTheme.lightTheme.colorScheme.secondary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: _getCounterColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (_isArabic) ...[
          SizedBox(height: 1.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'language',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Arabic text detected',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
