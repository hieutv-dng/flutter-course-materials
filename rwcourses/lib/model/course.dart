import 'domain.dart';

class Course {
  final String courseId;
  final String name;
  final String? description;
  final String? artworkUrl;
  final String? difficulty;
  final String? contributors;
  final List<Domain> domains;

  Course(
    this.courseId,
    this.name,
    this.description,
    this.artworkUrl,
    this.difficulty,
    this.contributors,
    this.domains,
  );

  Course.fromJson(Map<String, dynamic> json)
      : courseId = json['id'],
        name = json['attributes']['name'] as String,
        description = json['attributes']['description_plain_text'] as String?,
        artworkUrl = json['attributes']['card_artwork_url'] as String?,
        difficulty = json['attributes']['difficulty'] as String?,
        contributors = json['attributes']['contributor_string'] as String?,
        domains = [] {
    final domainData =
        json['relationships']['domains']['data'] as List<dynamic>;
    for (var i = 0; i < domainData.length; i++) {
      final domain = Domain.getDomain(domainData[i]['id']);
      domains.add(domain);
    }
  }

  @override
  String toString() {
    return '$name - $domains';
  }

  String get domainsString => domains.map((e) => e.name).join(', ');
}
