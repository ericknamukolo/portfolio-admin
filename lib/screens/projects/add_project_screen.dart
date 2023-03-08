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
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../models/project.dart';
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

  final TextEditingController _name = TextEditingController();
  final TextEditingController _des = TextEditingController();
  final TextEditingController _playStore = TextEditingController();
  final TextEditingController _link = TextEditingController();
  final TextEditingController _github = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _coverImg;
  List<XFile> _pickedImages = [];

  Future<void> getCover() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    File imageTemp = File(pickedImage.path);
    setState(() {
      _coverImg = imageTemp;
    });
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
      appBar: CustomAppBar(title: 'Add Project', showLeading: true),
      body: Container(
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
            _groupValue == 1
                ? CustomTextField(
                    hint: 'External link',
                    preIcon: MdiIcons.linkVariant,
                    tc: TextCapitalization.none,
                    data: _link,
                    suffIcon: IconButton(
                      onPressed: () async {
                        Uri uri = Uri.parse(
                            'https://app.netlify.com/teams/ericknamukolo/overview');
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      },
                      icon: Icon(Icons.link, color: kPrimaryColor),
                    ),
                  )
                : CustomTextField(
                    hint: 'Google Playstore link',
                    preIcon: MdiIcons.googlePlay,
                    tc: TextCapitalization.none,
                    data: _playStore,
                    suffIcon: IconButton(
                      onPressed: () async {
                        Uri uri = Uri.parse(
                            'https://play.google.com/store/apps/dev?id=8203990443766365712');
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
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
            const Spacer(),
            Consumer<Projects>(
              builder: (context, data, _) => CustomButton(
                btnText: 'Add Project',
                isLoading: _isLoading,
                click: () async {
                  try {
                    setState(() => _isLoading = true);
                    await data.addProject(Project(
                      name: _name.text,
                      des: _des.text,
                      type: appType[_groupValue],
                      externalLink: _link.text,
                      githubLink: _github.text,
                      googleLink: _playStore.text,
                      coverImg: _coverImg!,
                      images: _pickedImages,
                    ));
                    setState(() => _isLoading = false);
                    Navigator.of(context).pop();
                  } catch (e) {
                    Toast.showToast(
                        message: e.toString(), type: ToastType.error);
                    setState(() => _isLoading = false);
                  }
                },
              ),
            ),
          ],
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
