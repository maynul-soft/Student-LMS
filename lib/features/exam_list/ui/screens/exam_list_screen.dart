import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/features/exam_list/ui/contrller/exam_controller.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  static const String name = 'exam-list-screen';

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  final ExamController examController = Get.find<ExamController>();

  final TextEditingController searchBoxTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchExamListData();
  }

  bool isLoading = false;

  Future<void> fetchExamListData() async {
    isLoading = true;
    setState(() {});
    await examController.getExamListData();
    isLoading = false;
    setState(() {});
  }

  subText(String text){
    return text.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEGENDS CHEMISTRY'),
        backgroundColor: AppColors.themColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSearchSecion(width),

              const SizedBox(
                height: 20,
              ),

              const Text('Exam List',
              style: TextStyle(fontSize: 25),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(width: 610, child: buildTableSection()),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSearchSecion(double width) {
    return SizedBox(
              // color: Colors.green.shade50,
              width: width,
              height: 50,
              child: Row(
                children: [
                  SizedBox(
                      width: width - 80,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: searchBoxTEController,
                          onChanged: (value) {
                            examController.onChange(value);
                          },
                          decoration: const InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Search by exam name'),
                        ),
                      )),
                  Container(
                      // padding:  const EdgeInsets.symmetric(vertical:  18, ),
                      margin: const EdgeInsets.only(left: 5),
                      width: width - (width - 70),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {
                            examController
                                .filterData(searchBoxTEController.text);
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ))),
                ],
              ),
            );
  }

  Widget buildTableSection() {
    return GetBuilder<ExamController>(builder: (context) {
      return Visibility(
        visible: isLoading == false,
        replacement: const Padding(
          padding: EdgeInsets.only(top: 250),
          child: Center(child: CircularProgressIndicator()),
        ),
        child: Visibility(
          visible: examController.filteredList.isNotEmpty,
          replacement: const Padding(
            padding: EdgeInsets.only(top: 250),
            child: Center(child: Text('No Data found')),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // horizontal scroll enable korbe
            child: Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
                3: IntrinsicColumnWidth(),
                4: IntrinsicColumnWidth(),
                5: IntrinsicColumnWidth(),
              },
              border: TableBorder.all(),
              children: [
                const TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Sl')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Exam name')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Course')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Duration')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Status')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('syllabus')),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text('Date'),
                  // ),
                ]),
                ...examController.filteredList.asMap().entries.map((e) {
                  int index = e.key + 1;
                  var value = e.value;
                  return TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(index.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.course),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.duration),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.status),
                    ),Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(subText(value.syllabus))
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
    });
    
    
  }
}
