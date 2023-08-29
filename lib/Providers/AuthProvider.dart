
import 'dart:io';
import 'package:assignmentvideo/Routes/routes.dart';
import 'package:assignmentvideo/Routes/routesName.dart';
import 'package:assignmentvideo/Screens/Home.dart';
import 'package:assignmentvideo/Screens/Verify.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class Authprovider extends ChangeNotifier {


  bool _loading = false;


  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void authPhone(BuildContext context, String countryCode, var phone) async {
    try {
      setloading(true);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          setloading(false);
          Utils.flushBarErrorMessage("Verification completed", context);
        },
        verificationFailed: (FirebaseAuthException e) {
          setloading(false);
          Utils.flushBarErrorMessage(e.toString(), context);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyVerify(verificationId: verificationId),
            ),
          );
          setloading(false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setloading(false);
          Utils.flushBarErrorMessage("Time out", context);
        },

      );
      // setloading(false);

    } catch (e) {
      setloading(false);
      print("the error is" + e.toString());
    }
  }

  Future<void> Verify(BuildContext context, String verifyid,
      String smsCode) async {
    final auth = FirebaseAuth.instance;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyid, smsCode: smsCode);

    try {
      setloading(true);
      await auth.signInWithCredential(credential);

      print(auth.currentUser!.uid);

      Navigator.push(
        context,
        Routes.generateRoute(RouteSettings(name: RoutesName.DetailsScreen)),
      );
      setloading(false);
    } catch (e) {
      print("the error in verification is:-" + e.toString());
      setloading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  Details(TextEditingController namecontroller , TextEditingController emailcontroller , String imagepath , BuildContext context) async
  {

    String auth  = FirebaseAuth.instance.currentUser!.uid;
    print("the auth is:-"+auth);
    setloading(true);

    if(auth!=null){
      print("Auth is not null and the uid is:-"+auth);

      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg');

      final uploadTask = await storageReference.putFile(File(imagepath))
          .whenComplete(() {});
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      Map<String,dynamic> users = {
        "uid": auth,
        "name" : namecontroller.text.toString(),
        "email" : emailcontroller.text.toString(),
        "image" : downloadUrl,
      };

      await FirebaseFirestore.instance
          .collection("Users").doc(auth)
          .set(users)
          .then((value) {
        Navigator.push(
          context,
          Routes.generateRoute(
              RouteSettings(name: RoutesName.home)),
        );
        setloading(false);
        namecontroller.clear();
        emailcontroller.clear();
        setloading(false);
      });


    }



  }

  CompressVideoFile(String videoFilePath) async  {

    final compressVideoFilePath = await VideoCompress.compressVideo(videoFilePath,quality: VideoQuality.LowQuality);

    return compressVideoFilePath!.file;

  }

  uploadCompressvideoFileToFirebaseStorage(String videoID, String videoFilePath) async
  {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref().child("All Videos")
        .child(videoID).putFile(await CompressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlofUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlofUploadedVideo;


  }

  uploadThumbnailImagetoFirebase(String videoId, String videoFilePath) async {

    UploadTask thumbnailUploadTask  = FirebaseStorage.instance.ref().child("All Thumbnail")
        .child(videoId).putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlofthumbnailImage = await snapshot.ref.getDownloadURL();

    return downloadUrlofthumbnailImage;

  }

  getThumbnailImage(String videoFilePath) async {

    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;
  }

  saveVideInformationToFirebaseDataBase(String title, String location , String videoFilePath , BuildContext context) async{

    try{
      setloading(true);

      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
      .collection("users")
      .doc("uid hai")
      .get();

      String videoId = DateTime.now().millisecondsSinceEpoch.toString();

      //uploadvideotostorage

      String VideoDownloadUrl = await uploadCompressvideoFileToFirebaseStorage(videoId, videoFilePath);

      //2.  upload thumbnail to storge

      String thumbnailDownloadUrl = await uploadThumbnailImagetoFirebase(videoId, videoFilePath);


      Map<String, dynamic> videos = {
        // 'uid': FirebaseAuth.instance.currentUser?.uid,
        'uid': "uid hai ",
        // 'userName': (userDocumentSnapshot.data() as Map<String,dynamic>)['name'],
        // 'userProfilepic': (userDocumentSnapshot.data() as Map<String,dynamic>)['image'],
        'videoId': videoId,
        'title' : title,
        'location':location,
        'videoUrl': VideoDownloadUrl,
        'thumbnailUrl': thumbnailDownloadUrl,
        'PublishDateandtime': DateTime.now().millisecondsSinceEpoch,
      };

      await FirebaseFirestore.instance.collection("Videos").doc(videoId).set(videos);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen())
      );
      setloading(false);

    }catch(e){
      setloading(false);
      print("the exception in not uploading the file is:-"+e.toString());
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
