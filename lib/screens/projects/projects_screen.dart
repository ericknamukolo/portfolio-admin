import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/projects.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/projects/single_project_card.dart';

class MProjectsAndDesigns extends StatefulWidget {
  const MProjectsAndDesigns({Key? key}) : super(key: key);

  @override
  State<MProjectsAndDesigns> createState() => _MProjectsAndDesignsState();
}

class _MProjectsAndDesignsState extends State<MProjectsAndDesigns> {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      width: double.infinity,
      child: Column(
        children: [
          Consumer<Projects>(
            builder: (context, value, __) => _isLoading
                ? CustomLoading()
                : ListView.builder(
                    itemBuilder: (conetxt, index) => SingleProjectCard(
                      project: value.projects[index],
                    ),
                    itemCount:
                        value.projects.isEmpty ? 0 : value.projects.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
          ),
        ],
      ),
    );
  }
}
