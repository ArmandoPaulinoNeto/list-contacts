import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entities/contact_entity.dart';

class BackFourAppRepository {
  var endpoint = "https://parseapi.back4app.com/classes/contact";
  var headers = {'X-Parse-Application-Id': 'cE0Kb0vBHdulv7PDWKd6xltY1mGRDcpfKKtbXGb9', 'X-Parse-REST-API-Key': '7ybNNgjLqbKp2XN6RPPxrI2wFBXZYRGK5zZhSlpi', 'Content-Type': 'application/json'};

  create(ContactEntity contactEntity) {

    var body = jsonEncode(contactEntity.toJson());
    var uri = Uri.parse(endpoint);
    http.post(uri, headers: headers, body: body);
  }

  fetchAll() {
    var uri = Uri.parse(endpoint);
    return http.get(uri, headers: headers);
  }

  update(ContactEntity contactEntity) {
    var body = jsonEncode(contactEntity.toJson());
    var uri = Uri.parse("$endpoint/${contactEntity.id!}");
    http.put(uri, headers: headers, body: body);
  }

  delete(String id) {
    var uri = Uri.parse("$endpoint/$id");
    http.delete(uri, headers: headers);
  }
}
