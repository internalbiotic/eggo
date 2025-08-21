import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatefulWidget {
  final Map<String, dynamic> businessData;

  const ActionButtonsWidget({
    Key? key,
    required this.businessData,
  }) : super(key: key);

  @override
  State<ActionButtonsWidget> createState() => _ActionButtonsWidgetState();
}

class _ActionButtonsWidgetState extends State<ActionButtonsWidget> {
  bool _isFavorite = false;

  void _makeCall() async {
    final phoneNumber = widget.businessData['phone'] as String?;
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final uri = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        HapticFeedback.lightImpact();
      }
    }
  }

  void _openDirections() async {
    final latitude = widget.businessData['latitude'] as double?;
    final longitude = widget.businessData['longitude'] as double?;

    if (latitude != null && longitude != null) {
      final uri = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        HapticFeedback.lightImpact();
      }
    }
  }

  void _shareProfile() {
    HapticFeedback.lightImpact();
    // Share functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality would open here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: 'phone',
              label: 'Call',
              onPressed: _makeCall,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _ActionButton(
              icon: 'directions',
              label: 'Directions',
              onPressed: _openDirections,
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _ActionButton(
              icon: 'share',
              label: 'Share',
              onPressed: _shareProfile,
              color: AppTheme.lightTheme.colorScheme.tertiary,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _ActionButton(
              icon: _isFavorite ? 'favorite' : 'favorite_border',
              label: 'Favorite',
              onPressed: _toggleFavorite,
              color: _isFavorite
                  ? Colors.red
                  : AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: color,
              size: 6.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
