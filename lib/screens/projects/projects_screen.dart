import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../providers/projects.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/projects/single_project_card.dart';
import '../../widgets/screen_title.dart';

class ProjectsNavScreen extends StatefulWidget {
  const ProjectsNavScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsNavScreen> createState() => _MProjectsNavScreenState();
}

class _MProjectsNavScreenState extends State<ProjectsNavScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      try {
        await Provider.of<Projects>(context, listen: false)
            .fetchAndSetProjects();
      } catch (e) {
        Toast.showToast(message: e.toString(), type: ToastType.error);
      } finally {
        setState(() => _isLoading = false);
      }
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Projects>(
      builder: (context, value, __) => _isLoading
          ? CustomLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ScreenTitle(
                      data: value.projects.length.toString(),
                      title: 'Projects'),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (conetxt, index) =>
                        SingleProjectCard(project: value.projects[index]),
                    itemCount: value.projects.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
    );
  }
}
