class CenterData {
  late int id;
  late String location;

  CenterData({required this.id, required this.location});

  CenterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    return data;
  }

  @override
  toString() {
    return this.location;
  }
}
