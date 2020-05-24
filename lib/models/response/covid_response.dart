class CovidResponse {
  Data data;
  String message;
  bool success;

  CovidResponse({this.data, this.message, this.success});

  CovidResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<TG> tG;
  List<VN> vN;

  Data({this.tG, this.vN});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['TG'] != null) {
      tG = new List<TG>();
      json['TG'].forEach((v) {
        tG.add(new TG.fromJson(v));
      });
    }
    if (json['VN'] != null) {
      vN = new List<VN>();
      json['VN'].forEach((v) {
        vN.add(new VN.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tG != null) {
      data['TG'] = this.tG.map((v) => v.toJson()).toList();
    }
    if (this.vN != null) {
      data['VN'] = this.vN.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TG {
int deaths;
int recovered;
int lastUpdate;
int confirmed;
String provinceName;
String type;
int increaseRecovered;
int increaseDeaths;
int increaseConfirmed;
int id;

TG(
    {this.deaths,
      this.recovered,
      this.lastUpdate,
      this.confirmed,
      this.provinceName,
      this.type,
      this.increaseRecovered,
      this.increaseDeaths,
      this.increaseConfirmed,
      this.id});

TG.fromJson(Map<String, dynamic> json) {
deaths = json['deaths'];
recovered = json['recovered'];
lastUpdate = json['last_update'];
confirmed = json['confirmed'];
provinceName = json['province_name'];
type = json['type'];
increaseRecovered = json['increase_recovered'];
increaseDeaths = json['increase_deaths'];
increaseConfirmed = json['increase_confirmed'];
id = json['id'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['deaths'] = this.deaths;
  data['recovered'] = this.recovered;
  data['last_update'] = this.lastUpdate;
  data['confirmed'] = this.confirmed;
  data['province_name'] = this.provinceName;
  data['type'] = this.type;
  data['increase_recovered'] = this.increaseRecovered;
  data['increase_deaths'] = this.increaseDeaths;
  data['increase_confirmed'] = this.increaseConfirmed;
  data['id'] = this.id;
  return data;
}
}

class VN {
  int deaths;
  int recovered;
  int lastUpdate;
  int confirmed;
  String provinceName;
  String type;
  int increaseRecovered;
  int increaseDeaths;
  int increaseConfirmed;
  int id;

  VN(
      {this.deaths,
        this.recovered,
        this.lastUpdate,
        this.confirmed,
        this.provinceName,
        this.type,
        this.increaseRecovered,
        this.increaseDeaths,
        this.increaseConfirmed,
        this.id});

  VN.fromJson(Map<String, dynamic> json) {
    deaths = json['deaths'];
    recovered = json['recovered'];
    lastUpdate = json['last_update'];
    confirmed = json['confirmed'];
    provinceName = json['province_name'];
    type = json['type'];
    increaseRecovered = json['increase_recovered'];
    increaseDeaths = json['increase_deaths'];
    increaseConfirmed = json['increase_confirmed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['last_update'] = this.lastUpdate;
    data['confirmed'] = this.confirmed;
    data['province_name'] = this.provinceName;
    data['type'] = this.type;
    data['increase_recovered'] = this.increaseRecovered;
    data['increase_deaths'] = this.increaseDeaths;
    data['increase_confirmed'] = this.increaseConfirmed;
    data['id'] = this.id;
    return data;
  }
}
