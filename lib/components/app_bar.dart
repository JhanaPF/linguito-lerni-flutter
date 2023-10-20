import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingui_lerni/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../http_client.dart';

// Top bar with course selection
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget { 
  
  final String title;
  final List<Color> gradientColors;
  final bool selectedCourse;
  final List<CourseModel> courses;
  final void Function(String) updateSelectedCourse;

  const CustomAppBar({
    super.key,
    required this.title, 
    required this.gradientColors, 
    required this.selectedCourse, 
    required this.courses,
    required this.updateSelectedCourse,
  });

  void _openCourseSelection(BuildContext context) async{
    await dotenv.load(fileName: ".env");
    var url = await getRootUrl();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Sélectionnez un cours'),
            children: <Widget> [
              SizedBox(
                height: 200, 
                width: 200, 
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    //print({context, index});
                    CourseModel course = courses[index];
                    String fileName = course.fileName;
                    String flagUrl = "${url}pictures/courses/$fileName";

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(flagUrl), //
                      ),
                      title: Text(course.language),
                      onTap: () async {
                        updateSelectedCourse(course.id);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              )
            ]
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //print({"selected course", selectedCourse});  
    if (!selectedCourse) _openCourseSelection(context); 
  
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.grey),
      backgroundColor: Color.fromARGB(0, 49, 49, 49),
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(title, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
      //leading: const BackButton(),
      actions: [
        IconButton(
          onPressed: () {
            _openCourseSelection(context);
          },
          icon: const Icon(Icons.format_list_bulleted_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}