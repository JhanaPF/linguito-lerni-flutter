import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingui_lerni/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Top bar with course selection

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget { 
  
  final String title;
  final List<Color> gradientColors;
  final bool selectedCourse;
  final List<CourseModel> courses;
  String flagUrl = "";
  final void Function(String) updateSelectedCourse;
  
  CustomAppBar({
    super.key,
    required this.title, 
    required this.gradientColors, 
    required this.selectedCourse, 
    required this.courses,
    required this.updateSelectedCourse
  });

  void _getFlagUrl(fileName){
    flagUrl = "${dotenv.env['API_URL'] ?? ""}pictures/courses/$fileName";
  }

  void _onSelectCourseButtonPressed(BuildContext context) async{
    await dotenv.load(fileName: ".env");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sélectionnez un cours'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: courses.length, // Replace with the actual number of items in your list
                itemBuilder: (context, index) {
                  //print({context, index});
                  CourseModel course = courses[index];
                  String fileName = course.fileName;
                  //String flagUrl = _getFlagUrl(fileName);
                  _getFlagUrl(fileName);
                  
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
            ),
          );
        },
      );
    });

    //print("On select button pressed");
  }

  @override
  Widget build(BuildContext context) {
    //print({"selected course", selectedCourse});  
    if (!selectedCourse) _onSelectCourseButtonPressed(context);
  
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.grey),
      backgroundColor: Colors.transparent,
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
      title: Text(title),
      //leading: const BackButton(),
      actions: [
        IconButton(
          onPressed: () {
            _onSelectCourseButtonPressed(context);
          },
          icon: const Icon(Icons.format_list_bulleted_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}