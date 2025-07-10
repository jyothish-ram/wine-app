import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:wine_app/providers/wine_provider.dart';
import 'package:wine_app/services/camera_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final provider = Provider.of<WineProvider>(context, listen: false);
    final success = await provider.initializeCamera();
    if (success) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<WineProvider>(
        builder: (context, provider, child) {
          if (!_isInitialized) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          final controller = CameraService.controller;
          if (controller == null || !controller.value.isInitialized) {
            return const Center(
              child: Text(
                'Camera not available',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Stack(
            children: [
              // Camera preview
              CameraPreview(controller),

              // Overlay UI
              _buildOverlay(provider),

              // Error message
              if (provider.error != null) _buildErrorMessage(provider.error!),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOverlay(WineProvider provider) {
    return SafeArea(
      child: Column(
        children: [
          // Top bar
          _buildTopBar(),

          const Spacer(),

          // Bottom controls
          _buildBottomControls(provider),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const Spacer(),
          const Text(
            'Scan Wine Bottle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildBottomControls(WineProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gallery button
          _buildControlButton(
            icon: Icons.photo_library,
            label: 'Gallery',
            onPressed: () => provider.pickImageAndScan(),
          ),

          // Capture button
          _buildCaptureButton(provider),

          // Flash button
          _buildControlButton(
            icon: Icons.flash_on,
            label: 'Flash',
            onPressed: () {
              // Toggle flash
              final controller = CameraService.controller;
              if (controller != null) {
                controller.setFlashMode(
                  controller.value.flashMode == FlashMode.off
                      ? FlashMode.torch
                      : FlashMode.off,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureButton(WineProvider provider) {
    return GestureDetector(
      onTap: provider.isScanning ? null : () => provider.takePictureAndScan(),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: provider.isScanning ? Colors.grey : Colors.white,
            width: 4,
          ),
          color: provider.isScanning
              ? Colors.grey
              : Colors.white.withOpacity(0.2),
        ),
        child: Center(
          child: provider.isScanning
              ? const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : const Icon(Icons.camera, color: Colors.white, size: 40),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildErrorMessage(String error) {
    return Positioned(
      top: 100,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                error,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<WineProvider>(context, listen: false).clearError();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
