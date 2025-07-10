# Wine Scanner App

A Flutter application that allows users to scan wine bottles and get detailed information about them, including an AI-powered Q&A feature.

## Features

### 🍷 Wine Scanning
- **Camera Integration**: Take photos of wine bottles using the device camera
- **Gallery Import**: Import wine bottle images from your photo gallery
- **Image Recognition**: Identifies wine bottles and extracts information
- **Real-time Processing**: Instant wine identification with detailed results

### 📊 Wine Information
- **Comprehensive Details**: Name, brand, vintage, region, country, grape variety
- **Wine Ratings**: Quality ratings and reviews
- **Visual Display**: Beautiful cards showing wine information
- **Search Functionality**: Search through previously scanned wines

### 🤖 AI-Powered Q&A
- **Interactive Chat**: Ask questions about any scanned wine
- **Smart Responses**: Get detailed answers about wine characteristics
- **Food Pairing**: Learn about food pairing suggestions
- **Serving Tips**: Get advice on serving temperature and methods
- **Vintage Information**: Learn about aging potential and vintage quality

### 🎨 Modern UI/UX
- **Material Design 3**: Modern, beautiful interface
- **Responsive Design**: Works on all screen sizes
- **Dark/Light Theme**: Adaptive theming
- **Smooth Animations**: Fluid transitions and interactions

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator or Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jyothish-ram/wine-app
   cd wine_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Usage

### Scanning Wine Bottles

1. **Open the app** and tap the "Scan Wine" button
2. **Choose scanning method**:
   - Use camera to take a photo
   - Import from gallery
3. **Position the bottle** clearly in the frame
4. **Wait for processing** - the app will identify the wine
5. **View results** - see detailed wine information

### Using the AI Chat

1. **Scan a wine** or select from recent wines
2. **Tap on the wine** to open details
3. **Go to "Ask AI" tab**
4. **Ask questions** like:
   - "What food pairs well with this wine?"
   - "How long can I age this wine?"
   - "What's the typical price range?"
   - "Tell me about the region this wine comes from"

### Searching Wines

1. **Use the search bar** on the home screen
2. **Type wine names**, brands, or regions
3. **Browse results** and tap to view details

## Technical Architecture

### State Management
- **Provider Pattern**: Centralized state management
- **WineProvider**: Manages wine data and scanning state
- **Reactive UI**: Automatic UI updates based on state changes

### Services
- **WineService**: Handles wine API calls and LLM interactions
- **CameraService**: Manages camera permissions and image capture
- **Mock Data**: Demo wines for testing (replace with real API)

### Models
- **Wine Model**: Structured wine data with JSON serialization
- **Chat Messages**: AI conversation management

### Screens
- **HomeScreen**: Main interface with search and wine list
- **CameraScreen**: Camera interface for scanning
- **WineDetailScreen**: Detailed wine information with AI chat

## Configuration

### API Integration
To use real wine recognition APIs:

1. **Update WineService** in `lib/services/wine_service.dart`
2. **Replace mock data** with actual API endpoints
3. **Add API keys** to your environment configuration

### LLM Integration
To use real LLM services:

1. **Update LLM API URL** in `WineService`
2. **Add authentication** for your LLM provider
3. **Customize prompts** for better wine-specific responses

### Camera Permissions
The app automatically requests camera permissions. For production:

1. **Update Android permissions** in `android/app/src/main/AndroidManifest.xml`
2. **Update iOS permissions** in `ios/Runner/Info.plist`

## Dependencies

### Core Dependencies
- `flutter`: Core Flutter framework
- `provider`: State management
- `camera`: Camera functionality
- `image_picker`: Image selection
- `http`: API communication
- `permission_handler`: Permission management

### UI Dependencies
- `flutter_staggered_grid_view`: Advanced layouts
- `lottie`: Animations
- `cached_network_image`: Image caching

### Development Dependencies
- `json_serializable`: JSON code generation
- `build_runner`: Code generation
- `flutter_lints`: Code quality

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── wine.dart            # Wine data model
├── providers/
│   └── wine_provider.dart   # State management
├── services/
│   ├── wine_service.dart    # Wine API and LLM
│   └── camera_service.dart  # Camera functionality
├── screens/
│   ├── home_screen.dart     # Main screen
│   ├── camera_screen.dart   # Camera interface
│   └── wine_detail_screen.dart # Wine details
└── widgets/
    ├── wine_card.dart       # Wine display card
    └── llm_chat_widget.dart # AI chat interface
```

## Future Enhancements

### Planned Features
- **Barcode Scanning**: Scan wine barcodes for instant identification
- **Wine Database**: Local storage of scanned wines
- **Social Features**: Share wine discoveries with friends
- **Wine Recommendations**: AI-powered wine suggestions
- **Price Tracking**: Monitor wine prices over time
- **Cellar Management**: Organize your wine collection

### Technical Improvements
- **Real-time Recognition**: Live wine identification
- **Offline Support**: Work without internet connection
- **Advanced Analytics**: Wine consumption insights
- **Multi-language Support**: International wine databases

## Contributing

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Add tests** for new functionality
5. **Submit a pull request**

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Note**: This is a demo application with mock data. For production use, integrate with real wine recognition APIs and LLM services.
# wine-app
