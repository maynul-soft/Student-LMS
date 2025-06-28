import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/features/upcoming_exam/ui/contrller/upcoming_exam_controller.dart';

class UpcomingExamScreen extends StatefulWidget {
  const UpcomingExamScreen({super.key});

  static const String name = 'upcoming-screen';

  @override
  State<UpcomingExamScreen> createState() => _UpcomingExamScreenState();
}

class _UpcomingExamScreenState extends State<UpcomingExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Exam'),
        backgroundColor: AppColors.themColor,
      ),
      body: Column(

        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,  // horizontal scroll enable korbe
            child:  SizedBox(
              width: 600,
              child: Expanded(
                child:  Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(5),
                    2: FlexColumnWidth(5),
                    3: FlexColumnWidth(5),
                    4: FlexColumnWidth(5),
                  },
                  border: TableBorder.all(),
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Sl'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Exam Name'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Course Name'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Date'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Date'),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.find<UpcomingExamController>().getUpcomingExamData();
            },
            child: Text('press'),
          ),
        ],
      ),
    );

  }
}
