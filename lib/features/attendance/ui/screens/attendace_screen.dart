import 'package:flutter/material.dart';
import 'package:lms/app/constants/app_text.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:get/get.dart';

import '../../controller/attendance_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  static const String name = 'Attendance-screen';

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceController attendanceController = Get.find<AttendanceController>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAttendanceData();
  }

  getAttendanceData() async {
    isLoading = true;
    setState(() {});
    await attendanceController.attendanceService();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.themColor,
          title: const Text(
            AppTexts.legendsBanglaCapital,
            style: TextStyle(fontSize: 25, color: Colors.black),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            buildFilterSection(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Attendance Report',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Text(
                '${attendanceController.startDate} to ${attendanceController.endDate}',
                style: const TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(
              height: 10,
            ),
            Visibility(
                visible: isLoading == false,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  ),
                ),
                child: buildTableSection())
          ],
        ),
      )),
    );
  }

  Widget buildFilterSection() {
    return GetBuilder<AttendanceController>(builder: (controller) {
      return Row(
        children: [
          // Start Date Card
          buildPikcDateCard(
              ontap: () async {
                await attendanceController.pickDate(isStartDate: true);
              },
              color: Colors.blue.shade50,
              title: attendanceController.startDate.toString(),
              iconColor: Colors.blue),

          // End Date Card

          buildPikcDateCard(
              ontap: () async {
                await attendanceController.pickDate(isStartDate: false);
              },
              color: Colors.red.shade50,
              title: attendanceController.endDate.toString(),
              iconColor: Colors.red),

          // Search Button Card
          SizedBox(
            width: 60,
            child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  getAttendanceData();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 32,
                )),
          ),
        ],
      );
    });
  }

  Widget buildPikcDateCard(
      {required VoidCallback ontap,
      required Color color,
      required Color iconColor,
      required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          color: color,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: iconColor),
               const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Table buildTableSection() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.7),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        // 3: FlexColumnWidth(1),
      },
      border: TableBorder.all(),
      children: [
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(child: Text('Sl')),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(child: Text('Date')),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(child: Text('Status')),
          ),
          // Padding(
          //   padding: EdgeInsets.all(5),
          //   child: Center(child: Text('remark')),
          // ),
        ]),
        ...attendanceController.attendances.asMap().entries.map((e) {
          int index = e.key;
          var value = e.value;
          return TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text('${index + 1}')),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(child: Text(value.date)),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: Text(
                value.attendance,
                style: TextStyle(
                    color: value.attendance != 'Present'
                        ? Colors.red
                        : Colors.black),
              )),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(5),
            //   child: Center(
            //       child: value.attendance != 'Present'
            //           ? CircleAvatar(
            //               radius: 5,
            //               backgroundColor: Colors.red,
            //             )
            //           : Text('')),
            // ),
          ]);
        })
      ],
    );
  }
}
