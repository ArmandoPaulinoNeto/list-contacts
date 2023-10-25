import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/contact_entity.dart';
import '../services/back4app_service.dart';
import '../utils/convert-base64.dart';
import '../utils/costum_text_form_field.dart';
import '../utils/edit_image.dart';
import 'list_contact_wiew.dart';

class UpdatePage extends StatefulWidget {
  ContactEntity contactEntity;
  UpdatePage({super.key, required this.contactEntity});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String number = "";
  String street = "";
  String district = "";
  String city = "";
  String state = "";
  String country = "";
  String photo = "";
  bool filePhoto = false;
  @override
  Widget build(BuildContext context) {
    
    if (widget.contactEntity.photo != null) {
      photo = widget.contactEntity.photo!;
    }
    filePhoto = photo.isNotEmpty;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Update Contact"),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(100)), color: Colors.teal),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.blueGrey,
                        child: SizedBox(
                          height: 330,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView(
                              children: [
                                CostomTextFormField(
                                  label: "Name",
                                  initValue: widget.contactEntity.name,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field name cannot be empty!" : null,
                                  onSaved: (value) => name = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "Phone number",
                                  initValue: widget.contactEntity.number,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field phone number cannot be empty!" : null,
                                  onSaved: (value) => number = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "Street",
                                  initValue: widget.contactEntity.street,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field street cannot be empty!" : null,
                                  onSaved: (value) => street = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "District",
                                  initValue: widget.contactEntity.district,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field district cannot be empty!" : null,
                                  onSaved: (value) => district = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "City",
                                  initValue: widget.contactEntity.city,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field city cannot be empty!" : null,
                                  onSaved: (value) => city = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "State",
                                  initValue: widget.contactEntity.state,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field State cannot be empty!" : null,
                                  onSaved: (value) => state = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: "Country",
                                  initValue: widget.contactEntity.country,
                                  obscureText: false,
                                  readOnly: false,
                                  validator: (value) => value!.isEmpty ? "The field country cannot be empty!" : null,
                                  onSaved: (value) => country = value!,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                CostomTextFormField(
                                  label: filePhoto ? "Photo loaded." : "Choice photo.",
                                  iconTextField: filePhoto ? Icons.image_rounded : Icons.attach_file,
                                  readOnly: true,
                                  obscureText: false,
                                  validator: (value) => filePhoto == false ? "The field photo cannot be empty!" : null,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                                label: Text("Camera"),
                                                icon: Icon(Icons.camera_alt_outlined),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  selectPhoto(0);
                                                }),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton.icon(
                                                label: Text("Gallary"),
                                                icon: Icon(Icons.image_search_outlined),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  selectPhoto(1);
                                                })
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 400, 20, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.lightBlueAccent),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BackFourAppService backFourAppService = BackFourAppService();
                            ContactEntity contactEntity = ContactEntity(id: widget.contactEntity.id,name: name, number: number, street: street, district: district, city: city, state: state, country: country, photo: photo);
                            backFourAppService.upadateContact(contactEntity);
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
                                              "The contact upadated successful!",
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
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  child: ElevatedButton(
                                                    child: Text(
                                                      "Ok!",
                                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                      formKey.currentState!.reset();
                                                      filePhoto = false;
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                      BackFourAppService backFourAppService = BackFourAppService();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListContact(contactList: BackFourAppService().getAllContact())));
                                                    }
                                                  ),
                                                ),
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
                          }
                        },
                        child: const Icon(Icons.save),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  selectPhoto(int op) async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      late ImageSource imageSource;
      op == 0 ? imageSource = ImageSource.camera : imageSource = ImageSource.gallery;
      XFile? xFile = await imagePicker.pickImage(source: imageSource);
      if (xFile != null) {
        print("Photo path: ${xFile.path}");
        CroppedFile croppedFile = await cutImage(xFile);
        EditImage().ReduceImageQualityAndSize(croppedFile.path).then((value) => {photo = EncodeAndDecodeBase64().imageToBase64(value)});
        setState(() {
          filePhoto = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  cutImage(XFile imageFile) async {
    print("Called cutImage");
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }
}
