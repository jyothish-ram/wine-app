import 'package:flutter/material.dart';
import 'package:wine_app/models/wine.dart';
import 'package:wine_app/widgets/llm_chat_widget.dart';

class WineDetailScreen extends StatefulWidget {
  final Wine wine;

  const WineDetailScreen({super.key, required this.wine});

  @override
  State<WineDetailScreen> createState() => _WineDetailScreenState();
}

class _WineDetailScreenState extends State<WineDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wine.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Share wine information
              _shareWine();
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          // Wine image and basic info
          _buildWineHeader(),

          // Tab bar
          Container(
            color: Colors.deepPurple,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Ask AI'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildDetailsTab(), _buildAITab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWineHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.purple],
        ),
      ),
      child: Column(
        children: [
          // Wine image placeholder
          Container(
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(Icons.wine_bar, color: Colors.white, size: 60),
          ),

          const SizedBox(height: 16),

          // Wine name
          Text(
            widget.wine.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          if (widget.wine.brand != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.wine.brand!,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],

          if (widget.wine.rating != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  widget.wine.rating!.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          if (widget.wine.description != null) ...[
            _buildInfoSection(
              'Description',
              widget.wine.description!,
              Icons.description,
            ),
            const SizedBox(height: 24),
          ],

          // Wine details
          _buildWineDetailsSection(),

          const SizedBox(height: 24),

          // Food pairing suggestions
          _buildInfoSection(
            'Food Pairing',
            'This wine pairs well with rich dishes, aged cheeses, and hearty meals.',
            Icons.restaurant,
          ),

          const SizedBox(height: 24),

          // Serving suggestions
          _buildInfoSection(
            'Serving Suggestions',
            'Serve at room temperature (18-20°C) for red wines, or chilled (8-12°C) for white wines.',
            Icons.local_bar,
          ),
        ],
      ),
    );
  }

  Widget _buildAITab() {
    return LLMChatWidget(wine: widget.wine);
  }

  Widget _buildInfoSection(String title, String content, [IconData? icon]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.deepPurple, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (content.isNotEmpty)
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
      ],
    );
  }

  Widget _buildWineDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.info, color: Colors.deepPurple, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Wine Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (widget.wine.vintage != null)
          _buildDetailRow('Vintage', widget.wine.vintage!),
        if (widget.wine.type != null)
          _buildDetailRow('Type', widget.wine.type!),
        if (widget.wine.region != null)
          _buildDetailRow('Region', widget.wine.region!),
        if (widget.wine.country != null)
          _buildDetailRow('Country', widget.wine.country!),
        if (widget.wine.grapeVariety != null)
          _buildDetailRow('Grape Variety', widget.wine.grapeVariety!),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _shareWine() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }
}
