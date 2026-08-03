import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskmanager/core/routes/app_router.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'main.dart';
import 'modules/dashboard/pages/settings_page.dart';

class dash extends StatefulWidget {
  final List<TaskModel> list;

  const dash({super.key, required this.list});

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
  String datetime = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String nepaliDatetime = NepaliDateFormat(
    "yyyy-MM-dd",
  ).format(NepaliDateTime.now());
  final List<Widget> pages = [dash(list: list), settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard", textAlign: TextAlign.center)),
      body: Container(
        width: 402,
        height: 874,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: const Color(0xFFFFF3F3)),
        child: Stack(
          children: [
            Positioned(
              left: 23,
              top: 17,
              child: Text(
                'Date: ' +
                    datetime.toString() +
                    " | " +
                    "Nepali: " +
                    nepaliDatetime.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.60,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 75,
              child: Text(
                'Overview',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.60,
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 108,
              child: Container(
                width: 175,
                height: 111,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push("/example");
                      },
                      child: Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 175,
                          height: 111,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2A92EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 42,
                      child: Text(
                        getit<Box<TaskModel>>().length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 9,
                      child: Text(
                        'Total Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 242,
              child: Container(
                width: 175,
                height: 111,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 175,
                        height: 111,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF50A852),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 19,
                      top: 38,
                      child: Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 14,
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 242,
              child: Container(
                width: 175,
                height: 111,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 175,
                        height: 111,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF663FB4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 38,
                      child: Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 14,
                      child: Text(
                        'In-Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 220,
              top: 108,
              child: Container(
                width: 175,
                height: 111,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 175,
                        height: 111,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFC910F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 19,
                      top: 42,
                      child: Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 9,
                      child: Text(
                        'New Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 395,
              child: Text(
                'Recent Task Images',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 453,
              child: Container(
                width: 116,
                height: 220,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 139,
              top: 453,
              child: Container(
                width: 116,
                height: 220,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 264,
              top: 453,
              child: Container(
                width: 116,
                height: 220,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 389,
              top: 453,
              child: Container(
                width: 116,
                height: 220,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFFFF4F4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: GNav(
            onTabChange: (index) {
              pages[index];
              setState(() {});
            },
            color: Colors.black,
            backgroundColor: Color(0xFFFFF4F4),
            activeColor: Colors.black,
            tabBackgroundColor: Color(0xFFFFD7E1),
            padding: EdgeInsetsGeometry.all(16),
            gap: 8,
            iconSize: 40,
            tabs: [
              GButton(icon: Icons.home, text: "Dashboard"),
              GButton(icon: Icons.settings, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
