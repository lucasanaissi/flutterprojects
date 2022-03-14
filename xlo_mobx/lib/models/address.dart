import 'package:xlo_mobx/models/uf.dart';

import 'city.dart';

class Address {

  Address({this.uf, this.city, this.cep, this.district, this.publicPlace});

  UF? uf;
  City? city;

  String? cep;
  String? district;
  String? publicPlace;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, '
        'district: $district, publicPlace: $publicPlace}';
  }
}