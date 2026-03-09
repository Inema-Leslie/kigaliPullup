import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/listing.dart';
import '../services/listing_service.dart';
import 'auth_provider.dart';

/// Provider for the ListingService singleton.
final listingServiceProvider =
    Provider<ListingService>((ref) => ListingService());

/// Real-time stream of all listings.
final allListingsProvider = StreamProvider<List<Listing>>((ref) {
  return ref.watch(listingServiceProvider).getListings();
});

/// Real-time stream of the current user's listings.
final userListingsProvider = StreamProvider<List<Listing>>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) {
      if (user == null) return Stream.value([]);
      return ref.watch(listingServiceProvider).getUserListings(user.uid);
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});

/// Search query state.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Selected category filter (null = "All").
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtered listings: applies search + category filter to the all-listings stream.
final filteredListingsProvider = Provider<AsyncValue<List<Listing>>>((ref) {
  final listingsAsync = ref.watch(allListingsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final category = ref.watch(selectedCategoryProvider);

  return listingsAsync.whenData((listings) {
    var result = listings;

    if (category != null && category.isNotEmpty) {
      result = result.where((l) => l.category == category).toList();
    }

    if (query.isNotEmpty) {
      result = result
          .where((l) => l.name.toLowerCase().contains(query))
          .toList();
    }

    return result;
  });
});
