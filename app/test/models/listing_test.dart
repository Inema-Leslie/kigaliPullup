import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kigali_pullup/models/listing.dart';

void main() {
  group('Listing', () {
    final testMap = {
      'id': 'test-id',
      'name': 'Test Place',
      'category': 'Hospital',
      'address': '123 Main St',
      'contact': '+250 788 000 001',
      'description': 'A test listing',
      'latitude': -1.9441,
      'longitude': 30.0619,
      'createdBy': 'user-123',
      'createdAt': Timestamp.fromDate(DateTime(2024, 1, 15)),
    };

    test('fromMap correctly parses all fields', () {
      final listing = Listing.fromMap(testMap);

      expect(listing.id, 'test-id');
      expect(listing.name, 'Test Place');
      expect(listing.category, 'Hospital');
      expect(listing.address, '123 Main St');
      expect(listing.contact, '+250 788 000 001');
      expect(listing.description, 'A test listing');
      expect(listing.latitude, -1.9441);
      expect(listing.longitude, 30.0619);
      expect(listing.createdBy, 'user-123');
      expect(listing.createdAt, DateTime(2024, 1, 15));
    });

    test('toMap produces correct map keys', () {
      final listing = Listing.fromMap(testMap);
      final map = listing.toMap();

      expect(map.containsKey('id'), true);
      expect(map.containsKey('name'), true);
      expect(map.containsKey('category'), true);
      expect(map.containsKey('address'), true);
      expect(map.containsKey('contact'), true);
      expect(map.containsKey('description'), true);
      expect(map.containsKey('latitude'), true);
      expect(map.containsKey('longitude'), true);
      expect(map.containsKey('createdBy'), true);
      expect(map.containsKey('createdAt'), true);
      expect(map['name'], 'Test Place');
      expect(map['latitude'], -1.9441);
    });

    test('copyWith updates only specified fields', () {
      final listing = Listing.fromMap(testMap);
      final updated = listing.copyWith(name: 'Updated Place', latitude: -2.0);

      expect(updated.name, 'Updated Place');
      expect(updated.latitude, -2.0);
      // Unchanged fields
      expect(updated.id, 'test-id');
      expect(updated.category, 'Hospital');
      expect(updated.address, '123 Main St');
      expect(updated.contact, '+250 788 000 001');
      expect(updated.longitude, 30.0619);
      expect(updated.createdBy, 'user-123');
    });
  });
}
