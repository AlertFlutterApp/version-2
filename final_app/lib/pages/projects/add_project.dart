import 'package:flutter/material.dart';
import 'package:final_app/bloc/bloc_provider.dart';
import 'package:final_app/pages/projects/project.dart';
import 'package:final_app/pages/projects/project_bloc.dart';
import 'package:final_app/utils/collapsable_expand_tile.dart';
import 'package:final_app/utils/color_utils.dart';
import 'package:final_app/utils/keys.dart';

class AddProject extends StatelessWidget {
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProjectBloc _projectBloc = BlocProvider.of(context);
    ColorPalette currentSelectedPalette;
    String projectName = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضافه کردن پروژه", //Add Project
          key: ValueKey(AddProjectKeys.TITLE_ADD_PROJECT),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          key: ValueKey(AddProjectKeys.ADD_PROJECT_BUTTON),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              var project = Project.create(
                  projectName,
                  currentSelectedPalette.colorValue,
                  currentSelectedPalette.colorName);
              _projectBloc.createProject(project);
              Navigator.pop(context, true);
            }
          }),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: ValueKey(AddProjectKeys.TEXT_FORM_PROJECT_NAME),
                decoration: InputDecoration(hintText: "اضافه کردن پروژه"), //Project Name
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "پروژه نمی تواند خالی باشد" : null; //Project name cannot be empty
                },
                onSaved: (value) {
                  projectName = value;
                },
              ),
            ),
            key: _formState,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder(
              stream: _projectBloc.colorSelection,
              initialData: ColorPalette("Grey", Colors.grey.value),// طوسی
              builder: (context, snapshot) {
                currentSelectedPalette = snapshot.data;
                return CollapsibleExpansionTile(
                  key: expansionTile,
                  leading: Container(
                    width: 12.0,
                    height: 12.0,
                    child: CircleAvatar(
                      backgroundColor: Color(snapshot.data.colorValue),
                    ),
                  ),
                  title: Text(snapshot.data.colorName),
                  children: buildMaterialColors(_projectBloc),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(ProjectBloc projectBloc) {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(colors.colorValue),
          ),
        ),
        title: Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          projectBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );
        },
      ));
    });
    return projectWidgetList;
  }
}