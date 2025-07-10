import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  static CameraController? _controller;
  static List<CameraDescription>? _cameras;

  static CameraController? get controller => _controller;
  static List<CameraDescription>? get cameras => _cameras;

  // Initialize camera
  static Future<bool> initializeCamera() async {
    try {
      // Request camera permission
      final status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        return false;
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        return false;
      }

      // Initialize camera controller
      _controller = CameraController(
        _cameras![0], // Use first camera (usually back camera)
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      return true;
    } catch (e) {
      print('Error initializing camera: $e');
      return false;
    }
  }

  // Dispose camera
  static Future<void> disposeCamera() async {
    await _controller?.dispose();
    _controller = null;
  }

  // Take picture using camera
  static Future<File?> takePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        return null;
      }

      final image = await _controller!.takePicture();
      return File(image.path);
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }

  // Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }

  // Check camera permission
  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }

  // Request camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }
}
