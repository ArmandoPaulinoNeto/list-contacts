import 'dart:convert';
import 'package:contacts_list/wiews/update_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../entities/contact_entity.dart';
import '../services/back4app_service.dart';
import '../utils/convert-base64.dart';

class ListContact extends StatefulWidget {
  Future<Response> contactList;
  ListContact({super.key, required this.contactList});

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  late List<ContactEntity> contactListItems;
  @override
  void initState() {
    contactListItems = List.empty(growable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: widget.contactList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Response response = snapshot.data!;
                  var maps = jsonDecode(response.body);
                  contactListItems = List.generate(maps['results'].length, (index) => ContactEntity().fromJson(maps['results'][index]));
                  return contactListItems.isNotEmpty ? ListView.separated(
                      itemBuilder: ((context, index) {
                        return Card(
                          elevation: 8,
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 10,
                                  shadowColor: Colors.purple[900],
                                  child: Row(
                                    children: [
                                      Card(
                                        elevation: 10,
                                        shadowColor: Colors.blueAccent,
                                        child: SizedBox(
                                          width: 75,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: Image.memory(EncodeAndDecodeBase64().Base64ToImage(contactListItems[index].photo!)).image,
                                                    fit: BoxFit.fill
                                                    ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(contactListItems[index].name!.substring(0, contactListItems[index].name!.indexOf(" ")),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                              )
                                            ],
                                          ),
                                        )
                                      ),
                                      Card(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 160,
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Street:",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text("District:",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                      ),),
                                                    Text("City:",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text("State:",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                      ),),
                                                    Text("Country:",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                      ),)
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 2.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(contactListItems[index].street!),
                                                      Text(contactListItems[index].district!),
                                                      Text(contactListItems[index].city!),
                                                      Text(contactListItems[index].state!),
                                                      Text(contactListItems[index].country!)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 150,
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          child: Icon(Icons.delete_rounded),
                                          onPressed: () {
                                            ContactEntity contactEntity = contactListItems[index];
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(20),
                                                    child: Container(
                                                      child: Wrap(children: [
                                                        Card(
                                                          elevation: 10,
                                                          color: Colors.indigo,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(20),
                                                            child: Text(
                                                              "Do you want to delete the contact?",
                                                              style: TextStyle(fontSize: 20, color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            alignment: Alignment.center,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  child: ElevatedButton(
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                                                    ),
                                                                    onPressed: () => Navigator.of(context).pop(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8.0,
                                                                ),
                                                                Container(
                                                                  child: ElevatedButton(
                                                                      child: Text(
                                                                        "Confirm",
                                                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                                                      ),
                                                                      onPressed: () async {
                                                                        Navigator.of(context).pop();
                                                                        Navigator.of(context).pop();
                                                                        BackFourAppService backFourAppService = BackFourAppService();
                                                                        await backFourAppService.deleteContact(contactListItems[index].id!);
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListContact(contactList: BackFourAppService().getAllContact())));
                                                                      }),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                );
                                              }
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        ElevatedButton(
                                          child: Icon(Icons.edit_note_outlined),
                                          onPressed: () {
                                            ContactEntity contactEntity = contactListItems[index];
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(contactEntity: contactEntity)
                                            ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) => Divider(color: Colors.purple[900]),
                      itemCount: contactListItems.length) 
                  : Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Card(
                          elevation: 10,
                          shadowColor: Colors.blue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No records found!",
                              style: TextStyle(
                                color: Colors.purple[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),
                            )
                          ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
