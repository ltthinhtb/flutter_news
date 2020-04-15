class ListNewsRequest {
  int categoryId;
  int limit;
  int page;
  String dataSelect;
  String fbclid;

  ListNewsRequest(
      {this.categoryId, this.limit, this.page, this.dataSelect, this.fbclid});

  ListNewsRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    limit = json['limit'];
    page = json['page'];
    dataSelect = json['data_select'];
    fbclid = json['fbclid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['data_select'] = this.dataSelect;
    data['fbclid'] = this.fbclid;
    return data;
  }
}
