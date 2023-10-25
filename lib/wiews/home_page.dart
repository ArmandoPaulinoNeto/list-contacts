import 'package:contacts_list/wiews/signup_page.dart';
import 'package:flutter/material.dart';

import '../services/back4app_service.dart';
import 'list_contact_wiew.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome!"),
          primary: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Card(
                elevation: 10,
                color: Colors.transparent,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.vertical(bottom: 
                      Radius.circular(50)
                    )
                  ),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.transparent,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.vertical(bottom: 
                      Radius.circular(50)
                    )
                  ),
                ),
              ),
              Card(
                elevation: 10,
                color: Colors.transparent,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.vertical(bottom: 
                      Radius.circular(50)
                    )
                  ),
                  child: Icon(Icons.contact_mail_rounded,
                    size: 100,
                    color: Colors.purple[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 270),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[400]),
                            child: TextButton(
                              onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (builderContext) => const SignupPage()));
                            },
                          child: Text("Add contact",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        )
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[500]),
                          child: TextButton(
                            onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (builderContext) => ListContact(contactList: BackFourAppService().getAllContact())));
                          },
                        child: Text("List contacts", 
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ),                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
