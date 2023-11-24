import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_list_logic.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProjectListLogic());

    return Center(
      child: Text(toString()),
    );
  }
}
