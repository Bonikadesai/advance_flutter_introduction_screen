import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../modals/contact_list.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ImagePicker picker = ImagePicker();
  File? xfile;
  final GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> imageFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> detailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> contactinfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String email = "";
  File? imgFile;

  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Contact Page",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (addContactFormKey.currentState!.validate()) {
                addContactFormKey.currentState!.save();
                Contact c1 = Contact(
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  email: email,
                  imgFile: imgFile!,
                );
                // Globals.allContacts.add(c1);
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil('/', (route) => false);
                // setState(() {});
              }
            },
            icon: Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              addContactFormKey.currentState!.reset();
              firstNameController.text = "";
              lastNameController.text = "";
              phonenumberController.text = "";
              emailController.text = "";
              imgFile = null;
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Form(
        key: addContactFormKey,
        child: Stepper(
          margin: EdgeInsets.all(50),
          onStepTapped: (val) {
            setState(() {
              initialIndex = val;
            });
          },
          currentStep: initialIndex,
          onStepContinue: () {
            setState(() {
              if (initialIndex < 3) {
                initialIndex++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (initialIndex > 0) {
                initialIndex--;
              }
            });
          },
          steps: [
            Step(
              state:
                  (initialIndex == 0) ? StepState.editing : StepState.indexed,
              subtitle: Text("Pick Image Here"),
              isActive: (initialIndex == 0) ? true : false,
              title: Text(
                "Pick Your Image",
              ),
              content: Form(
                key: imageFormKey,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade400,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.black),
                      ),
                      foregroundImage:
                          (imgFile == null) ? null : FileImage(imgFile as File),
                    ),
                    FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.camera_alt),
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? xFile =
                            await picker.pickImage(source: ImageSource.camera);
                        String path = xFile!.path;
                        setState(() {
                          imgFile = File(path);
                        });
                      },
                    ),
                    FloatingActionButton(
                      mini: true,
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Profile Photo",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              imgFile = null;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () async {
                                          final XFile? xfile =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);

                                          String imagePath = xfile!.path;
                                          setState(() {
                                            imgFile = File(imagePath);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 25,
                                          color: Colors.blue,
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () async {
                                          final XFile? xfile =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);

                                          String imagePath = xfile!.path;
                                          setState(() {
                                            imgFile = File(imagePath);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.image,
                                          size: 25,
                                          color: Colors.blue,
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Step(
              state:
                  (initialIndex == 1) ? StepState.editing : StepState.indexed,
              title: Text("Enyter your Details"),
              isActive: (initialIndex == 1) ? true : false,
              content: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter first name first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      firstName = val!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter First name here..."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Last name first...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      lastName = val!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter last name here..."),
                  ),
                ],
              ),
            ),
            Step(
              state:
                  (initialIndex == 2) ? StepState.editing : StepState.indexed,
              title: Text("Enter Your Contact Info"),
              isActive: (initialIndex == 2) ? true : false,
              content: TextFormField(
                controller: phonenumberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Phone Number first...";
                  } else if (val!.length != 10) {
                    return "Enter 10 digit phone no..";
                  }
                  return null;
                },
                onSaved: (val) {
                  phoneNumber = val!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Phone number here..."),
              ),
            ),
            Step(
              state:
                  (initialIndex == 3) ? StepState.editing : StepState.indexed,
              title: Text("Enter Your Email"),
              isActive: (initialIndex == 3) ? true : false,
              content: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Email first...";
                  }
                  return null;
                },
                onSaved: (val) {
                  email = val!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Email here..."),
              ),
            ),
          ],

          // controlsBuilder: (context, controlObject) {
          //   return Column(
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: Text(
          //           "Next",
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: Text(
          //           "Cancle",
          //         ),
          //       ),
          //     ],
          //   );
          // },
        ),
      ),
    );
  }
}
