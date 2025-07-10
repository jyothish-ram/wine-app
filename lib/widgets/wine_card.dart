import 'package:flutter/material.dart';
import 'package:wine_app/models/wine.dart';

class WineCard extends StatelessWidget {
  final Wine wine;
  final VoidCallback onTap;

  const WineCard({super.key, required this.wine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Wine image placeholder
              Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.deepPurple.withOpacity(0.3),
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

              // Wine information
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (wine.brand != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        wine.brand!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                              color: Colors.deepPurple.withOpacity(0.1),
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
                              color: _getTypeColor(wine.type!).withOpacity(0.1),
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

                    if (wine.region != null || wine.country != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        [
                          wine.region,
                          wine.country,
                        ].where((e) => e != null).join(', '),
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Rating and arrow
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
