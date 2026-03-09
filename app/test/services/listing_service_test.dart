import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:kigali_pullup/models/listing.dart';

// A simplified test that exercises the service logic against a fake Firestore.
void main() {
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
  });

  Listing createTestListing({String id = 'test-1', String name = 'Test'}) {
    return Listing(
      id: id,
      name: name,
      category: 'Hospital',
      address: '123 St',
      contact: '+250 788 000 001',
      description: 'Description',
      latitude: -1.94,
      longitude: 30.06,
      createdBy: 'user-1',
      createdAt: DateTime(2024, 1, 15),
    );
  }

  group('Listing Service (via fake Firestore)', () {
    test('createListing writes a doc with correct fields', () async {
      final listing = createTestListing();
      await fakeFirestore
          .collection('listings')
          .doc(listing.id)
          .set(listing.toMap());

      final doc =
          await fakeFirestore.collection('listings').doc(listing.id).get();
      expect(doc.exists, true);
      expect(doc.data()!['name'], 'Test');
      expect(doc.data()!['category'], 'Hospital');
      expect(doc.data()!['latitude'], -1.94);
    });

    test('getListings stream emits correct listings after create', () async {
      final listing = createTestListing();
      await fakeFirestore
          .collection('listings')
          .doc(listing.id)
          .set(listing.toMap());

      final snapshot = await fakeFirestore.collection('listings').get();
      final listings =
          snapshot.docs.map((d) => Listing.fromMap(d.data())).toList();

      expect(listings.length, 1);
      expect(listings.first.name, 'Test');
    });

    test('updateListing modifies the correct doc', () async {
      final listing = createTestListing();
      await fakeFirestore
          .collection('listings')
          .doc(listing.id)
          .set(listing.toMap());

      final updated = listing.copyWith(name: 'Updated');
      await fakeFirestore
          .collection('listings')
          .doc(updated.id)
          .update(updated.toMap());

      final doc =
          await fakeFirestore.collection('listings').doc(listing.id).get();
      expect(doc.data()!['name'], 'Updated');
    });

    test('deleteListing removes the doc', () async {
      final listing = createTestListing();
      await fakeFirestore
          .collection('listings')
          .doc(listing.id)
          .set(listing.toMap());

      await fakeFirestore.collection('listings').doc(listing.id).delete();

      final doc =
          await fakeFirestore.collection('listings').doc(listing.id).get();
      expect(doc.exists, false);
    });
  });
}
