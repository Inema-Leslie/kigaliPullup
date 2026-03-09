import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/listing_card.dart';
import '../../widgets/loading_widget.dart';
import '../../router.dart' show navigateToDetail, navigateToForm;

class MyListingsScreen extends ConsumerWidget {
  const MyListingsScreen({super.key});

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Listing'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(listingServiceProvider).deleteListing(id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(userListingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Listings')),
      body: listingsAsync.when(
        data: (listings) {
          if (listings.isEmpty) {
            return const Center(
                child: Text('You have no listings yet.\nTap + to add one.'));
          }
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, i) => ListingCard(
              listing: listings[i],
              onTap: () =>
                  navigateToDetail(context, listings[i]),
              onEdit: () =>
                  navigateToForm(context, listing: listings[i]),
              onDelete: () =>
                  _confirmDelete(context, ref, listings[i].id),
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
