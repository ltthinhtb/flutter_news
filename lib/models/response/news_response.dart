class NewsResponse {
  List<Data> data;
  String category;
  int index;
  NewsResponse({this.data,this.category,this.index});
  NewsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int articleId;
  String lead;
  int siteId;
  String title;
  String shareUrl;
  String thumbnailUrl;
  int publishTime;
  int offThumb;

  Data(
      {this.articleId,
        this.lead,
        this.siteId,
        this.title,
        this.shareUrl,
        this.thumbnailUrl,
        this.publishTime,
        this.offThumb});

  Data.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    lead = json['lead'];
    siteId = json['site_id'];
    title = json['title'];
    shareUrl = json['share_url'];
    thumbnailUrl = json['thumbnail_url'];
    publishTime = json['publish_time'];
    offThumb = json['off_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_id'] = this.articleId;
    data['lead'] = this.lead;
    data['site_id'] = this.siteId;
    data['title'] = this.title;
    data['share_url'] = this.shareUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['publish_time'] = this.publishTime;
    data['off_thumb'] = this.offThumb;
    return data;
  }
}
