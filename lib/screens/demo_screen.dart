import 'package:flutter/material.dart';
import 'package:wine_app/models/wine.dart';
import 'package:wine_app/screens/wine_detail_screen.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wine Scanner Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wine Scanner App Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This demo shows the wine scanning app features:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Demo wines
            const Text(
              'Sample Wines:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  _buildDemoWineCard(
                    context,
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
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDemoWineCard(
                    context,
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
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDemoWineCard(
                    context,
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
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Features list
            const Text(
              'App Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('📷 Camera scanning for wine bottles'),
            _buildFeatureItem('🔍 Image recognition and wine identification'),
            _buildFeatureItem('🤖 AI-powered Q&A about wines'),
            _buildFeatureItem('📊 Detailed wine information and ratings'),
            _buildFeatureItem('🔍 Search functionality for wines'),
            _buildFeatureItem('💬 Interactive chat with wine AI'),
            _buildFeatureItem('🍽️ Food pairing suggestions'),
            _buildFeatureItem('📱 Modern, responsive UI'),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoWineCard(BuildContext context, Wine wine) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WineDetailScreen(wine: wine),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.deepPurple.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.wine_bar,
                  color: Colors.deepPurple,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wine.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (wine.brand != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        wine.brand!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (wine.vintage != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              wine.vintage!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (wine.type != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getTypeColor(
                                wine.type!,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              wine.type!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getTypeColor(wine.type!),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (wine.rating != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          wine.rating!.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'white':
        return Colors.amber;
      case 'rose':
        return Colors.pink;
      case 'sparkling':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
