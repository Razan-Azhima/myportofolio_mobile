import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/experience.dart';

void main() {
  test('deserializes the Django Experience response', () {
    final experience = Experience.fromJson({
      'id': 'd7c6fe53-430a-41f0-9e4a-81898f4e3d68',
      'title': 'Mobile Developer Intern',
      'description': 'Developed Flutter features.',
      'category': 'internship',
      'thumbnail': 'https://example.com/image.jpg',
      'thumbnail_direct_url': 'https://example.com/image.jpg',
      'started_at': '2025-01-10T09:00:00Z',
      'ended_at': null,
      'star_count': 3,
      'is_starred': true,
    });

    expect(experience.id, 'd7c6fe53-430a-41f0-9e4a-81898f4e3d68');
    expect(experience.category, 'internship');
    expect(experience.startedAt, DateTime.utc(2025, 1, 10, 9));
    expect(experience.endedAt, isNull);
    expect(experience.starCount, 3);
    expect(experience.isStarred, isTrue);
  });

  test('serializes only fields writable through the Django API', () {
    const experience = Experience(
      id: 'd7c6fe53-430a-41f0-9e4a-81898f4e3d68',
      title: 'Mobile Developer Intern',
      description: 'Developed Flutter features.',
      category: 'internship',
      thumbnail: 'https://example.com/image.jpg',
      thumbnailDirectUrl: 'https://example.com/image.jpg',
      startedAt: null,
      endedAt: null,
      starCount: 3,
      isStarred: true,
    );

    expect(experience.toJson(), {
      'title': 'Mobile Developer Intern',
      'description': 'Developed Flutter features.',
      'category': 'internship',
      'thumbnail': 'https://example.com/image.jpg',
      'ended_at': null,
    });
  });

  test('uses defaults for optional computed fields absent from a response', () {
    final experience = Experience.fromJson({
      'title': 'Research Assistant',
      'description': 'Supported a research project.',
      'category': 'research',
    });

    expect(experience.thumbnailDirectUrl, '');
    expect(experience.starCount, 0);
    expect(experience.isStarred, isFalse);
    expect(experience.thumbnail, isNull);
    expect(experience.endedAt, isNull);
  });
}
