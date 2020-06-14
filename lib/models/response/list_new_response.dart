class ListNewsResponse {
  int code;
  Data data;


  ListNewsResponse({this.code, this.data});

  ListNewsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Category category;
  int categoryId;

  Data({this.category,this.categoryId});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['1001002'] != null
        ? new Category.fromJson(json['1001002'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['1001002'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  List<ListData> listData;

  Category({this.listData});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listData = new List<ListData>();
      json['data'].forEach((v) {
        listData.add(new ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listData != null) {
      data['data'] = this.listData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  int articleId;
  String title;
  String lead;
  String shareUrl;
  String thumbnailUrl;
  int publishTime;
  int offThumb;

  ListData({this.articleId, this.title, this.lead, this.shareUrl, this.thumbnailUrl, this.publishTime, this.offThumb});

  ListData.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    lead = json['lead'];
    shareUrl = json['share_url'];
    thumbnailUrl = json['thumbnail_url'];
    publishTime = json['publish_time'];
    offThumb = json['off_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_id'] = this.articleId;
    data['title'] = this.title;
    data['lead'] = this.lead;
    data['share_url'] = this.shareUrl;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['publish_time'] = this.publishTime;
    data['off_thumb'] = this.offThumb;
    return data;
  }
}