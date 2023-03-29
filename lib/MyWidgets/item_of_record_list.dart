import 'package:flutter/material.dart';
import 'package:hicogoapp/Models/record_list.dart';
import 'package:hicogoapp/Utils/screen_size.dart';

//temporary testing
/* void main() {
  runApp(MaterialApp(
      home: Scaffold(
    body: ItemOfRecordsWidget(
      item: RecordsModel.items[0],
    ),
  )));
} */

class ItemOfRecordsWidget extends StatelessWidget {
  final Item item;

  ItemOfRecordsWidget({Key? key, required this.item}) : super(key: key);

  String startTime = "3.24 PM";
  // String endTime = "4.24 PM";
  String endTime = "null";
  String duration = "01:03:45";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      width: MyScreenSize.mGetWidth(context: context, percentage: 70),
      height: MyScreenSize.mGetHeight(context: context, percentage: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: MyScreenSize.mGetWidth(context: context, percentage: 23),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.play_arrow,
                color: Color(0xffA9A9A9),
              ),
              SizedBox(
                height: 5,
              ),
              Text("${item.startTime}")
            ]),
          ),
          Container(
            width: MyScreenSize.mGetWidth(context: context, percentage: 23),
            child: item.endTime != "null"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.pause,
                          color: Color(0xffA9A9A9),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${item.endTime}")
                      ])
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 2),
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 1)
                              ],
                              color: Color.fromRGBO(243, 102, 59, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(14, 14))),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Positioned(child: Text("IN"))
                      ]),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Color.fromRGBO(186, 216, 206, 1),
            ),
            width: MyScreenSize.mGetWidth(context: context, percentage: 25.5),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  child: Icon(
                Icons.timer,
                color: Color(0xff999999),
              )),
              SizedBox(
                height: 5,
              ),
              Text("${item.duration}")
            ]),
          ),
        ],
      ),
    );
  }
}
