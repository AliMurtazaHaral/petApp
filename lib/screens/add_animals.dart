import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../models/AnimalModel.dart';
import '../models/storage.dart';
import 'QR screens/qr_create.dart';

class Add_AnimalsScreen extends StatefulWidget {
  const Add_AnimalsScreen({Key? key}) : super(key: key);

  initState() {}

  State<Add_AnimalsScreen> createState() => _Add_AnimalsScreenState();
}

class _Add_AnimalsScreenState extends State<Add_AnimalsScreen> {
  bool checker = false;
  AudioPlayer animal_sound = AudioPlayer();
  File? selectedImage;

  StorageModel storage = new StorageModel();
  Future<bool> qr_id_Exists(id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("qr_details")
        .where('animal_id', isEqualTo: id)
        .get()
        .then((value) => value.size > 0 ? true : false);
  }

  final animal_id_controller = TextEditingController();
  final animal_name_controller = TextEditingController();
  final animal_habitat_controller = TextEditingController();
  final animal_fact_controller = TextEditingController();
  String? animal_audio;
  String? animal_image;

  String? animal_audio_shower = "No audio";
  String? animal_image_shower = "No image";

  Future pickImage(ImageSource source) async {
    final pickedImage = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      // allowedExtensions: ['mp3' , 'm4a']
    );
    if (pickedImage == null) {
      if (animal_image_shower! == "No image") {
        Fluttertoast.showToast(msg: "No image selected");
      }
    } else {
      animal_image = pickedImage?.files.single.path;
      animal_image_shower = animal_image?.split("/").last;
    }
    setState(() {});
  }

  Future pickAudio() async {
    final pickedaudio = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.audio,
      // allowedExtensions: ['mp3' , 'm4a']
    );
    if (pickedaudio == null) {
      if (animal_audio_shower == "No audio") {
        Fluttertoast.showToast(msg: "No audio selected");
      }
    } else {
      animal_audio = pickedaudio?.files.single.path;
      animal_audio_shower = animal_audio?.split("/").last;
    }
    setState(() {});
  }

  postAnimalDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QRModel animalsModel = QRModel();

    // writing all the values

    animalsModel.animal_name = animal_name_controller.text;
    animalsModel.animal_id = animal_id_controller.text;
    animalsModel.animal_habitat = animal_habitat_controller.text;
    animalsModel.animal_fact = animal_fact_controller.text;
    animalsModel.animal_sound = animal_audio_shower;
    //animalsModel.animal_image = animal_image_shower;

    await firebaseFirestore
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("qr_details")
        .doc()
        .set(animalsModel.toMapAnimalsDetails());
    //Fluttertoast.showToast(msg: "Animal details Successfully added");
  }

  @override
  Widget build(BuildContext context) =>
    checker? Loading_Page(): Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gradient.jpg"),
          opacity: 1,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
            child: Text(
              "Add Animal Details",
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          backgroundColor: Colors.teal[800],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                EnterText.textfield(context, animal_id_controller, "Enter ID" , 1),
                EnterText.textfield(
                    context, animal_name_controller, "Enter Name", 1),
                EnterText.textfield(
                    context, animal_habitat_controller, "Enter Habitat", 1),
                EnterText.textfield(
                    context, animal_fact_controller, "Enter Fun Facts", 3),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white)),
                  elevation: 5,
                  color: Colors.transparent,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    onPressed: () async {
                      pickAudio();
                    },
                    child: Text(
                      "Add Sound",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(animal_audio_shower!),
                SizedBox(height: 15.0),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white)),
                  elevation: 5,
                  color: Colors.transparent,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    onPressed: () async {
                      pickImage(ImageSource.gallery);
                    },
                    child: Text(
                      "Add Image",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(animal_image_shower!),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white)),
                  elevation: 5,
                  color: Colors.teal.shade800,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    onPressed: () async {
                      if (animal_image_shower == "None" ||
                          animal_audio_shower == "None" ||
                          animal_id_controller.text.isEmpty ||
                          animal_name_controller.text.isEmpty ||
                          animal_habitat_controller.text.isEmpty ||
                          animal_fact_controller.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please add all the details");
                      } else {
                        checker = true;
                        setState(() {

                        });
                        bool qr_check =
                            await qr_id_Exists(animal_id_controller.text);
                        if (qr_check == true) {
                          checker = false;
                          setState(() {

                          });
                          Fluttertoast.showToast(
                              msg: "Qr with this id already exists");
                        } else {
                          StorageModel animal_details = StorageModel();
                          await animal_details.uploadFile(
                              animal_image, animal_image_shower , "qrdetails");
                          await animal_details.uploadFile(
                              animal_audio, animal_audio_shower , "qrdetails");
                          await postAnimalDetailsToFirestore();
                          String id = animal_id_controller.text;
                          checker = false;
                          setState(() {

                          });
                          Fluttertoast.showToast(msg: "Details added");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateQrPage(
                                  animal_id: id),
                            ),
                          );
                        }
                      }

                      animal_name_controller.text = "";
                      animal_id_controller.text = "";
                      animal_habitat_controller.text = "";
                      animal_fact_controller.text = "";
                      animal_image_shower = "None";
                      animal_audio_shower = "None";
                      setState(() {});
                    },
                    child: Text(
                      "Add Details",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

}
// width: MediaQuery.of(context).size.width * 0.5,

class EnterText {
  static Widget textfield(
      BuildContext context, TextEditingController controller, String hint , int lines) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        child: TextFormField(
          maxLines: lines,
          style: TextStyle(color: Colors.teal.shade800),
          keyboardType: TextInputType.text,
          //Text field data is stored in emailController
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Enter Valid Credentials");
            }
          },
          onSaved: (value) {
            controller.text = value!;
          },
          decoration: InputDecoration(
            fillColor: Colors.teal.shade800,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: false,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade800, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

// Future<bool> userExists(name) async {
//   return await FirebaseFirestore.instance.collection("users")
//       .doc("LQ0PFtnsaxXU1c4tY0ZM")
//       .collection("Animals")
//       .where('name'.toString().toLowerCase(), isEqualTo: name.toString().toLowerCase())
//       .get()
//       .then((value) => value.size > 0 ? true : false);
// }
//String myString = "HELLO WORLD!"; myString = myString.toLowerCase(); myString = myString.replaceAll(RegExp(r'\W+'), ''); print(myString); //prints 'helloworld'
