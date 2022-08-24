class AvailablityModel {
  AvailablityModel({
    required this.id,
    required this.fullTime,
    required this.partTime,
    required this.contract,
  });
  late final int id;
  late final bool fullTime;
  late final bool partTime;
  late final bool contract;

  AvailablityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullTime = json['full_time'];
    partTime = json['part_time'];
    contract = json['contract'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_time'] = fullTime;
    _data['part_time'] = partTime;
    _data['contract'] = contract;
    return _data;
  }
}
