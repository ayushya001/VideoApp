import 'dart:io';


import 'package:assignmentvideo/Providers/AuthProvider.dart';
import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:assignmentvideo/widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class uploadform extends StatefulWidget {

  final File videoFile;
  final String videoPath;


  const uploadform({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  State<uploadform> createState() => _uploadformState();
}

class _uploadformState extends State<uploadform> {

  late VideoPlayerController _playerController;

  late String title;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _playerController = VideoPlayerController.file(widget.videoFile);

    // Initialize the controller asynchronously
    _playerController!.initialize().then((_) {
      // Once the controller is initialized, play the video
      _playerController!.play();
      _playerController!.setVolume(2);
      _playerController!.setLooping(true);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _playerController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final authProvider = Provider.of<Authprovider>(context, listen: false);

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: mq.width,
                height: mq.height*0.6,
                child: VideoPlayer(_playerController!),
              ),
              Container(
                height: mq.height*0.1,
                child: Row(
                  children: [
                    Icon(Icons.pin_drop),
                    SizedBox(width: mq.width*0.03,),
                    Text("Khagaria")
                  ],
                ),
              ),
              TextFormField(
                controller: _textEditingController,
                textAlign: TextAlign.start,
                onChanged: (value){
                  title = _textEditingController.text.toString();

                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ComponentsColor.borderColorTextformfield),
                    // Remove the default border
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your titile',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.title,
                    size: 36,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: mq.height*0.05),
                child: RoundButton(title: "Upload", onpress: (){
                  Utils.flushBarErrorMessage(title, context);
                  authProvider.saveVideInformationToFirebaseDataBase(title,"khagaria", widget.videoPath, context);
                  _playerController.dispose();

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
