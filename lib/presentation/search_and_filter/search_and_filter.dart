import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/result_card_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/sort_bottom_sheet_widget.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({Key? key}) : super(key: key);

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  final TextEditingController _searchController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isLoading = false;
  bool _isRecording = false;
  bool _showMapView = false;
  String _currentSort = 'relevance';
  Map<String, dynamic> _activeFilters = {};
  List<String> _searchSuggestions = [];
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _initializeData() {
    _searchSuggestions = [
      'Egyptian restaurants near me',
      'Pyramids of Giza',
      'Mediterranean cuisine',
      'Khan el-Khalili',
      'Seafood restaurants',
      'Coptic Cairo',
      'Italian restaurants',
      'Nile cruise dining',
    ];

    _searchResults = [
      {
        "id": 1,
        "name": "Koshary Abou Tarek",
        "type": "restaurant",
        "cuisine": "Egyptian",
        "rating": 4.5,
        "distance": 1.2,
        "priceRange": "EGP 50-150",
        "isOpen": true,
        "isFavorite": false,
        "image":
            "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "features": ["WiFi", "Delivery"]
      },
      {
        "id": 2,
        "name": "Pyramids of Giza",
        "type": "tourism",
        "category": "Historical Site",
        "rating": 4.8,
        "distance": 15.5,
        "priceRange": "EGP 200-400",
        "isOpen": true,
        "isFavorite": true,
        "image":
            "https://images.pixabay.com/photos/2010/12/13/10/05/pyramids-2159/1280.jpg",
        "features": ["Parking", "Wheelchair Accessible"]
      },
      {
        "id": 3,
        "name": "Sequoia Restaurant",
        "type": "restaurant",
        "cuisine": "Mediterranean",
        "rating": 4.3,
        "distance": 3.8,
        "priceRange": "EGP 300-800",
        "isOpen": false,
        "isFavorite": false,
        "image":
            "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        "features": ["WiFi", "Outdoor Seating", "Parking"]
      },
      {
        "id": 4,
        "name": "Khan el-Khalili Bazaar",
        "type": "tourism",
        "category": "Shopping & Culture",
        "rating": 4.2,
        "distance": 8.1,
        "priceRange": "Free Entry",
        "isOpen": true,
        "isFavorite": false,
        "image":
            "https://images.pixabay.com/photos/2020/02/03/00/12/khan-el-khalili-4815306/1280.jpg",
        "features": ["WiFi"]
      },
      {
        "id": 5,
        "name": "Fish Market Restaurant",
        "type": "restaurant",
        "cuisine": "Seafood",
        "rating": 4.6,
        "distance": 2.3,
        "priceRange": "EGP 400-1200",
        "isOpen": true,
        "isFavorite": true,
        "image":
            "https://images.pexels.com/photos/725991/pexels-photo-725991.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "features": ["WiFi", "Parking", "Outdoor Seating"]
      },
      {
        "id": 6,
        "name": "Coptic Cairo",
        "type": "tourism",
        "category": "Religious Site",
        "rating": 4.4,
        "distance": 12.7,
        "priceRange": "EGP 100-200",
        "isOpen": true,
        "isFavorite": false,
        "image":
            "https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        "features": ["Wheelchair Accessible"]
      }
    ];
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchSuggestions = [
          'Egyptian restaurants near me',
          'Pyramids of Giza',
          'Mediterranean cuisine',
          'Khan el-Khalili',
          'Seafood restaurants',
          'Coptic Cairo',
          'Italian restaurants',
          'Nile cruise dining',
        ];
      });
      return;
    }

    setState(() {
      _searchSuggestions = [
        'Egyptian restaurants near me',
        'Pyramids of Giza',
        'Mediterranean cuisine',
        'Khan el-Khalili',
        'Seafood restaurants',
        'Coptic Cairo',
        'Italian restaurants',
        'Nile cruise dining',
      ]
          .where((suggestion) =>
              suggestion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSuggestionTap(String suggestion) {
    _searchController.text = suggestion;
    _performSearch(suggestion);
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _startVoiceSearch() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        if (_isRecording) {
          final path = await _audioRecorder.stop();
          setState(() {
            _isRecording = false;
          });

          if (path != null) {
            // Simulate voice recognition result
            _searchController.text = 'Egyptian restaurants';
            _performSearch('Egyptian restaurants');
          }
        } else {
          await _audioRecorder.start(const RecordConfig(),
              path: 'voice_search.m4a');
          setState(() {
            _isRecording = true;
          });
        }
      } else {
        // Show permission denied message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required for voice search'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isRecording = false;
      });
    }
  }

  void _onRemoveFilter(String key) {
    setState(() {
      _activeFilters.remove(key);
    });
  }

  void _onClearAllFilters() {
    setState(() {
      _activeFilters.clear();
    });
  }

  void _onApplyFilters(Map<String, dynamic> filters) {
    setState(() {
      _activeFilters = Map.from(filters);
      _activeFilters.removeWhere((key, value) => value == null);
    });
  }

  void _onToggleFavorite(int itemId) {
    setState(() {
      final index = _searchResults.indexWhere((item) => item['id'] == itemId);
      if (index != -1) {
        _searchResults[index]['isFavorite'] =
            !(_searchResults[index]['isFavorite'] as bool);
      }
    });
  }

  void _onSortChanged(String sortType) {
    setState(() {
      _currentSort = sortType;
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterModalWidget(
        currentFilters: _activeFilters,
        onApplyFilters: _onApplyFilters,
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SortBottomSheetWidget(
        currentSort: _currentSort,
        onSortChanged: _onSortChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSearchChanged: _onSearchChanged,
            onVoiceSearch: _startVoiceSearch,
            suggestions: _searchSuggestions,
            onSuggestionTap: _onSuggestionTap,
          ),
          FilterChipsWidget(
            activeFilters: _activeFilters,
            onRemoveFilter: _onRemoveFilter,
            onClearAll: _onClearAllFilters,
          ),
          _buildResultsHeader(),
          Expanded(
            child: _showMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Search & Filter',
        style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 6.w,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: _showFilterModal,
          child: Container(
            margin: EdgeInsets.only(right: 2.w),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: _activeFilters.isNotEmpty
                  ? AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                CustomIconWidget(
                  iconName: 'tune',
                  color: _activeFilters.isNotEmpty
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
                if (_activeFilters.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 3.w,
                      height: 3.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_activeFilters.length}',
                          style: TextStyle(
                            color: AppTheme.lightTheme.colorScheme.onError,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _showMapView = !_showMapView;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: CustomIconWidget(
              iconName: _showMapView ? 'list' : 'map',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          Text(
            '${_searchResults.length} results found',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _showSortBottomSheet,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'sort',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 4.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Sort',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final item = _searchResults[index];
          return ResultCardWidget(
            item: item,
            onTap: () {
              Navigator.pushNamed(context, '/business-profile');
            },
            onFavorite: () => _onToggleFavorite(item['id'] as int),
          );
        },
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.lightTheme.colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'map',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 20.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'Map View',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Interactive map with search results\nwould be displayed here',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          height: 35.h,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                height: 25.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 2.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      height: 1.5.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20.w,
          ),
          SizedBox(height: 3.h),
          Text(
            'No results found',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your search or filters\nto find what you\'re looking for',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _onClearAllFilters,
                child: Text('Clear Filters'),
              ),
              SizedBox(width: 4.w),
              ElevatedButton(
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
                child: Text('New Search'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
