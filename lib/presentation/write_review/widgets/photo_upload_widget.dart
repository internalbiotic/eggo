import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PhotoUploadWidget extends StatefulWidget {
  final List<XFile> selectedImages;
  final Function(List<XFile>) onImagesChanged;

  const PhotoUploadWidget({
    Key? key,
    required this.selectedImages,
    required this.onImagesChanged,
  }) : super(key: key);

  @override
  State<PhotoUploadWidget> createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _showCamera = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final camera = kIsWeb
            ? _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.front,
                orElse: () => _cameras.first)
            : _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.back,
                orElse: () => _cameras.first);

        _cameraController = CameraController(
            camera, kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high);
        await _cameraController!.initialize();
        await _applySettings();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
    } catch (e) {
      debugPrint('Focus mode error: $e');
    }

    if (!kIsWeb) {
      try {
        await _cameraController!.setFlashMode(FlashMode.auto);
      } catch (e) {
        debugPrint('Flash mode error: $e');
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile photo = await _cameraController!.takePicture();
      final updatedImages = List<XFile>.from(widget.selectedImages)..add(photo);
      widget.onImagesChanged(updatedImages);

      setState(() {
        _showCamera = false;
      });
    } catch (e) {
      debugPrint('Photo capture error: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        final updatedImages = List<XFile>.from(widget.selectedImages)
          ..addAll(images);
        widget.onImagesChanged(updatedImages);
      }
    } catch (e) {
      debugPrint('Gallery picker error: $e');
    }
  }

  void _removeImage(int index) {
    final updatedImages = List<XFile>.from(widget.selectedImages)
      ..removeAt(index);
    widget.onImagesChanged(updatedImages);
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Add Photos',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'camera_alt',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              title: Text(
                'Take Photo',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () async {
                Navigator.pop(context);
                if (await _requestCameraPermission()) {
                  setState(() {
                    _showCamera = true;
                  });
                }
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              title: Text(
                'Choose from Gallery',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showCamera && _isCameraInitialized && _cameraController != null) {
      return Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              ),
              Positioned(
                top: 2.h,
                right: 4.w,
                child: GestureDetector(
                  onTap: () => setState(() => _showCamera = false),
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: Colors.white,
                      size: 5.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4.h,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _capturePhoto,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Photos (Optional)',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Help others by sharing photos of your experience',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 20.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.selectedImages.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.selectedImages.length) {
                return GestureDetector(
                  onTap: _showImageOptions,
                  child: Container(
                    width: 20.h,
                    margin: EdgeInsets.only(right: 3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'add_a_photo',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 8.w,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Add Photo',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final image = widget.selectedImages[index];
              return Container(
                width: 20.h,
                margin: EdgeInsets.only(right: 3.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: kIsWeb
                          ? Image.network(
                              image.path,
                              width: 20.h,
                              height: 20.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 20.h,
                                  height: 20.h,
                                  color:
                                      AppTheme.lightTheme.colorScheme.surface,
                                  child: CustomIconWidget(
                                    iconName: 'broken_image',
                                    color:
                                        AppTheme.lightTheme.colorScheme.outline,
                                    size: 8.w,
                                  ),
                                );
                              },
                            )
                          : Image.file(
                              File(image.path),
                              width: 20.h,
                              height: 20.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 20.h,
                                  height: 20.h,
                                  color:
                                      AppTheme.lightTheme.colorScheme.surface,
                                  child: CustomIconWidget(
                                    iconName: 'broken_image',
                                    color:
                                        AppTheme.lightTheme.colorScheme.outline,
                                    size: 8.w,
                                  ),
                                );
                              },
                            ),
                    ),
                    Positioned(
                      top: 1.h,
                      right: 2.w,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: EdgeInsets.all(1.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: Colors.white,
                            size: 4.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
