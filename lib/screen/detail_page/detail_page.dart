import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core_flutter_final_exam/utils/modal_class.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Detail Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image add
                Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: const Alignment(0.8, 0.9),
                    children: [
                      CircleAvatar(
                        radius: s.height * 0.15,
                        backgroundImage: Global.image != null
                            ? FileImage(Global.image!)
                            : const NetworkImage(
                          "https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg",
                        ) as ImageProvider,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                height: s.height * 0.15,
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xFile = await picker.pickImage(source: ImageSource.camera);
                                        if (xFile != null) {
                                          Global.image = File(xFile.path);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.camera_alt_rounded, size: 30, color: Colors.deepPurple),
                                          SizedBox(width: 10),
                                          Text("Camera", style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
                                        if (xFile != null) {
                                          Global.image = File(xFile.path);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.image_outlined, size: 30, color: Colors.deepPurple),
                                          SizedBox(width: 10),
                                          Text("Gallery", style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.deepPurple,
                        label: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Student Name text
                TextFormField(
                  onChanged: (value) => Global.name = value,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Student Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter Your Name' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),

                // Student GR ID trxt
                TextFormField(
                  onChanged: (value) => Global.gr_id = value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'Student GR ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter Your GRID' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),

                // Student Standard text
                TextFormField(
                  onChanged: (value) => Global.standard = value,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Student Standard',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter Your Standard' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),

                // Save and Reset method
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          studentDetails.add(
                            Modal(
                              name: Global.name,
                              gr_id: Global.gr_id,
                              standard: Global.standard,
                              image: Global.image,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Successfully Student Added",
                                style: TextStyle(fontSize: 18),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              width: 300,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                        Global.name = '';
                        Global.gr_id = '';
                        Global.standard = '';
                        Global.image = null;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Your Form Reset",
                              style: TextStyle(fontSize: 18),
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            width: 300,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
