import 'package:flutter/material.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/cmmon/data/models/student_data_model.dart';
import 'package:lms/features/attandence/ui/screens/attendace_screen.dart';
import 'package:lms/features/auth/ui/screens/login_screen.dart';
import 'package:lms/features/comming_soon_screen.dart';
import 'package:lms/features/exam_list/ui/screens/exam_list_screen.dart';
import 'package:lms/features/home/ui/widgets/CustomShapeClipper.dart';
import 'package:lms/features/home/ui/widgets/dashboard_card.dart';
import 'package:lms/features/result/ui/screens/result_screen.dart';
import 'package:lms/features/upcoming_exam/ui/screens/upcoming_exam_screen.dart';

import '../../../../app/utils/app_colors.dart';
// Ensure this path is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const String name = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: Stack(
        children: [
          Positioned(
            child: ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: 200.0,
                color: const Color(0xFF9BD770),
              ),
            ),
          ),
          buildAppbar(),
          Positioned(
            top: 90.0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Full width card
                    buildStudentProfileCard(
                      onTap: () {
                        _showUserDetails(
                            context, AuthController.studentInfo!.data);
                      },
                      studentName: AuthController.studentInfo!.data.studentName,
                      studentPhoto: AuthController.studentInfo!.data.avatar,
                      id: AuthController.studentInfo!.data.id.toString(),
                    ),
                    // GridView for other cards
                    buildDashboardSection(),

                    const SizedBox(height: 16),
                    // const Text(
                    //   'Teacher\'s Material',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),

                    // buildTeacherMaterialSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTeacherMaterialSection() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        DashboardCard(title: 'Teacher Guide', icon: Icons.book, onTap: () {Navigator.pushNamed(context, ComingSoonScreen.name);}),
        DashboardCard(title: 'Lesson Plan', icon: Icons.schedule, onTap: () {Navigator.pushNamed(context, ComingSoonScreen.name);})
      ],
    );
  }

  PreferredSizeWidget buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'LEGENDS CHEMISTRY',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Add your notification logic here
            debugPrint('Notification button pressed');
            Navigator.pushNamed(context, ComingSoonScreen.name);
          },
        ),
      ],
    );
  }

  Widget buildDashboardSection() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        DashboardCard(
            title: 'Academic Plan',
            icon: Icons.menu_book_rounded,
            onTap: () {
              Navigator.pushNamed(context, ComingSoonScreen.name);
            }),
        DashboardCard(
            title: 'Attendance',
            icon: Icons.group,
            onTap: () {
              Navigator.pushNamed(context, AttendanceScreen.name);
            }),
        DashboardCard(
            title: 'Upcoming Exam',
            icon: Icons.edit_note,
            onTap: () {
              Navigator.pushNamed(context, UpcomingExamScreen.name);
            }),
        DashboardCard(
            title: 'Exams',
            icon: Icons.note_alt_outlined,
            onTap: () {
              Navigator.pushNamed(context, ExamListScreen.name);
            }),
        DashboardCard(
            title: 'Result',
            icon: Icons.add_chart,
            onTap: () {
              Navigator.pushNamed(context, ResultScreen.name);
            }),
        DashboardCard(
            title: 'Payment',
            icon: Icons.attach_money_sharp,
            onTap: () {
              Navigator.pushNamed(context, ComingSoonScreen.name);
            }),
        // DashboardCard(
        //     title: 'Gallery',
        //     icon: Icons.image,
        //     onTap: () {
        //       Navigator.pushNamed(context, ComingSoonScreen.name);
        //     }),
        // DashboardCard(
        //     title: 'Time Table',
        //     icon: Icons.timer,
        //     onTap: () {
        //       Navigator.pushNamed(context, ComingSoonScreen.name);
        //     }),
      ],
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.themColor,
            ),
            child: const Text(
              'Menus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {Navigator.pushNamed(context, ComingSoonScreen.name);},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {Navigator.pushNamed(context, ComingSoonScreen.name);},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {Navigator.pushNamed(context, ComingSoonScreen.name);},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await AuthController.logOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.name, (predicate) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget buildStudentProfileCard(
      {required String studentName,
      required String studentPhoto,
      required String id,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(studentPhoto), // Use NetworkImage
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      studentName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Student ID - $id',
                      style: const TextStyle(
                        fontSize: 14,
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

  void _showUserDetails(BuildContext context, StudentDataModel userData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Student Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(userData.avatar),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                Text('Father Name: ${userData.fatherName}'),
                Text('Father Mobile: ${userData.fatherMobile}'),
                Text('Father Profession: ${userData.fatherProfession}'),
                Text('Mother Name: ${userData.motherName}'),
                Text('Mother Mobile: ${userData.motherMobile}'),
                Text('Mother Profession: ${userData.motherProfession}'),
                Text('SMS Mobile: ${userData.smsMobile}'),
                Text('Student ID: ${userData.id}'),
                Text('Email Address: ${userData.emailAddress ?? 'N/A'}'),
              ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Save'),
            //   onPressed: () {
            //     setState(() {});
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
