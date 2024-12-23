import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    final TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(',')) {
      truncated = newValue.text.replaceFirst(',', '.');
    }
    return TextEditingValue(text: truncated, selection: newSelection);
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final loginTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();

  String? selectedValue;
  String? radioValue;

  bool? checkBoxValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        autofocus: true,
                        inputFormatters: [
                          CommaTextInputFormatter(),
                        ],
                        controller: loginTextFieldController,
                        decoration: InputDecoration(hintText: 'Логин'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите логин';
                          }
                          return null;
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: passwordTextFieldController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Пароль'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          return null;
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: DropdownButtonFormField(
                        value: selectedValue,
                        items: [
                          DropdownMenuItem(child: Text("USA"), value: "USA"),
                          DropdownMenuItem(
                              child: Text("Canada"), value: "Canada"),
                          DropdownMenuItem(
                              child: Text("Brazil"), value: "Brazil"),
                          DropdownMenuItem(
                              child: Text("England"), value: "England"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue,
                        tristate: true,
                        onChanged: (value) {
                          setState(() {
                            checkBoxValue = value ?? false;
                          });
                        }
                      )
                    ],
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        groupValue: radioValue,
                        value: 'Radio 1',
                        onChanged: (value) {
                          setState(() {
                            radioValue = value;
                          });
                        }
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        groupValue: radioValue,
                        value: 'Radio 2',
                        onChanged: (value) {
                          setState(() {
                            radioValue = value;
                          });
                        }
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        groupValue: radioValue,
                        value: 'Radio 3',
                        onChanged: (value) {
                          setState(() {
                            radioValue = value;
                          });
                        }
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: submitForm, child: Text('Войти'))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void submitForm() async{
    if (formKey.currentState?.validate() ?? false) {
    //   final result = await showDialog(context: context, builder: (context) {
    //     return AlertDialog(
    //       title: Text('Данные формы'),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start ,
    //         children: [
    //           Text('Логин: ${loginTextFieldController.text}'),
    //           Text('Пароль: ${passwordTextFieldController.text}')
    //         ],
    //       ),
    //       actions: [
    //         ElevatedButton(onPressed: () {
    //           Navigator.of(context).pop(true);
    //         }, child: Text('Ок')),
    //         ElevatedButton(onPressed: () {
    //           Navigator.of(context).pop();
    //         }, child: Text('Отмена')),
    //       ],
    //     );
    //   });
      // print(result);
      final snackBar = SnackBar(
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              Text('Логин: ${loginTextFieldController.text}'),
              Text('Пароль: ${passwordTextFieldController.text}')
            ],
          ),
          action: SnackBarAction(label: 'Ок', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
