import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wine_app/providers/wine_provider.dart';
import 'package:wine_app/screens/camera_screen.dart';
import 'package:wine_app/screens/wine_detail_screen.dart';
import 'package:wine_app/widgets/wine_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _buildAppBar(),

            // Search bar
            _buildSearchBar(),

            // Content
            Expanded(
              child: Consumer<WineProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null) {
                    return _buildErrorWidget(provider.error!);
                  }

                  if (provider.recentWines.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildWineList(provider);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildScanButton(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.deepPurple, Colors.purple],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.wine_bar, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Wine Scanner',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Settings or profile
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search wines...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    Provider.of<WineProvider>(
                      context,
                      listen: false,
                    ).searchWines('');
                  },
                  icon: const Icon(Icons.clear, color: Colors.grey),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        onChanged: (value) {
          Provider.of<WineProvider>(context, listen: false).searchWines(value);
        },
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text('Error', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Provider.of<WineProvider>(context, listen: false).clearError();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wine_bar, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            'No wines found',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Scan a wine bottle to get started',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _navigateToCamera(),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scan Wine'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWineList(WineProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Wines',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: provider.recentWines.length,
            itemBuilder: (context, index) {
              final wine = provider.recentWines[index];
              return WineCard(
                wine: wine,
                onTap: () => _navigateToWineDetail(wine),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScanButton() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToCamera(),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.camera_alt),
      label: const Text('Scan Wine'),
    );
  }

  void _navigateToCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreen()),
    );
  }

  void _navigateToWineDetail(wine) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WineDetailScreen(wine: wine)),
    );
  }
}
