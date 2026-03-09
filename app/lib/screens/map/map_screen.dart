import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/loading_widget.dart';
import '../../router.dart' show navigateToDetail;

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  static const _kigaliCenter = LatLng(-1.9441, 30.0619);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(allListingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: listingsAsync.when(
        data: (listings) {
          final markers = listings.map((listing) {
            return Marker(
              point: LatLng(listing.latitude, listing.longitude),
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(listing.name, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Chip(label: Text(listing.category)),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                navigateToDetail(context, listing);
                              },
                              child: const Text('View Details'),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
              ),
            );
          }).toList();

          return FlutterMap(
            options: const MapOptions(
              initialCenter: _kigaliCenter,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.leslie.kigaliPullup',
              ),
              MarkerLayer(markers: markers),
            ],
          );
        },
        loading: () => const LoadingWidget(message: 'Loading map...'),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
