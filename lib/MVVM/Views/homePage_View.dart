// ignore_for_file: file_names
import 'package:bookingcars/MVVM/View%20Model/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Responsive/UiComponanets/InfoWidget.dart';
import '../../widgets/myDrawer.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch car data when the widget is first built
      Provider.of<TaskViewModel>(context, listen: false)
          .fetchTasks();
    });
  }
  Widget buildHeader() {
    return Infowidget(builder: (context, deviceInfo) {
      return Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: deviceInfo.screenWidth * 0.05,
                      top: deviceInfo.screenHeight * 0.03),
                  child: Text(
                    "Tasks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: deviceInfo.screenWidth * 0.07,
                    ),
                  )),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: deviceInfo.screenWidth * 0.05,
                    top: deviceInfo.screenHeight * 0.03),
                child: Container(
                  height: deviceInfo.screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/add_task");
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Add Task",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ),
              ),
            ],
          )
        ],
      );
    });
  }

  Widget buildTask(title, description, trailing) {
    return Infowidget(builder: (
      context,
      deviceInfo,
    ) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.02,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Card(
            elevation: 8,
            color: Colors.blue[400],
            child: ListTile(
              title: Text(
                title ?? "no title",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                description ?? "no description",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7), fontSize: 15),
              ),
              trailing: Text(trailing.toString(),style: const TextStyle(color: Colors.white,fontSize: 14),),
            ),
          ),
        ),
      );
    });
  }

  Widget buildDivider() {
    return Infowidget(builder: (context, deviceInfo) {
      return Padding(
        padding:
            EdgeInsets.symmetric(vertical: deviceInfo.screenHeight * 0.015),
        child: Divider(
          color: Colors.blue[500],
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<TaskViewModel>(context);
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
          title: Padding(
            padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.23),
            child: const Text("Home"),
          ),
        ),
        drawer: const Mydrawer(),
        body: Column(
          children: [
            buildHeader(),
            buildDivider(),
            Expanded(
              child: notesViewModel.isLoading
                  ? Center(child: Image.asset("assets/images/Progress.gif"))
                  : ListView.builder(
                      itemCount: notesViewModel.tasks.length,
                      itemBuilder: (context, index) {
                        return buildTask(
                          notesViewModel.tasks[index].taskTitle,
                          notesViewModel.tasks[index].taskDescription,
                          notesViewModel.tasks[index].deadline,
                        );
                      }),

            ),
    
          ],
        
        ),
        floatingActionButton: FloatingActionButton(
              child:const Icon(Icons.refresh),
              onPressed: () {
                     Provider.of<TaskViewModel>(context, listen: false)
          .fetchTasks();
            })   
      );
    });
  }
}
