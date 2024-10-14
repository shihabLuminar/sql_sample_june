import 'package:flutter/material.dart';
import 'package:sql_sample_june/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await HomeScreenController.getAllEmployees();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("heloooo");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _customBottomSheet(context);
        },
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title:
                    Text(HomeScreenController.employeeDataList[index]["name"]),
                subtitle: Text(HomeScreenController.employeeDataList[index]
                    ["designation"]),
                trailing: IconButton(
                    onPressed: () async {
                      await HomeScreenController.removeEmployee(
                          HomeScreenController.employeeDataList[index]["id"]);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete)),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: HomeScreenController.employeeDataList.length),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController desController = TextEditingController();

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: desController,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"))),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          await HomeScreenController.addEmployee(
                              designation: desController.text,
                              name: nameController.text);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text("Save")))
              ],
            )
          ],
        ),
      ),
    );
  }
}
