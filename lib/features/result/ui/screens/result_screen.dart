import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/constants/app_text.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/features/result/ui/contrller/result_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  static const String name = 'result-screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ResultController resultContrller = Get.find<ResultController>();

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
    await resultContrller.getResultListData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.legendsBanglaCapital),
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
                height: 5,
              ),

              const Text('Exam Results',style: TextStyle(fontSize: 25),),

              const SizedBox(
                height: 10,
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
                            resultContrller.onChange(value);
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
                            resultContrller
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
    return GetBuilder<ResultController>(builder: (context) {
      return Visibility(
        visible: isLoading == false,
        replacement: const Padding(
          padding: EdgeInsets.only(top: 250),
          child: Center(child: CircularProgressIndicator()),
        ),
        child: Visibility(
          visible: resultContrller.filteredList.isNotEmpty,
          replacement: const Padding(
            padding: EdgeInsets.only(top: 250),
            child: Center(child: Text(AppTexts.noDataFound)),
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
                6: IntrinsicColumnWidth(),
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
                    child: Center(child: Text('Paper mark')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Total mark')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Obtained mark')),
                  ),Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Average')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('Grade',style: TextStyle(color: Colors.black),),),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text('Date'),
                  // ),
                ]),
                ...resultContrller.filteredList.asMap().entries.map((e) {
                  int index = e.key + 1;
                  var value = e.value;
                  return TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(child: Text(index.toString())),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.examName),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(value.paperMark),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(child: Text(value.totalMark.toString())),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(child: Text(value.obtainedMark.toString())),
                    ),Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(child: Text(value.average.toString())),
                    ),Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox( height: 40 ,child: Center(child: Text(value.grade,style: const TextStyle(color:  Colors.black),))),
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
