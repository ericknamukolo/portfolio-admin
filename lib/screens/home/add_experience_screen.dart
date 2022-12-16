import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/models/work.dart';
import 'package:portfolio_admin/providers/works.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_toast.dart';

class AddExperienceScreen extends StatefulWidget {
  static const routeName = '/add-experience-screen';
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  bool _isLoading = false;
  bool _isCurrentJob = false;

  String selectedCountry = 'Zambia';
  String selectedState = 'Lusaka';
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController _company = TextEditingController();
  final TextEditingController _position = TextEditingController();

  List<dynamic> countries = [];
  List<dynamic> states = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      var cntr = await Works.readJsonCountries();
      var prvnces =
          cntr.firstWhere((element) => element['name'] == selectedCountry);
      setState(() {
        countries = cntr;
        states = prvnces['states'];
      });
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
    return Scaffold(
      floatingActionButton: _isLoading ? CustomLoading() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppBar(title: 'Add Work', showLeading: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hint: 'Company Name',
              preIcon: MdiIcons.officeBuilding,
              tc: TextCapitalization.words,
              data: _company,
            ),
            CustomTextField(
              hint: 'Position',
              preIcon: MdiIcons.briefcase,
              tc: TextCapitalization.words,
              data: _position,
            ),
            CustomDropDownButton(
              removeSpace: true,
              icon: Icons.calendar_month_rounded,
              label: startDate == null
                  ? 'Start Date'
                  : '${startDate!.year} - ${startDate!.month} - ${startDate!.day}',
              click: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2020),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now());
                if (date != null) {
                  setState(() {
                    startDate = date;
                  });
                }
              },
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: kPrimaryColor,
                  value: _isCurrentJob,
                  onChanged: (_) =>
                      setState(() => _isCurrentJob = !_isCurrentJob),
                ),
                Text('I currently work here', style: kBodyTextStyleGrey),
              ],
            ),
            Visibility(
              visible: !_isCurrentJob,
              child: CustomDropDownButton(
                icon: Icons.calendar_month_rounded,
                label: endDate == null
                    ? 'End Date'
                    : '${endDate!.year} - ${endDate!.month} - ${endDate!.day}',
                click: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2020),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now());
                  if (date != null) {
                    setState(() {
                      endDate = date;
                    });
                  }
                },
              ),
            ),
            CustomDropDownButton(
              icon: MdiIcons.earth,
              label: selectedCountry,
              click: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Select Country',
                            style: kTitleTextStyle.copyWith(
                                color: kSecondaryColor),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: countries
                                  .map((cn) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCountry = cn['name'];
                                          });

                                          Navigator.of(context).pop();

                                          var bs = countries.firstWhere(
                                              (element) =>
                                                  selectedCountry ==
                                                  element['name']);

                                          setState(() {
                                            states = bs['states'];
                                            if (states.isNotEmpty) {
                                              selectedState =
                                                  states.first['name'];
                                            } else {
                                              selectedState = '';
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          color: Color(0xffF0F0F0),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                cn['name'],
                                                style:
                                                    kBodyTextStyleGrey.copyWith(
                                                  color: selectedCountry ==
                                                          cn['name']
                                                      ? kPrimaryColor
                                                      : kBodyTextStyleGrey
                                                          .color,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Visibility(
                                                visible: selectedCountry ==
                                                    cn['name'],
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: kPrimaryColor,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            CustomDropDownButton(
              icon: MdiIcons.city,
              label: selectedState,
              click: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Select Province',
                            style: kTitleTextStyle.copyWith(
                                color: kSecondaryColor),
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: states
                                  .map((cn) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedState = cn['name'];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          color: Color(0xffF0F0F0),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                cn['name'],
                                                style:
                                                    kBodyTextStyleGrey.copyWith(
                                                  color: selectedState ==
                                                          cn['name']
                                                      ? kPrimaryColor
                                                      : kBodyTextStyleGrey
                                                          .color,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Visibility(
                                                visible:
                                                    selectedState == cn['name'],
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: kPrimaryColor,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            CustomButton(
              btnText: 'Add Work',
              isLoading: _isLoading,
              click: () async {
                try {
                  setState(() => _isLoading = true);
                  await Works.addWork(Work(
                    company: _company.text,
                    position: _position.text,
                    country: selectedCountry,
                    empType: 'Full - Time',
                    state: selectedState,
                    siteUrl: '',
                    startDate: startDate!.toIso8601String(),
                    workDone: '',
                    endDate: endDate?.toIso8601String(),
                    worksHere: _isCurrentJob,
                  ));
                  setState(() => _isLoading = false);
                  Navigator.of(context).pop();
                } catch (e) {
                  BotToast.showCustomNotification(
                      toastBuilder: (context) =>
                          CustomToast(message: e.toString(), type: 'error'));
                  setState(() => _isLoading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
