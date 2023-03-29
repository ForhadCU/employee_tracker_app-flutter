import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hicogoapp/Screens/dashboard.dart';
import '../Constants/const.color.dart';
import '../Constants/const.name.dart';

class TeamCheckScreen extends StatefulWidget {
  final uid;
  const TeamCheckScreen({Key? key, required this.uid}) : super(key: key);
  @override
  _TeamCheckScreenState createState() => _TeamCheckScreenState();
}

class _TeamCheckScreenState extends State<TeamCheckScreen>
    with TickerProviderStateMixin {
  //JT : Join Team
  //CT : Create Team
  late double scrHeight;
  late double scrWidth;
  late AnimationController _animationCtrlJT; //Controller of Join Team
  late AnimationController _animationCtrlCT; //Controller of Create Team
  late Animation<double> _animationHeightJT;
  late Animation<double> _animationHeightCT;
  late Animation<double> _animationWidthJT;
  late Animation<double> _animationWidthCT;
  late Animation<double> _animationCurveJT;
  late Animation<double> _animationCurveCT;
  late Animation _animationColorJT;
  late Animation _animationColorCT;
  late bool isJTExpand = false;
  late bool isCTExpand = false;
  late bool isCheckBtnLoading = false;
  late FirebaseAuth mAuth;
  @override
  void initState() {
    print(ConstPrintColor.printMagenta + widget.uid + ConstPrintColor.endColor);
    scrHeight = WidgetsBinding.instance!.window.physicalSize.height /
        2; //same as MediaQuery.of(context).size.height
    scrWidth = WidgetsBinding.instance!.window.physicalSize.width /
        2; //same as MediaQuery.of(context).size.width

//for Join Team Container
    _animationCtrlJT = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationCurveJT =
        CurvedAnimation(parent: _animationCtrlJT, curve: Curves.easeInOutSine);
    // CurvedAnimation(parent: _animationCtrlJT, curve: Curves.easeInToLinear);

    _animationColorJT = ColorTween(begin: MyColors.jtBtn, end: Colors.white)
        .animate(_animationCurveJT);
    _animationHeightJT =
        Tween<double>(begin: scrHeight * 0.05, end: scrHeight * 0.3)
            .animate(_animationCurveJT);
    _animationWidthJT =
        Tween<double>(begin: scrWidth * 0.3, end: scrWidth * 0.9)
            .animate(_animationCurveJT);

    _animationCtrlJT.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //this is true when Animation do forward.
        setState(() {
          isJTExpand = true;
          // _animationCtrlCT.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        //this is true when Animation do reversed.
        setState(() {
          isJTExpand = false;
          isCheckBtnLoading = false;
        });
      }
    });

    //for Create Team Container
    _animationCtrlCT = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationCurveCT =
        CurvedAnimation(parent: _animationCtrlCT, curve: Curves.easeInOutSine);

    _animationColorCT = ColorTween(begin: MyColors.ctBtn, end: Colors.white)
        .animate(_animationCurveCT);
    _animationHeightCT =
        Tween<double>(begin: scrHeight * 0.05, end: scrHeight * 0.4)
            .animate(_animationCurveCT);
    _animationWidthCT =
        Tween<double>(begin: scrWidth * 0.3, end: scrWidth * 0.9)
            .animate(_animationCurveCT);

    _animationCtrlCT.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isCTExpand = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isCTExpand = false;
          isCheckBtnLoading = false;
        });
      }
    });

    super.initState();
  }

/*   String mGetUid()
  {
    final FirebaseAuth
  } */

  @override
  void dispose() {
    _animationCtrlJT.dispose();
    _animationCtrlCT.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Join Team
                AnimatedBuilder(
                  animation: _animationCtrlJT,
                  builder: (context, _) {
                    return InkWell(
                      onTap: () {
                        _animationCtrlCT.reverse();
                        isJTExpand
                            ? _animationCtrlJT.reverse()
                            : _animationCtrlJT.forward();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              isCTExpand
                                  ? BoxShadow()
                                  : const BoxShadow(
                                      color: Color(0x88000000),
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                      spreadRadius: 0)
                            ],
                            color: _animationColorJT.value,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            )),
                        height: _animationHeightJT.value,
                        width: _animationWidthJT.value,
                        child: !isJTExpand
                            ? const Text(
                                "Join Team",
                                style: TextStyle(color: Colors.white),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        // color: Colors.amber,
                                        child: const Text(
                                          "Join Team",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(top: 8),
                                        // color: Colors.blue,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            suffixIcon:
                                            null
                                            /* IconButton(
                                                onPressed: () {},
                                                icon:  Image(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5),
                                                    image: AssetImage(
                                                        'lib/assets/images/ic_cross.png'))) */,
                                            border: const OutlineInputBorder(),
                                            hintText: 'Search Team Name Here..',
                                            hintStyle: const TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(top: 5),
                                        // color: Colors.orange,
                                        child: !isCheckBtnLoading
                                            ? ElevatedButton(
                                                onPressed: () async {
                                                  /* await FirebaseAuth.instance
                                                      .signOut(); */
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardScreeen()));
                                                  setState(() {
                                                    isCheckBtnLoading = true;
                                                  });
                                                },
                                                child: const Text('Check'),
                                                style: /*  ButtonStyle(
                                              elevation: MaterialStateProperty.all(4),
                                              shape: MaterialStateProperty.all(),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(scrWidth * 0.5, 0)),
                                            ), */
                                                    ElevatedButton.styleFrom(
                                                        fixedSize: Size(
                                                            scrWidth * 0.5,
                                                            0.0),
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24))))
                                            : RefreshProgressIndicator(),
                                      )),
                                  /*  Flexible(
                                  flex: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 70, 42, 1),
                                  )), */
                                ],
                              ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 48,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "- OR -",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      )),
                ),

                //Create Team
                AnimatedBuilder(
                  animation: _animationCtrlCT,
                  builder: (context, _) {
                    return InkWell(
                      onTap: () {
                        _animationCtrlJT.reverse();
                        isCTExpand
                            ? _animationCtrlCT.reverse()
                            : _animationCtrlCT.forward();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              isJTExpand
                                  ? BoxShadow()
                                  : const BoxShadow(
                                      color: Color(0x77000000),
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                      spreadRadius: 0)
                            ],
                            color: _animationColorCT.value,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            )),
                        height: _animationHeightCT.value,
                        width: _animationWidthCT.value,
                        child: !isCTExpand
                            ? const Text("Create Team")
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        // color: Colors.amber,
                                        child: const Text(
                                          "Create Team",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(top: 8),
                                        // color: Colors.blue,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            label: Text('Team Name'),
                                            isDense: true,
                                            /* contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                right: 5,
                                                left: 8), */
                                            suffixIcon:
                                            null
                                            /* IconButton(
                                                onPressed: () {},
                                                icon: const Image(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5),
                                                    image: AssetImage(
                                                        'lib/assets/images/ic_cross.png'))) */,
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            /*  hintText: 'Team Name',
                                        hintStyle: const TextStyle(
                                            fontStyle: FontStyle.italic), */
                                          ),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(top: 8),
                                        // color: Colors.blue,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            label: Text('Team ID'),
                                            isDense: true,
                                            /* contentPadding: EdgeInsets.only(
                                                top: 8,
                                                left: 8,
                                                bottom: 8,
                                                right: 5), */
                                            suffixIcon:
                                            null
                                            /* IconButton(
                                                onPressed: () {},
                                                icon: const Image(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5),
                                                    image: AssetImage(
                                                        'lib/assets/images/ic_cross.png'))) */,
                                            border: const OutlineInputBorder(),
                                            /* hintText: 'Team ID',
                                        hintStyle: const TextStyle(
                                            fontStyle: FontStyle.italic), */
                                          ),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(top: 5),
                                        // color: Colors.orange,
                                        child: !isCheckBtnLoading
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isCheckBtnLoading = true;
                                                  });
                                                },
                                                child: const Text('Create'),
                                                style: /*  ButtonStyle(
                                              elevation: MaterialStateProperty.all(4),
                                              shape: MaterialStateProperty.all(),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(scrWidth * 0.5, 0)),
                                            ), */
                                                    ElevatedButton.styleFrom(
                                                        fixedSize: Size(
                                                            scrWidth * 0.5,
                                                            0.0),
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24))))
                                            : RefreshProgressIndicator(),
                                      )),
                                  /*  Flexible(
                                  flex: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 70, 42, 1),
                                  )), */
                                ],
                              ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}




