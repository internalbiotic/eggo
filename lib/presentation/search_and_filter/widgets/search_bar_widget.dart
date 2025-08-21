import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onVoiceSearch;
  final List<String> suggestions;
  final Function(String) onSuggestionTap;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onVoiceSearch,
    required this.suggestions,
    required this.onSuggestionTap,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: widget.searchController,
            onChanged: (value) {
              widget.onSearchChanged(value);
              setState(() {
                _showSuggestions = value.isNotEmpty;
              });
            },
            onTap: () {
              setState(() {
                _showSuggestions = widget.searchController.text.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search restaurants & attractions...',
              hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        widget.searchController.clear();
                        widget.onSearchChanged('');
                        setState(() {
                          _showSuggestions = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: CustomIconWidget(
                          iconName: 'clear',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 4.w,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: widget.onVoiceSearch,
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'mic',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 5.w,
                      ),
                    ),
                  ),
                ],
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),
        ),
        if (_showSuggestions && widget.suggestions.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  widget.suggestions.length > 5 ? 5 : widget.suggestions.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppTheme.lightTheme.dividerColor,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  leading: CustomIconWidget(
                    iconName: 'history',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  title: Text(
                    widget.suggestions[index],
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  onTap: () {
                    widget.onSuggestionTap(widget.suggestions[index]);
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
