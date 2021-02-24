import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/task_completed/task_complted.dart';
import 'package:flutter_app/pages/tasks/task_widgets.dart';
import 'package:flutter_app/utils/keys.dart';

class HomePage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);
    homeBloc.filter.listen((filter) {
      _taskBloc.updateFilters(filter);
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,

        title: StreamBuilder<String>(
            initialData: 'امروز',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(
                snapshot.data,
                key: ValueKey(HomePageKeys.HOME_TITLE),
              );
            }),
        actions: <Widget>[buildPopupMenu(context)],
        leading: new IconButton(
            icon: new Icon(
              Icons.view_headline,
              key: ValueKey(SideDrawerKeys.DRAWER),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
      ),
        /*leading : buildPopupMenu(context),
        actions: [new IconButton(
            icon: new Icon(
              Icons.view_headline,
              key: ValueKey(SideDrawerKeys.DRAWER),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),]
      ),
      //endDrawer: ,*/
      floatingActionButton: FloatingActionButton(
        key: ValueKey(HomePageKeys.ADD_NEW_TASK_BUTTON),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        //backgroundColor: Colors.orange,
        onPressed: () async {
          var blocProviderAddTask = BlocProvider(
            bloc: AddTaskBloc(TaskDB.get(), ProjectDB.get(), LabelDB.get()),
            child: AddTaskScreen(),
          );
          await Navigator.push(
            context,
            MaterialPageRoute<bool>(builder: (context) => blocProviderAddTask),
          );
          _taskBloc.refresh();
        },
      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(

      key: ValueKey(CompletedTaskPageKeys.POPUP_ACTION),
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => TaskCompletedPage()),
            );
            _taskBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(

          value: MenuItem.taskCompleted,

          child: const Text(
            'فعالیت های انجام شده',
            key: ValueKey(CompletedTaskPageKeys.COMPLETED_TASKS),

          ),
        )
      ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }