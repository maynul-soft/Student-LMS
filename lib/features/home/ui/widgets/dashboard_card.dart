import 'package:flutter/material.dart';
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key, required this.title, required this.icon, required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
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
}