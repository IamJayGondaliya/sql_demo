class Hotel {
  late int id;
  late String name;
  late double star;

  Hotel(
    this.id,
    this.name,
    this.star,
  );

  factory Hotel.fromSQL({required Map data}) => Hotel(
        data['id'],
        data['name'],
        data['star'],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'star': star,
      };
}
