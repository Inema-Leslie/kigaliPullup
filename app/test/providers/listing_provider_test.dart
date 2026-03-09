import 'package:flutter_test/flutter_test.dart';
import 'package:kigali_pullup/models/listing.dart';

// Test the filtering logic in isolation (same logic used by filteredListingsProvider).
void main() {
  final listings = [
    Listing(
      id: '1',
      name: 'King Faisal Hospital',
      category: 'Hospital',
      address: 'KG 544 St',
      contact: '+250 788 000 001',
      description: 'Hospital',
      latitude: -1.94,
      longitude: 30.10,
      createdBy: 'u1',
      createdAt: DateTime(2024, 1, 1),
    ),
    Listing(
      id: '2',
      name: 'Green Bean Coffee',
      category: 'Café',
      address: 'KG 7 Ave',
      contact: '+250 788 000 002',
      description: 'Café',
      latitude: -1.94,
      longitude: 30.09,
      createdBy: 'u1',
      createdAt: DateTime(2024, 1, 2),
    ),
    Listing(
      id: '3',
      name: 'Kigali Public Library',
      category: 'Library',
      address: 'KN 3 Rd',
      contact: '+250 788 000 003',
      description: 'Library',
      latitude: -1.95,
      longitude: 30.06,
      createdBy: 'u2',
      createdAt: DateTime(2024, 1, 3),
    ),
  ];

  List<Listing> applyFilters(
      List<Listing> src, String query, String? category) {
    var result = src;
    if (category != null && category.isNotEmpty) {
      result = result.where((l) => l.category == category).toList();
    }
    if (query.isNotEmpty) {
      result = result
          .where((l) => l.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return result;
  }

  group('Listing filtering', () {
    test('returns all listings when no filter is active', () {
      final result = applyFilters(listings, '', null);
      expect(result.length, 3);
    });

    test('correctly filters by category', () {
      final result = applyFilters(listings, '', 'Hospital');
      expect(result.length, 1);
      expect(result.first.name, 'King Faisal Hospital');
    });

    test('correctly filters by search query (case-insensitive)', () {
      final result = applyFilters(listings, 'green', null);
      expect(result.length, 1);
      expect(result.first.name, 'Green Bean Coffee');
    });

    test('combined search + category filter', () {
      // Search for "ki" in Hospital category
      final result = applyFilters(listings, 'ki', 'Hospital');
      expect(result.length, 1);
      expect(result.first.name, 'King Faisal Hospital');

      // Search for "ki" in Library category
      final result2 = applyFilters(listings, 'ki', 'Library');
      expect(result2.length, 1);
      expect(result2.first.name, 'Kigali Public Library');

      // Search for "ki" in Café category → no match
      final result3 = applyFilters(listings, 'ki', 'Café');
      expect(result3.length, 0);
    });
  });
}
