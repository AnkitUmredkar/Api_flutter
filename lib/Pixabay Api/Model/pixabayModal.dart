class PixabayModal{
  List<Hit> hits = [];
  PixabayModal({required this.hits});

  factory PixabayModal.fromJson(Map m1){
    return PixabayModal(hits: (m1['hits'] as List).map((e) => Hit.fromJson(e)).toList());
  }
}

class Hit{
  late String user,userImageURL,webformatURL;
  late int views,likes,comments,downloads;

  Hit({required this.user,required this.userImageURL,required this.likes,required this.comments,required this.views,required this.webformatURL});

  factory Hit.fromJson(Map m1){
    return Hit(user: m1['user'], userImageURL: m1['userImageURL'], likes: m1['likes'], comments: m1['comments'], views: m1['downloads'],webformatURL: m1['webformatURL']);
  }
}