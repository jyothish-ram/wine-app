import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wine_app/models/wine.dart';
import 'package:wine_app/services/wine_service.dart';
import 'package:wine_app/services/camera_service.dart';

class WineProvider extends ChangeNotifier {
  final WineService _wineService = WineService();

  Wine? _currentWine;
  List<Wine> _recentWines = [];
  bool _isScanning = false;
  bool _isLoading = false;
  String? _error;
  String? _llmResponse;
  bool _isAskingLLM = false;

  // Getters
  Wine? get currentWine => _currentWine;
  List<Wine> get recentWines => _recentWines;
  bool get isScanning => _isScanning;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get llmResponse => _llmResponse;
  bool get isAskingLLM => _isAskingLLM;

  // Initialize camera
  Future<bool> initializeCamera() async {
    _setLoading(true);
    try {
      final success = await CameraService.initializeCamera();
      if (!success) {
        _setError('Failed to initialize camera. Please check permissions.');
      }
      return success;
    } catch (e) {
      _setError('Error initializing camera: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Scan wine bottle
  Future<void> scanWineBottle(File imageFile) async {
    _setScanning(true);
    _clearError();

    try {
      final wine = await _wineService.scanWineBottle(imageFile);

      if (wine != null) {
        _currentWine = wine;
        _addToRecentWines(wine);
        notifyListeners();
      } else {
        _setError(
          'Could not identify the wine. Please try again with a clearer image.',
        );
      }
    } catch (e) {
      _setError('Error scanning wine: $e');
    } finally {
      _setScanning(false);
    }
  }

  // Take picture and scan
  Future<void> takePictureAndScan() async {
    final imageFile = await CameraService.takePicture();
    if (imageFile != null) {
      await scanWineBottle(imageFile);
    } else {
      _setError('Failed to take picture. Please try again.');
    }
  }

  // Pick image from gallery and scan
  Future<void> pickImageAndScan() async {
    final imageFile = await CameraService.pickImageFromGallery();
    if (imageFile != null) {
      await scanWineBottle(imageFile);
    } else {
      _setError('Failed to pick image. Please try again.');
    }
  }

  // Ask LLM about current wine
  Future<void> askAboutWine(String question) async {
    if (_currentWine == null) {
      _setError('No wine selected. Please scan a wine first.');
      return;
    }

    _setAskingLLM(true);
    _clearError();

    try {
      final response = await _wineService.askAboutWine(_currentWine!, question);
      _llmResponse = response;
      notifyListeners();
    } catch (e) {
      _setError('Error getting LLM response: $e');
    } finally {
      _setAskingLLM(false);
    }
  }

  // Search wines
  Future<void> searchWines(String query) async {
    if (query.trim().isEmpty) {
      _recentWines = [];
      notifyListeners();
      return;
    }

    _setLoading(true);
    try {
      final wines = await _wineService.searchWines(query);
      _recentWines = wines;
      notifyListeners();
    } catch (e) {
      _setError('Error searching wines: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Clear current wine
  void clearCurrentWine() {
    _currentWine = null;
    _llmResponse = null;
    notifyListeners();
  }

  // Clear LLM response
  void clearLLMResponse() {
    _llmResponse = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Add wine to recent wines
  void _addToRecentWines(Wine wine) {
    // Remove if already exists
    _recentWines.removeWhere((w) => w.id == wine.id);
    // Add to beginning
    _recentWines.insert(0, wine);
    // Keep only last 10
    if (_recentWines.length > 10) {
      _recentWines = _recentWines.take(10).toList();
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set scanning state
  void _setScanning(bool scanning) {
    _isScanning = scanning;
    notifyListeners();
  }

  // Set asking LLM state
  void _setAskingLLM(bool asking) {
    _isAskingLLM = asking;
    notifyListeners();
  }

  // Set error
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void _clearError() {
    _error = null;
  }

  // Dispose
  @override
  void dispose() {
    CameraService.disposeCamera();
    super.dispose();
  }
}
