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
  final UpcomingExamController upcomingExamController =
      Get.find<UpcomingExamController>();

  @override
  void initState() {
    super.initState();
    fetchExamData();
  }

  bool isLoading = false;

  Future<void> fetchExamData() async {
    isLoading = true;
    setState(() {});
    await upcomingExamController.getUpcomingExamData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Exam'),
        backgroundColor: AppColors.themColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: 610, child: buildTableSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTableSection() {
    return Visibility(
      visible: isLoading == false,
      replacement: const Padding(
        padding: EdgeInsets.only(top: 250),
        child: Center(child: CircularProgressIndicator()),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // horizontal scroll enable korbe
        child: SizedBox(
          width: 600,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(5),
            },
            border: TableBorder.all(),
            children: [
              const TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Sl'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Exam name'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Course name'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Date'),
                ),
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Text('Date'),
                // ),
              ]),
              ...upcomingExamController.upcomingExamList
                  .asMap()
                  .entries
                  .map((e) {
                int index = e.key + 1;
                var value = e.value;
                return TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(index.toString()),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(value.name),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(value.course),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(value.date),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text('Date'),
                  // ),
                ]);
              })
            ],
          ),
        ),
      ),
    );
  }
}
