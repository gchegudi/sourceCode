import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/carrage.dart';
import 'package:listar_flutter_pro/providers/add_lisitItemProvider.dart';
import 'package:listar_flutter_pro/providers/edit_lisitItemProvider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:listar_flutter_pro/configs/constants.dart';

import '../location/location_picker.dart';

class EditStepper extends StatefulWidget {
  Carrage carrage;

  EditStepper({this.carrage});

  @override
  _EditStepperState createState() => _EditStepperState();
}

class _EditStepperState extends State<EditStepper> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  void initState() {
    print("data loaded${widget.carrage.dataListModel.id}");

    final provider =
        Provider.of<EditListItemFormProvider>(context, listen: false);
    provider.reset();
    provider.currunt_state = appstate.defaultstate;
    provider.skey = new GlobalKey<ScaffoldState>();
    provider.loadData();
    provider.setData(widget.carrage);
  }


  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<EditListItemFormProvider>(context, listen: false);
    provider.context = context;

    return Scaffold(
      key: provider.skey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit List Item'),
        centerTitle: true,
      ),
      body:
          Consumer<EditListItemFormProvider>(builder: (context, value, child) {
        if (value.currunt_state == appstate.laoding_complete)
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text(
                          'Informtion',
                          style: TextStyle(fontSize: 12),
                        ),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: value.titleController,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                            TextFormField(
                              controller: value.emailController,
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                            ),
                            TextFormField(
                              controller: value.phoneController,
                              decoration: InputDecoration(labelText: 'Phone'),
                            ),
                            InkWell(
                              onTap: () {
                                value.showCategoriesDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.categoryController,
                                  decoration:
                                      InputDecoration(labelText: 'Category'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    initialValue: value.featureSelected,
                                    key: value.feature_key,
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText: Text("Select Feature"),
                                    title: Text("Select multiple Feature"),
                                    items: value.feature_items,
                                    onConfirm: (values) {
                                      value.featureSelected = values;
                                      value.showSelected();

                                      setState(() {
                                        value.selectedFeatureText="";
                                        value.container_padding_feature=0;
                                      });
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          value.featureSelected.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  (() {
                                    if (value.featureSelected != null ||
                                        value.featureSelected.isNotEmpty) {
                                     return Container(
                                          padding: EdgeInsets.all(value.container_padding_feature),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${value.selectedFeatureText}",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ));
                                    }
                                    else{
                                      return Container();
                                    }

                                  }())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText: Text("Select Tags"),
                                    title: Text("Select multiple"),
                                    items: value.tags_items,
                                    onConfirm: (values) {
                                      value.container_padding_tag=0;
                                      value.tagsSelected = values;


                                        value.selectedTagsText="";

                                          value.notifyListeners();

                                    },
                                    onSelectionChanged: (values){
                                      value.selectedTagsText="";
                                      value.container_padding_tag=0;
                                      value.notifyListeners();

                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          value.tagsSeleted.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  (() {
                                    if (value.tagsSelected != null ||
                                        value.tagsSelected.isNotEmpty) {
                                      return Container(
                                          padding: EdgeInsets.all(value.container_padding_tag),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${value.selectedTagsText}",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ));
                                    }
                                    else{
                                      return Container();
                                    }

                                  }())
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: value.exceptController,
                              decoration: InputDecoration(labelText: 'Except'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Address'),
                        content: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    value.loadPrimaryImage();
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.camera_alt),
                                      ),
                                      Text(
                                        "Primary\nImage",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    value.loadSecondaryImages();
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.image),
                                      ),
                                      Text(
                                        "Secondary\nImages",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                value.showCountiresDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.countryController,
                                  decoration:
                                      InputDecoration(labelText: 'Country'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.showStateDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.stateController,
                                  decoration:
                                      InputDecoration(labelText: 'State '),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.showCityDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.cityController,
                                  decoration:
                                      InputDecoration(labelText: 'City '),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LocationScreen.classname);
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.addressController,
                                  decoration:
                                      InputDecoration(labelText: 'Address'),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: value.pincodeController,
                              decoration: InputDecoration(labelText: 'Pincode'),
                            ),
                            TextFormField(
                              controller: value.websiteController,
                              decoration:
                                  InputDecoration(labelText: 'Website '),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Social Media'),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: value.facebookController,
                              decoration:
                                  InputDecoration(labelText: 'Facebook'),
                            ),
                            TextFormField(
                              controller: value.twitterController,
                              decoration: InputDecoration(labelText: 'Twitter'),
                            ),
                            TextFormField(
                              controller: value.instagramController,
                              decoration:
                                  InputDecoration(labelText: 'Instagram'),
                            ),
                            TextFormField(
                              controller: value.linkedinController,
                              decoration:
                                  InputDecoration(labelText: 'Linkedin'),
                            ),
                            TextFormField(
                              controller: value.youtubeController,
                              decoration: InputDecoration(labelText: 'Youtube'),
                            ),
                            TextFormField(
                              controller: value.pinterestController,
                              decoration:
                                  InputDecoration(labelText: 'Pintrest'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        else
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }),
      /*   floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),*/
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  int submit_flag = 0;

  tapped(int step) {
    submit_flag = step;
    setState(() => _currentStep = step);
  }

  continued() {
    submit_flag++;
    final provider =
        Provider.of<EditListItemFormProvider>(context, listen: false);
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    if (submit_flag > 2) {
      AwesomeDialog(
        context: context,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        btnCancelText: "Cancel",
        btnOkText: "Submit",
        title: 'Do you like to Submit',
        padding: const EdgeInsets.all(16.0),
        desc: 'Proceed',
        btnCancelOnPress: () {
        },
        btnOkOnPress: () {
          provider.submit();
        },
      ).show();
    }
  }

  cancel() {
    Navigator.pop(context); // remove no need
    submit_flag--;
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
