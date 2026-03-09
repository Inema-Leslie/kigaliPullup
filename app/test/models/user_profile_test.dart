import 'package:flutter_test/flutter_test.dart';
import 'package:kigali_pullup/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    final testMap = {
      'uid': 'user-123',
      'email': 'test@example.com',
      'displayName': 'Test User',
      'locationNotifications': true,
    };

    test('fromMap parses correctly', () {
      final profile = UserProfile.fromMap(testMap);

      expect(profile.uid, 'user-123');
      expect(profile.email, 'test@example.com');
      expect(profile.displayName, 'Test User');
      expect(profile.locationNotifications, true);
    });

    test('fromMap defaults locationNotifications to false when missing', () {
      final map = {
        'uid': 'user-123',
        'email': 'test@example.com',
        'displayName': 'Test User',
      };
      final profile = UserProfile.fromMap(map);

      expect(profile.locationNotifications, false);
    });

    test('toMap serializes correctly', () {
      final profile = UserProfile.fromMap(testMap);
      final map = profile.toMap();

      expect(map['uid'], 'user-123');
      expect(map['email'], 'test@example.com');
      expect(map['displayName'], 'Test User');
      expect(map['locationNotifications'], true);
      expect(map.length, 4);
    });
  });
}
