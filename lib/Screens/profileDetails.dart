import 'dart:io';

import 'package:assignmentvideo/Providers/AuthProvider.dart';
import 'package:assignmentvideo/Providers/imageProvider.dart';
import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:assignmentvideo/widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _Firstname = TextEditingController();
  TextEditingController _email = TextEditingController();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<Authprovider>(context,listen: false);
    final imageprovider = Provider.of<ImageProviderClass>(context,listen: false);


    print("whole rebuilt");
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,
                        right: MediaQuery.of(context).size.width*0.1),
                    child: Text("Skip",style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),
                  ),

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12),
                    child: Text("Profile details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                        color: Colors.black,

                      ),),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Center(
                  child: Stack(
                    children: [
                      Consumer<ImageProviderClass>(
                        builder: (context, imageProvider, child) {
                          return CircleAvatar(
                            radius: 100,
                            backgroundImage:imageprovider.imagePath.isNotEmpty
                                ? FileImage(File(imageProvider.imagePath))
                                : AssetImage("assets/images/male.jpg") as ImageProvider,
                          );
                        },
                      ),

                      Positioned(
                          bottom: 3,
                          right: 20,
                          child: InkWell(
                            onTap: () async {
                              final imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

                              if(imagefile !=null){
                                Provider.of<ImageProviderClass>(context, listen: false)
                                    .setImagePath(imagefile.path);

                                print("only image picker");
                              }


                            },
                            child: Container(
                              height: 40,
                              width: 40,

                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 38,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))
                    ],

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    controller: _Firstname,
                    keyboardType: TextInputType.text,
                    focusNode: firstnameFocusNode,
                    decoration: InputDecoration(
                      hintText: "Enter your First name",
                      // hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "First name",
                      labelStyle: TextStyle(color: Colors.green.shade600),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: ComponentsColor.borderColorTextformfield)
                      ),
                      prefixIcon: Icon(Icons.person,
                      color: Colors.green.shade600,),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black), // Color when the TextFormField is in focus
                      ),

                    ),
                    onFieldSubmitted: (val){
                      Utils.fieldFocusChange(context, firstnameFocusNode, lastnameFocusNode);
                    },

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(

                    controller: _email,
                    keyboardType: TextInputType.text,

                    focusNode: lastnameFocusNode,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      // hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.green.shade600),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: ComponentsColor.borderColorTextformfield)
                      ),
                      prefixIcon: Icon(Icons.email,
                      color: Colors.green.shade600,),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black), // Color when the TextFormField is in focus
                      ),

                    ),

                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                RoundButton(title: "Confirm", onpress: () {
                  if (_Firstname.text.isEmpty) {
                    Utils.flushBarErrorMessage("First name Cannot be empty", context);
                  } else if (_email.text.isEmpty) {
                    Utils.flushBarErrorMessage("email cannot be empty", context);
                  }
                  else if (!isValidEmail(_email.text)) {
                    Utils.flushBarErrorMessage("Invalid email format", context);
                  }
                  else if (imageprovider.imagePath.isEmpty) {
                    Utils.flushBarErrorMessage("Please set your profile photo", context);
                  }
                  else {
                    authprovider.Details(_Firstname, _email, imageprovider.imagePath, context);
                    // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.ChooseGender)));
                    print("api hit");
                  }
                }),





              ],
            ),
          ),
        )
    );
  }
  bool isValidEmail(String email) {
    // Define a regular expression pattern for a basic email format
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return emailRegExp.hasMatch(email);
  }
}