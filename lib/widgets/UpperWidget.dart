import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:flutter/material.dart';

class UpperWidget extends StatelessWidget {
  const UpperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * 0.2,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ComponentsColor.borderColorTextformfield, // Change to the desired border color
              width: 2,
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: mq.width * 0.02, right: mq.width * 0.02),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(

                    height: mq.height * 0.1,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: mq.width * 0.008),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28,
                            child: Icon(
                              Icons.account_balance,
                              color: Colors.black,
                              size: 42,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: mq.width * 0.01),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.black,
                              size: 42,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: mq.width * 0.06, right: mq.width * 0.06),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: ComponentsColor.borderColorTextformfield),
                      // Remove the default border
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.search,
                      size: 36,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
