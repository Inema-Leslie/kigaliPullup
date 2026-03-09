import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/listing.dart';

class ListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  CollectionReference<Map<String, dynamic>> get _listingsRef =>
      _firestore.collection('listings');

  Stream<List<Listing>> getListings() {
    return _listingsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromMap(doc.data())).toList());
  }

  Stream<List<Listing>> getUserListings(String uid) {
    return _listingsRef
        .where('createdBy', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Listing.fromMap(doc.data())).toList());
  }

  Future<void> createListing(Listing listing) async {
    await _listingsRef.doc(listing.id).set(listing.toMap());
  }

  Future<void> updateListing(Listing listing) async {
    await _listingsRef.doc(listing.id).update(listing.toMap());
  }

  Future<void> deleteListing(String id) async {
    await _listingsRef.doc(id).delete();
  }

  /// Seeds Firestore with 8 sample Kigali listings. Call once from dev settings.
  Future<void> seedData(String createdByUid) async {
    final now = DateTime.now();
    final seedListings = [
      Listing(
        id: _uuid.v4(),
        name: 'Kacyiru Police Station',
        category: 'Police Station',
        address: 'KG 7 Ave, Kacyiru',
        contact: '+250 788 000 001',
        description: 'Main police station serving the Kacyiru sector.',
        latitude: -1.9355,
        longitude: 30.0928,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'King Faisal Hospital',
        category: 'Hospital',
        address: 'KG 544 St, Kigali',
        contact: '+250 788 000 002',
        description:
            'Major referral hospital in Kigali providing specialized care.',
        latitude: -1.9396,
        longitude: 30.1006,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Kimironko Café',
        category: 'Café',
        address: 'KG 15 Ave, Kimironko',
        contact: '+250 788 000 003',
        description: 'Popular café in the Kimironko neighborhood.',
        latitude: -1.9315,
        longitude: 30.1112,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Nyamirambo Regional Stadium',
        category: 'Park',
        address: 'Nyamirambo',
        contact: '+250 788 000 004',
        description: 'Regional stadium and recreational area in Nyamirambo.',
        latitude: -1.9731,
        longitude: 30.0450,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Kigali Public Library',
        category: 'Library',
        address: 'KN 3 Rd, Kigali',
        contact: '+250 788 000 005',
        description:
            'Public library with a wide collection of books and digital resources.',
        latitude: -1.9499,
        longitude: 30.0587,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Inema Arts Center',
        category: 'Tourist Attraction',
        address: 'KG 14 Ave',
        contact: '+250 788 000 006',
        description:
            'Contemporary art gallery showcasing Rwandan artists and culture.',
        latitude: -1.9287,
        longitude: 30.1124,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Green Bean Coffee',
        category: 'Café',
        address: 'KG 7 Ave, Kacyiru',
        contact: '+250 788 000 007',
        description:
            'Specialty coffee shop serving locally-sourced Rwandan coffee.',
        latitude: -1.9363,
        longitude: 30.0895,
        createdBy: createdByUid,
        createdAt: now,
      ),
      Listing(
        id: _uuid.v4(),
        name: 'Kigali City Market',
        category: 'Utility Office',
        address: 'Avenue du Commerce',
        contact: '+250 788 000 008',
        description:
            'Central marketplace for goods, produce, and daily essentials.',
        latitude: -1.9500,
        longitude: 30.0611,
        createdBy: createdByUid,
        createdAt: now,
      ),
    ];

    for (final listing in seedListings) {
      await createListing(listing);
    }
  }
}
