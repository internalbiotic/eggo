import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterModalWidget({
    Key? key,
    required this.currentFilters,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late Map<String, dynamic> _tempFilters;
  double _minPrice = 0;
  double _maxPrice = 1000;
  double _minRating = 0;
  double _maxDistance = 50;

  @override
  void initState() {
    super.initState();
    _tempFilters = Map.from(widget.currentFilters);

    if (_tempFilters['priceRange'] != null) {
      _minPrice = (_tempFilters['priceRange']['min'] ?? 0).toDouble();
      _maxPrice = (_tempFilters['priceRange']['max'] ?? 1000).toDouble();
    }

    if (_tempFilters['rating'] != null) {
      _minRating = (_tempFilters['rating'] ?? 0).toDouble();
    }

    if (_tempFilters['distance'] != null) {
      _maxDistance = (_tempFilters['distance'] ?? 50).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection(),
                  SizedBox(height: 3.h),
                  _buildCuisineSection(),
                  SizedBox(height: 3.h),
                  _buildPriceRangeSection(),
                  SizedBox(height: 3.h),
                  _buildRatingSection(),
                  SizedBox(height: 3.h),
                  _buildDistanceSection(),
                  SizedBox(height: 3.h),
                  _buildFeaturesSection(),
                  SizedBox(height: 3.h),
                  _buildOpenNowSection(),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'Filters',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _clearAllFilters,
            child: Text(
              'Clear All',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: ['All', 'Restaurants', 'Tourism'].map((category) {
            final isSelected = _tempFilters['category'] == category ||
                (_tempFilters['category'] == null && category == 'All');
            return GestureDetector(
              onTap: () {
                setState(() {
                  _tempFilters['category'] =
                      category == 'All' ? null : category;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                  ),
                ),
                child: Text(
                  category,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCuisineSection() {
    final cuisines = [
      'Egyptian',
      'Mediterranean',
      'Italian',
      'Asian',
      'Fast Food',
      'Seafood'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuisine Type',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: cuisines.map((cuisine) {
            final isSelected = _tempFilters['cuisine'] == cuisine;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _tempFilters['cuisine'] = isSelected ? null : cuisine;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                  ),
                ),
                child: Text(
                  cuisine,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range (EGP)',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        RangeSlider(
          values: RangeValues(_minPrice, _maxPrice),
          min: 0,
          max: 1000,
          divisions: 20,
          labels: RangeLabels(
            'EGP ${_minPrice.round()}',
            'EGP ${_maxPrice.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
              _tempFilters['priceRange'] = {
                'min': _minPrice.round(),
                'max': _maxPrice.round(),
              };
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EGP ${_minPrice.round()}',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            Text(
              'EGP ${_maxPrice.round()}',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Slider(
          value: _minRating,
          min: 0,
          max: 5,
          divisions: 10,
          label: '${_minRating.toStringAsFixed(1)} stars',
          onChanged: (double value) {
            setState(() {
              _minRating = value;
              _tempFilters['rating'] = _minRating;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0 stars',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            Text(
              '5 stars',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Distance (km)',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Slider(
          value: _maxDistance,
          min: 1,
          max: 50,
          divisions: 49,
          label: '${_maxDistance.round()} km',
          onChanged: (double value) {
            setState(() {
              _maxDistance = value;
              _tempFilters['distance'] = _maxDistance.round();
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1 km',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            Text(
              '50 km',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      'WiFi',
      'Parking',
      'Wheelchair Accessible',
      'Outdoor Seating',
      'Delivery'
    ];
    final selectedFeatures = (_tempFilters['features'] as List?) ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: features.map((feature) {
            final isSelected = selectedFeatures.contains(feature);
            return GestureDetector(
              onTap: () {
                setState(() {
                  List<String> currentFeatures = List.from(selectedFeatures);
                  if (isSelected) {
                    currentFeatures.remove(feature);
                  } else {
                    currentFeatures.add(feature);
                  }
                  _tempFilters['features'] =
                      currentFeatures.isEmpty ? null : currentFeatures;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.dividerColor,
                  ),
                ),
                child: Text(
                  feature,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOpenNowSection() {
    final isOpenNow = _tempFilters['openNow'] as bool? ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Open Now',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Switch(
          value: isOpenNow,
          onChanged: (bool value) {
            setState(() {
              _tempFilters['openNow'] = value ? true : null;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                widget.onApplyFilters(_tempFilters);
                Navigator.pop(context);
              },
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _tempFilters.clear();
      _minPrice = 0;
      _maxPrice = 1000;
      _minRating = 0;
      _maxDistance = 50;
    });
  }
}
