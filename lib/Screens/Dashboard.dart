import 'package:flutter/material.dart';
import 'package:lms/Reuseable/CustomShapeClipper.dart';
import 'package:lms/Screens/MainPage.dart';
import 'package:lms/Screens/syllabus_page.dart';

class DashboardPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const DashboardPage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF9BD770),
              ),
              child: Text(
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
                  MaterialPageRoute(builder: (context) => const MainPage()),
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
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      _showUserDetails(context, userData);
                    },
                    child: _buildDashboardCardAvatar(
                      userData['student_name'],
                      userData['avatar'],
                      userData,
                    ),
                  ),
                ),
                // GridView for other cards
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildDashboardCard(context, 'Syllabus', Icons.book_rounded,
                        const SyllabusPage()),
                    _buildDashboardCard(
                        context, 'Attendance', Icons.punch_clock_rounded, null),
                    _buildDashboardCard(
                        context, 'Home Work', Icons.assignment, null),
                    _buildDashboardCard(
                        context, 'Result', Icons.restore_outlined, null),
                    _buildDashboardCard(
                        context, 'Notice', Icons.notifications, null),
                    _buildDashboardCard(
                        context, 'Library', Icons.library_books, null),
                    _buildDashboardCard(context, 'Gallery', Icons.image, null),
                    _buildDashboardCard(
                        context, 'Time Table', Icons.table_chart, null),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Teachers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80, // Adjust the height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      20,
                      (index) =>
                          _buildTeacherAvatar('assets/images/images.png'),
                    ),
                  ),
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
                    'School ID - ${userData['school_id']}',
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

  Widget _buildTeacherAvatar(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }

  void _showUserDetails(BuildContext context, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userData['avatar']),
                ),
                const SizedBox(height: 16),
                Text('Name: ${userData['student_name']}'),
                Text('Father Name: ${userData['father_name']}'),
                Text('Father Mobile: ${userData['father_mobile']}'),
                Text('Father Profession: ${userData['father_profession']}'),
                Text('Mother Name: ${userData['mother_name']}'),
                Text('Mother Mobile: ${userData['mother_mobile']}'),
                Text('Mother Profession: ${userData['mother_profession']}'),
                Text('SMS Mobile: ${userData['sms_mobile']}'),
                Text('School ID: ${userData['school_id']}'),
                Text('Email Address: ${userData['email_address'] ?? 'N/A'}'),
              ],
            ),
          ),
          actions: <Widget>[
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
