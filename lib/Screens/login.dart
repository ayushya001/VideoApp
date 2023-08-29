import 'package:assignmentvideo/Providers/AuthProvider.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:assignmentvideo/widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  static String Verify  = "";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController countryController = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final authProvider = Provider.of<Authprovider>(context, listen: false);


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left:mq.width*0.08,right: mq.width*0.08 ),
        child: Container(

          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/i1.png',
                  width: mq.width*0.5,
                  height: mq.height*0.3,
                ),
                SizedBox(
                  height: mq.height*0.02,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mq.height*0.02,
                ),
                Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: mq.height*0.028,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mq.width*0.02,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: mq.width*0.025,

                      ),
                      Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",

                            ),
                            onChanged: (value){
                              phone = value;
                            },
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height*0.026,

                ),
                RoundButton(title: "Send the code", onpress: (
                    ){
                  if(phone.isEmpty){
                    Utils.flushBarErrorMessage("Mobile no cannot be empty", context);

                  }else if(phone.length<10
                  ){
                    Utils.flushBarErrorMessage("Please write correct mobile no", context);
                  }else{
                    authProvider.authPhone(context,countryController.text,phone);


                  }

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

