class News {
  String type_of;
  int id;
  String title;
  String description;
  String readable_publish_date;
  String slug;
  String path;
  String url;
  int comments_count;
  int positive_reactions_count;
  int collection_id;
  String published_timestamp;
  String cover_image;
  String social_image;
  String canonical_url;
  String created_at;
  String edited_at;
  String crossposted_at;
  String published_at;
  String last_comment_at;
  dynamic tag_list;
  dynamic tags;
  Map<dynamic, dynamic> user;
  Map<dynamic, dynamic> flare_tag;
  Map<dynamic, dynamic> organization;
  String body_html;
  String body_markdown;

  News(
      {this.type_of,
      this.id,
      this.title,
      this.description,
      this.readable_publish_date,
      this.slug,
      this.path,
      this.url,
      this.comments_count,
      this.positive_reactions_count,
      this.collection_id,
      this.published_timestamp,
      this.cover_image,
      this.social_image,
      this.canonical_url,
      this.created_at,
      this.edited_at,
      this.crossposted_at,
      this.published_at,
      this.last_comment_at,
      this.tag_list,
      this.tags,
      this.user,
      this.flare_tag,
      this.organization,
      this.body_html,
      this.body_markdown});

  bool hasFlare() {
    if (flare_tag == null) return false;
    return true;
  }

  bool hasOrganization() {
    if (organization == null) return false;
    return true;
  }

  News.fromJson(Map j)
      : type_of = j['type_of'],
        id = j['id'],
        title = j['title'],
        description = j['description'],
        readable_publish_date = j['readable_publish_date'],
        slug = j['slug'],
        path = j['path'],
        url = j['url'],
        comments_count = j['comments_count'],
        positive_reactions_count = j['positive_reactions_count'],
        collection_id = j['collection_id'],
        published_timestamp = j['published_timestamp'],
        cover_image = j['cover_image'],
        social_image = j['social_image'],
        canonical_url = j['canonical_url'],
        created_at = j['created_at'],
        edited_at = j['edited_at'],
        crossposted_at = j['crossposted_at'],
        published_at = j['published_at'],
        last_comment_at = j['last_comment_at'],
        tag_list = j['tag_list'],
        tags = j['tags'],
        user = j['user'],
        flare_tag = j['flare_tag'],
        organization = j['organization'],
        body_html = j['body_html'],
        body_markdown = j['body_markdown'];
}

class User {
  String name;
  String username;
  String twitter_username;
  String github_username;
  String website_url;
  String profile_image;
  String profile_image_90;

  User(
      {this.name,
      this.username,
      this.twitter_username,
      this.github_username,
      this.website_url,
      this.profile_image,
      this.profile_image_90});

  User.fromJson(Map j)
      : name = j['name'],
        username = j['username'],
        twitter_username = j['twitter_username'],
        github_username = j['github_username'],
        website_url = j['website_url'],
        profile_image = j['profile_image'],
        profile_image_90 = j['profile_image_90'];
}
