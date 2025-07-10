import 'dart:io';
import 'package:wine_app/models/wine.dart';

class WineService {
  // You can replace these with actual API endpoints
  static const String _baseUrl =
      'https://api.example.com'; // Replace with actual wine API
  static const String _llmApiUrl =
      'https://api.openai.com/v1/chat/completions'; // Replace with your LLM API

  // For demo purposes, we'll use mock data
  static final List<Wine> _mockWines = [
    Wine(
      id: '1',
      name: 'Château Margaux',
      brand: 'Château Margaux',
      vintage: '2015',
      region: 'Bordeaux',
      country: 'France',
      grapeVariety: 'Cabernet Sauvignon, Merlot',
      type: 'red',
      description:
          'A prestigious red wine from the Margaux appellation in Bordeaux, known for its elegance and complexity.',
      rating: 4.8,
      imageUrl: 'https://example.com/chateau-margaux.jpg',
    ),
    Wine(
      id: '2',
      name: 'Dom Pérignon',
      brand: 'Moët & Chandon',
      vintage: '2012',
      region: 'Champagne',
      country: 'France',
      grapeVariety: 'Chardonnay, Pinot Noir',
      type: 'sparkling',
      description:
          'A prestigious vintage champagne known for its exceptional quality and aging potential.',
      rating: 4.9,
      imageUrl: 'https://example.com/dom-perignon.jpg',
    ),
    Wine(
      id: '3',
      name: 'Sassicaia',
      brand: 'Tenuta San Guido',
      vintage: '2018',
      region: 'Tuscany',
      country: 'Italy',
      grapeVariety: 'Cabernet Sauvignon, Cabernet Franc',
      type: 'red',
      description:
          'A legendary Italian wine that revolutionized the country\'s wine industry.',
      rating: 4.7,
      imageUrl: 'https://example.com/sassicaia.jpg',
    ),
  ];

  // Scan wine bottle using image
  Future<Wine?> scanWineBottle(File imageFile) async {
    try {
      // In a real app, you would:
      // 1. Upload the image to a wine recognition API
      // 2. Get wine information back
      // 3. Return the wine data

      // For demo purposes, we'll simulate API call delay and return mock data
      await Future.delayed(const Duration(seconds: 2));

      // Simulate random wine selection
      final random = DateTime.now().millisecondsSinceEpoch % _mockWines.length;
      return _mockWines[random];
    } catch (e) {
      print('Error scanning wine bottle: $e');
      return null;
    }
  }

  // Get wine information by ID
  Future<Wine?> getWineById(String id) async {
    try {
      // In a real app, make API call to get wine details
      await Future.delayed(const Duration(milliseconds: 500));

      return _mockWines.firstWhere(
        (wine) => wine.id == id,
        orElse: () => throw Exception('Wine not found'),
      );
    } catch (e) {
      print('Error getting wine by ID: $e');
      return null;
    }
  }

  // Ask LLM about wine
  Future<String> askAboutWine(Wine wine, String question) async {
    try {
      // Prepare the prompt for the LLM
      final prompt =
          '''
Wine Information:
- Name: ${wine.name}
- Brand: ${wine.brand ?? 'N/A'}
- Vintage: ${wine.vintage ?? 'N/A'}
- Region: ${wine.region ?? 'N/A'}
- Country: ${wine.country ?? 'N/A'}
- Grape Variety: ${wine.grapeVariety ?? 'N/A'}
- Type: ${wine.type ?? 'N/A'}
- Description: ${wine.description ?? 'N/A'}
- Rating: ${wine.rating ?? 'N/A'}

Question: $question

Please provide a detailed and informative answer about this wine based on the information provided.
''';

      // In a real app, you would make an API call to your LLM service
      // For demo purposes, we'll simulate the response
      await Future.delayed(const Duration(seconds: 1));

      return _generateMockLLMResponse(wine, question);
    } catch (e) {
      print('Error asking about wine: $e');
      return 'Sorry, I encountered an error while processing your question. Please try again.';
    }
  }

  // Mock LLM response generator
  String _generateMockLLMResponse(Wine wine, String question) {
    final questionLower = question.toLowerCase();

    if (questionLower.contains('pair') || questionLower.contains('food')) {
      return '${wine.name} pairs excellently with rich dishes like grilled red meats, aged cheeses, and hearty stews. The wine\'s ${wine.type} characteristics complement bold flavors beautifully.';
    } else if (questionLower.contains('age') ||
        questionLower.contains('vintage')) {
      return 'The ${wine.vintage ?? 'current'} vintage of ${wine.name} is known for its aging potential. This wine can typically be cellared for 10-20 years, developing more complex flavors over time.';
    } else if (questionLower.contains('price') ||
        questionLower.contains('cost')) {
      return '${wine.name} is considered a premium wine, with prices typically ranging from \$200-\$1000+ depending on the vintage and market conditions.';
    } else if (questionLower.contains('region') ||
        questionLower.contains('origin')) {
      return '${wine.name} comes from ${wine.region ?? 'a renowned wine region'} in ${wine.country ?? 'a prestigious wine-producing country'}. This region is known for its ideal climate and soil conditions for growing ${wine.grapeVariety ?? 'premium grapes'}.';
    } else {
      return '${wine.name} is a ${wine.type ?? 'premium'} wine from ${wine.region ?? 'a prestigious region'} in ${wine.country ?? 'a renowned wine country'}. ${wine.description ?? 'It\'s known for its exceptional quality and distinctive characteristics.'}';
    }
  }

  // Search wines by name
  Future<List<Wine>> searchWines(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final queryLower = query.toLowerCase();
      return _mockWines
          .where(
            (wine) =>
                wine.name.toLowerCase().contains(queryLower) ||
                wine.brand?.toLowerCase().contains(queryLower) == true ||
                wine.region?.toLowerCase().contains(queryLower) == true,
          )
          .toList();
    } catch (e) {
      print('Error searching wines: $e');
      return [];
    }
  }
}
