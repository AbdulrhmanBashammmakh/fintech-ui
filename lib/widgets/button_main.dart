import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/AColors.dart';

class ButtonMain extends StatelessWidget {
  const ButtonMain(
      {super.key, required this.fontSize, required this.text, this.onPressed});
  final double fontSize;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isNext;
  final int currentStep;
  final bool updtbl;
  final bool mndtry;
  final String label;
  final String? type;
  final String? subType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool? showText;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? detailSubType;
  final int maxLength;
  final onValidator;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.onValidator,
      required this.isNext,
      required this.currentStep,
      required this.updtbl,
      required this.mndtry,
      required this.label,
      required this.type,
      required this.subType,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.readOnly,
      this.showText = true,
      this.inputFormatters,
      this.hintText,
      this.detailSubType,
      this.maxLength = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appnd = ' *';
    Color notUpdtblColor = Colors.grey.withOpacity(0.3);

    // Person Image
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: type == 'Num'
            ? TextInputType.number
            : type == 'Date' || subType == 'DateFormat'
                ? TextInputType.datetime
                : TextInputType.text,
        textInputAction: TextInputAction.next,
        obscureText: !showText!,
        autocorrect: false,
        autofocus: false,
        maxLength: maxLength,
        validator: onValidator,
        inputFormatters: getInputFormatters(type),
        // onTap: onTap,
        maxLines: 1,
        decoration: InputDecoration(
          label: Text(label + (mndtry ? appnd : '')),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          counterText: "",
          filled: !updtbl,
          fillColor: notUpdtblColor,
          hintText: hintText,
        ),
      ),
    );
  }

  getInputFormatters(String? type) {
    if (inputFormatters != null) {
      return inputFormatters;
    } else if (type == 'Num') {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        subType == 'Mob'
            ? FilteringTextInputFormatter.allow(RegExp('^[7]?([0-9]{2,9})?\$'))
            : FilteringTextInputFormatter.digitsOnly,
      ];
    } else if (type == 'Name') {
      return [
        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ء-ي]')),
        FilteringTextInputFormatter.deny(RegExp('[0-9]')),
        FilteringTextInputFormatter.deny(RegExp(r'^[ ]')),
        FilteringTextInputFormatter.deny(RegExp('  ')),
      ];
    } else if (type == 'Date') {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.allow(RegExp('/')),
      ];
    }

    return null;
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final IconData icon;
  final double fontSize = 20;
  const ButtonWidget({
    Key? key,
    fontSize,
    required this.text,
    required this.onClicked,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: const EdgeInsets.all(7),
        constraints: BoxConstraints(minWidth: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onClicked,
    );
  }
}

void showCustomDialog(
    {context,
    btnOkText,
    btnCancelText,
    okFunc,
    btnOk,
    btnCancel,
    dialogType,
    body,
    dismissOnTouchOutside,
    width,
    showCloseIcon}) {
  var dT;
  if (dialogType == 'Q') {
    dT = DialogType.QUESTION;
  }

  AwesomeDialog(
    context: context,
    width: width ?? 500,
    dialogType: dT ?? DialogType.NO_HEADER,
    animType: AnimType.SCALE,
    body: body,
    headerAnimationLoop: true,
    btnOkColor: constPrimaryColor,
    btnOk: btnOk,
    btnCancel: btnCancel,
    btnOkOnPress: okFunc ?? () {},
    btnOkText: btnOkText,
    btnCancelText: btnCancelText,
    btnCancelColor: Colors.grey.withOpacity(0.5),
    btnCancelOnPress: () {},
    enableEnterKey: true,
    dismissOnBackKeyPress: dismissOnTouchOutside ?? true,
    dismissOnTouchOutside: dismissOnTouchOutside ?? true,
    showCloseIcon: showCloseIcon ?? true,
  ).show();
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
// CircularProgressIndicator(
// color: Colors.white,
// )

// borderRadius:
// const BorderRadius.all(Radius.circular(15)),

void dismissDialog({BuildContext? context}) async {
  AwesomeDialog(
          context: context ?? NavigationService.navigatorKey.currentContext!)
      .dismiss();
}

void show_Dialog({
  BuildContext? context,
  title,
  desc,
  btnOk,
  btnOkText,
  okPress,
  btnCancel,
  btnCancelText,
  cancelPress,
  dismiss,
  dialogType,
}) {
  DialogType? dT;
  if (dialogType == 'S') {
    dT = DialogType.SUCCES;
  } else if (dialogType == 'E') {
    dT = DialogType.ERROR;
  } else if (dialogType == 'Q') {
    dT = DialogType.QUESTION;
  } else if (dialogType == 'W') {
    dT = DialogType.WARNING;
  }

  AwesomeDialog(
    context: context ?? NavigationService.navigatorKey.currentContext!,
    width: 500,
    dialogType: dT ?? DialogType.NO_HEADER,
    animType: AnimType.SCALE,
    title: title,
    desc: desc ?? '',
    headerAnimationLoop: true,
    btnOkColor:
        Theme.of(context ?? NavigationService.navigatorKey.currentContext!)
            .primaryColor,
    btnOk: btnOk,
    btnOkText: btnOkText ?? 'okay'.tr,
    btnOkOnPress: okPress ?? () {},
    btnCancel: btnCancel,
    btnCancelText: btnCancelText,
    btnCancelColor: Colors.grey.withOpacity(0.5),
    btnCancelOnPress: cancelPress,
    enableEnterKey: true,
    dismissOnBackKeyPress: dismiss ?? true,
    dismissOnTouchOutside: dismiss ?? true,
  ).show();
}

void showLoadingDialog({
  String? msg,
  BuildContext? context,
}) {
  showDialog(
    context: context ?? NavigationService.navigatorKey.currentContext!,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: constPrimaryColor),
              SizedBox(height: 15),
              Text(msg ?? 'loading'.tr),
            ],
          ),
        ),
      );
    },
  );
}

class NotificationBody extends StatefulWidget {
  final String msg;
  final double? mdw;
  const NotificationBody({
    Key? key,
    required this.msg,
    this.mdw,
  }) : super(key: key);

  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  Widget build(BuildContext context) {
    String text = '';
    double mdw = widget.mdw ?? MediaQuery.of(context).size.width;
    double horizonPadding = mdw < 1200 ? 50 : 300;
    Color notifyColor = Theme.of(context).primaryColor.withOpacity(0.8);
    switch (widget.msg) {
      case 'try':
        text = 'try'.tr;
        notifyColor = Theme.of(context).primaryColor.withOpacity(0.4);
        break;
      case 'successful':
        text = 'done-successful'.tr;
        notifyColor = Colors.lightGreen.withOpacity(0.4);
        break;
      default:
        text = 'done-successful'.tr;
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: EdgeInsets.fromLTRB(horizonPadding, 10, horizonPadding, 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 12,
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: notifyColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                width: 1.4,
                color: notifyColor,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
