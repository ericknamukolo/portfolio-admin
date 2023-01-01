import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:portfolio_admin/constants/colors.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/works.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../models/work.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_toast.dart';

class EditExperienceScreen extends StatefulWidget {
  static const routeName = '/edit-experience-screen';
  final Work? work;
  const EditExperienceScreen({super.key, this.work});

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  bool _isLoading = false;
  bool _isCurrentJob = false;
  List<String> empType = ['Part - Time', 'Full - Time'];
  int _groupValue = 0;

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController _company = TextEditingController();
  TextEditingController _position = TextEditingController();
  TextEditingController _siteUrl = TextEditingController();
  TextEditingController _workDone = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _state = TextEditingController();

  @override
  void initState() {
    //Work DATA
    _isCurrentJob = widget.work!.worksHere;
    _groupValue = widget.work!.empType == 'Part - Time' ? 0 : 1;
    _company = TextEditingController(text: widget.work!.company);
    _position = TextEditingController(text: widget.work!.position);
    _siteUrl = TextEditingController(text: widget.work!.siteUrl);
    _workDone = TextEditingController(text: widget.work!.workDone);
    _country = TextEditingController(text: widget.work!.country);
    _state = TextEditingController(text: widget.work!.state);
    startDate = DateTime.parse(widget.work!.startDate);
    endDate = widget.work!.endDate == null
        ? null
        : DateTime.parse(widget.work!.endDate!);
    //Work DATA

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
      appBar: CustomAppBar(
          title: 'Edit Work',
          showLeading: true,
          action: IconButton(
            onPressed: () async {
              // await Provider.of<Works>(context, listen: false)
              //     .deleteWorkExp(widget.work!.id!);
            },
            icon: Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
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
              CustomTextField(
                hint: 'Company Website',
                preIcon: MdiIcons.web,
                tc: TextCapitalization.none,
                data: _siteUrl,
              ),
              CustomTextField(
                hint: 'Work Accomplished (#)',
                preIcon: MdiIcons.bookOpenPageVariantOutline,
                tc: TextCapitalization.none,
                data: _workDone,
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
                      initialDate: startDate!,
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
                        initialDate: DateTime.now(),
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
              Text('Employment Type', style: kBodyTextStyleGrey),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (val) => setState(() => _groupValue = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Part - Time', style: kBodyTextStyleGrey),
                  const SizedBox(width: 10),
                  Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (val) => setState(() => _groupValue = val!),
                    activeColor: kPrimaryColor,
                  ),
                  Text('Full - Time', style: kBodyTextStyleGrey),
                ],
              ),
              CustomTextField(
                hint: 'Country',
                preIcon: MdiIcons.earth,
                tc: TextCapitalization.none,
                data: _country,
              ),
              CustomTextField(
                hint: 'State',
                preIcon: MdiIcons.city,
                tc: TextCapitalization.none,
                data: _state,
              ),
              Consumer<Works>(
                builder: (context, data, _) => CustomButton(
                  btnText: 'Save',
                  isLoading: _isLoading,
                  click: () async {
                    try {
                      setState(() => _isLoading = true);
                      await data.updateWork(
                        Work(
                          id: widget.work!.id,
                          company: _company.text,
                          position: _position.text,
                          country: _country.text,
                          empType: empType[_groupValue],
                          state: _state.text,
                          siteUrl: _siteUrl.text.isEmpty ? null : _siteUrl.text,
                          startDate: startDate!.toIso8601String(),
                          workDone: _workDone.text,
                          endDate: endDate?.toIso8601String(),
                          worksHere: _isCurrentJob,
                        ),
                      );
                      setState(() => _isLoading = false);
                      Navigator.of(context).pop();
                    } catch (e) {
                      BotToast.showCustomNotification(
                          toastBuilder: (context) => CustomToast(
                              message: e.toString(), type: 'error'));
                      setState(() => _isLoading = false);
                    }
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
