class ContactEntity {
  String? id;
  String? name;
  String? number;
  String? street;
  String? district;
  String? city;
  String? state;
  String? country;
  String? photo;

  ContactEntity({this.id, this.name, this.number, this.street, this.district, this.city, this.state, this.country, this.photo});

  fromJson(Map<String, dynamic> json) {
    return ContactEntity(
      id: json['objectId'],
      name: json['name'],
      number: json['number'],
      street: json['street'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': id,
      'name': name,
      'number': number,
      'street': street,
      'district': district,
      'city': city,
      'state': state,
      'country': country,
      'photo': photo,
    };
  }
}
