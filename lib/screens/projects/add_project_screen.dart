import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/constants.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/projects.dart';
import 'package:portfolio_admin/widgets/custom_button.dart';
import 'package:portfolio_admin/widgets/custom_loading.dart';
import 'package:portfolio_admin/widgets/custom_text_field.dart';
import 'package:portfolio_admin/widgets/custom_toast.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import 'package:portfolio_admin/widgets/projects/custom_chip.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../models/project.dart';
import '../../providers/skills.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/projects/image_card.dart';

class AddProjectScreen extends StatefulWidget {
  static const routeName = '/add-project-screen';
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  bool _isLoading = false;
  List<String> appType = ['Mobile', 'Web/Windows'];
  int _groupValue = 0;
  int _projectType = 0;
  bool _isEdit = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _des = TextEditingController();
  TextEditingController _playStore = TextEditingController();
  TextEditingController _link = TextEditingController();
  TextEditingController _github = TextEditingController();
  TextEditingController _customTech = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _coverImg;
  String? projectId;
  List<XFile> _pickedImages = [];
  List<String> tech = [];
  Future<void> getCover() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    File imageTemp = File(pickedImage.path);
    setState(() {
      _coverImg = imageTemp;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      autoFillFields();
      try {
        await Provider.of<Skills>(context, listen: false).fetchSkills();
      } catch (e) {
        Toast.showToast(message: e.toString(), type: ToastType.error);
      }
    });
    super.initState();
  }

  void autoFillFields() {
    Project? project = ModalRoute.of(context)!.settings.arguments as Project?;
    if (project == null) return;
    setState(() {
      _isEdit = true;
      projectId = project.id;
      _groupValue = appType.indexOf(project.type);
      tech = project.tech;
      _name = TextEditingController(text: project.name);
      _des = TextEditingController(text: project.description);
      _playStore = TextEditingController(text: project.playstoreLink);
      _link = TextEditingController(text: project.externalLink);
      _github = TextEditingController(text: project.githubLink);
      _projectType = project.isPersonal ? 0 : 1;
    });
  }

  Future makeRequest(Future fn) async {
    try {
      setState(() => _isLoading = true);
      await fn;
      Navigator.of(context).pop();
    } catch (e) {
      Toast.showToast(message: e.toString(), type: ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _des.dispose();
    _playStore.dispose();
    _link.dispose();
    _github.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading ? CustomLoading() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppBar(
          title: '${_isEdit ? 'Edit' : 'Add'} Project',
          showLeading: true,
          action: _isEdit
              ? GestureDetector(
                  onLongPress: () =>
                      Provider.of<Projects>(context, listen: false)
                          .deleteProject(projectId!, context),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                  ),
                )
              : null),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hint: 'Project Name',
                preIcon: MdiIcons.pen,
                tc: TextCapitalization.words,
                data: _name,
              ),
              CustomTextField(
                hint: 'Description',
                preIcon: MdiIcons.paperclip,
                tc: TextCapitalization.words,
                data: _des,
                lines: null,
              ),
              Text('Application Type', style: kBodyTextStyleGrey),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (val) => setState(() => _groupValue = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Mobile', style: kBodyTextStyleGrey),
                  const SizedBox(width: 10),
                  Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (val) => setState(() => _groupValue = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Web/Windows', style: kBodyTextStyleGrey),
                ],
              ),
              Text('Project Type', style: kBodyTextStyleGrey),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _projectType,
                    onChanged: (val) => setState(() => _projectType = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Personal', style: kBodyTextStyleGrey),
                  const SizedBox(width: 10),
                  Radio(
                    value: 1,
                    groupValue: _projectType,
                    onChanged: (val) => setState(() => _projectType = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Work/Client', style: kBodyTextStyleGrey),
                ],
              ),
              Text('Images', style: kBodyTextStyleGrey),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageCard(
                      removeBgColor: _coverImg != null,
                      click: getCover,
                      child: _coverImg == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_camera_rounded,
                                    color: kPrimaryColor),
                                SizedBox(height: 5),
                                Text(
                                  'Add Cover Image',
                                  style:
                                      kBodyTextStyleGrey.copyWith(fontSize: 11),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Image.file(_coverImg!),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: _pickedImages.isEmpty,
                      child: ImageCard(
                        click: () async {
                          List<XFile>? pickedImages =
                              await _picker.pickMultiImage();
                          setState(() => _pickedImages = pickedImages);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_camera_rounded,
                                color: kPrimaryColor),
                            SizedBox(height: 5),
                            Text(
                              'Add More Images',
                              style: kBodyTextStyleGrey.copyWith(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Wrap(
                        runSpacing: 10.0,
                        spacing: 10.0,
                        children: _pickedImages
                            .map((img) => SmallImageCard(image: img))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Text('Tech Used', style: kBodyTextStyleGrey),
              SizedBox(height: 5),
              Consumer<Skills>(
                builder: (_, value, __) => DropDown(
                  items: value.skills.map((skill) => skill.name).toList(),
                  hint: 'Select Tech Used',
                  onChanged: (val) {
                    if (!tech.contains(val)) {
                      setState(() => tech.add(val!));
                    }
                  },
                ),
              ),
              CustomTextField(
                hint: 'Custom Tech used',
                preIcon: Icons.folder,
                tc: TextCapitalization.none,
                data: _customTech,
                suffIcon: IconButton(
                  onPressed: () async {
                    if (!tech.contains(_customTech.text.trim())) {
                      setState(() => tech.add(_customTech.text.trim()));
                    }
                    _customTech.clear();
                  },
                  icon: Icon(Icons.add, color: kPrimaryColor),
                ),
              ),
              Wrap(
                runSpacing: 10.0,
                children: tech
                    .map((img) => CustomChip(
                          name: img,
                          delete: () => setState(() => tech.remove(img)),
                        ))
                    .toList(),
              ),
              Text('Links', style: kBodyTextStyleGrey),
              SizedBox(height: 5),
              CustomTextField(
                hint: 'External link',
                preIcon: MdiIcons.linkVariant,
                tc: TextCapitalization.none,
                data: _link,
                suffIcon: IconButton(
                  onPressed: () async {
                    Uri uri = Uri.parse(
                        'https://app.netlify.com/teams/ericknamukolo/overview');
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  icon: Icon(Icons.link, color: kPrimaryColor),
                ),
              ),
              CustomTextField(
                hint: 'Google Playstore link',
                preIcon: MdiIcons.googlePlay,
                tc: TextCapitalization.none,
                data: _playStore,
                suffIcon: IconButton(
                  onPressed: () async {
                    Uri uri = Uri.parse(
                        'https://play.google.com/store/apps/dev?id=8203990443766365712');
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  icon: Icon(Icons.link, color: kPrimaryColor),
                ),
              ),
              CustomTextField(
                hint: 'Github link',
                preIcon: MdiIcons.github,
                tc: TextCapitalization.none,
                data: _github,
                suffIcon: IconButton(
                  onPressed: () async {
                    Uri uri = Uri.parse('https://github.com/ericknamukolo');
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  icon: Icon(Icons.link, color: kPrimaryColor),
                ),
              ),
              Consumer<Projects>(
                builder: (context, data, _) => CustomButton(
                  btnText: _isEdit ? 'Save Changes' : 'Add Project',
                  isLoading: _isLoading,
                  click: () {
                    Project proj = Project(
                      id: projectId,
                      name: _name.text,
                      description: _des.text,
                      type: appType[_groupValue],
                      externalLink: _link.text,
                      githubLink: _github.text,
                      playstoreLink: _playStore.text,
                      cover: _coverImg,
                      images: _pickedImages,
                      tech: tech,
                      isPersonal: _projectType == 0,
                    );
                    makeRequest(_isEdit
                        ? data.updateProject(proj)
                        : data.addProject(proj));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmallImageCard extends StatelessWidget {
  final XFile image;
  const SmallImageCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Image.file(File(image.path)),
    );
  }
}
