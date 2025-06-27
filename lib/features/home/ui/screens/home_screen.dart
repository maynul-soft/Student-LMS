import 'package:flutter/material.dart';
import 'package:lms/features/gallery/ui/screens/gallery_screen.dart';
import 'package:lms/features/auth/ui/screens/login_screen.dart';
import 'package:lms/features/home/ui/widgets/CustomShapeClipper.dart';

import '../../../../app/utils/app_colors.dart';
import '../../../syllabus/ui/screens/syllabus_screen.dart'; // Ensure this path is correct

class HomeScreen extends StatefulWidget {


  const HomeScreen({
    Key? key,
  }) : super(key: key);


  static const String name = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
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
          Positioned(
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'DASHBOARD',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Add your notification logic here
                    print('Notification button pressed');
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 90.0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Full width card
                GestureDetector(
                  onTap: () {
                    // _showUserDetails(context, userData);
                  },
                  // child: _buildDashboardCardAvatar(
                  //   // userData['student_name'],
                  //   // userData['avatar'],
                  //   // userData,
                  // ),
                ),
                // GridView for other cards
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(context, 'Academic Plan',
                        Icons.menu_book_rounded, const SyllabusScreen()),
                    _buildDashboardCard(
                        context, 'Attendance', Icons.group, null),
                    _buildDashboardCard(
                        context, 'Home Work', Icons.assignment, null),
                    _buildDashboardCard(
                        context, 'Result', Icons.add_task, null),
                    _buildDashboardCard(
                        context, 'Notice', Icons.notifications, null),
                    _buildDashboardCard(
                        context, 'Payment', Icons.attach_money_sharp, null),
                    _buildDashboardCard(
                        context, 'Gallery', Icons.image, const GalleryScreen()),
                    _buildDashboardCard(
                        context, 'Time Table', Icons.timer, null),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Teacher\'s Material',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(
                        context, 'Teacher Guide', Icons.book, null),
                    _buildDashboardCard(
                        context, 'Lesson Plan', Icons.schedule, null),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCardAvatar(
      String studentName, String studentPhoto, Map<String, dynamic> userData) {
    return Card(
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
                backgroundImage: NetworkImage(studentPhoto), // Use NetworkImage
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
                    'Student ID - ${userData['id']}',
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
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon,
      Widget? destinationPage) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          if (destinationPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFD8DBF2), // Background color of the icon container
                  borderRadius: BorderRadius.circular(
                      50), // Rounded corners for the icon container
                ),
                padding: const EdgeInsets.all(18.0), // Padding around the icon
                child: Icon(
                  icon,
                  size: 40,
                  color: const Color(0xFF2846CA),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context, Map<String, dynamic> userData) {
    TextEditingController nameController =
        TextEditingController(text: userData['student_name']);
    TextEditingController avatarController =
        TextEditingController(text: userData['avatar']);

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
                  backgroundImage: NetworkImage(userData['avatar']),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: avatarController,
                  decoration: const InputDecoration(labelText: 'Avatar URL'),
                ),
                const SizedBox(height: 16),
                Text('Father Name: ${userData['father_name']}'),
                Text('Father Mobile: ${userData['father_mobile']}'),
                Text('Father Profession: ${userData['father_profession']}'),
                Text('Mother Name: ${userData['mother_name']}'),
                Text('Mother Mobile: ${userData['mother_mobile']}'),
                Text('Mother Profession: ${userData['mother_profession']}'),
                Text('SMS Mobile: ${userData['sms_mobile']}'),
                Text('Student ID: ${userData['id']}'),
                Text('Email Address: ${userData['email_address'] ?? 'N/A'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  userData['student_name'] = nameController.text;
                  userData['avatar'] = avatarController.text;
                });
                Navigator.of(context).pop();
              },
            ),
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
