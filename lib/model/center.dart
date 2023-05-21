class Center{
  late int id;
  late String name;
  late String location;

  Center({required this.id, required this.name, required this.location});

  Center.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    return data;
  }

  @override
  toString(){
    return this.name + " : " + this.location;
  }
}