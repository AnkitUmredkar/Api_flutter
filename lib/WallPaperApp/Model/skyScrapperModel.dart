class SkyScrapperModal {
  List<Hit> hits = [];

  SkyScrapperModal({required this.hits});

  factory SkyScrapperModal.fromJson(Map m1) {
    return SkyScrapperModal(
        hits: (m1['hits'] as List).map((e) => Hit.fromJson(e)).toList());
  }
}

class Hit {
  late String user, userImageURL, webformatURL, largeImageURL;
  late int views, likes, comments, downloads;

  Hit(
      {required this.user,
      required this.userImageURL,
      required this.likes,
      required this.comments,
      required this.views,
      required this.webformatURL,
      required this.largeImageURL});

  factory Hit.fromJson(Map m1) {
    return Hit(
        user: m1['user'],
        userImageURL: m1['userImageURL'],
        likes: m1['likes'],
        comments: m1['comments'],
        views: m1['downloads'],
        webformatURL: m1['webformatURL'],
        largeImageURL: m1['largeImageURL']);
  }
}
