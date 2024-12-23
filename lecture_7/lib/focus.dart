import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(),
                )
              ],
            ),
            Focus(
              canRequestFocus: false,
              onFocusChange: (value) {
                print(value);
              },
              descendantsAreTraversable: false,
              descendantsAreFocusable: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: myFocusNode,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      child: Text('Фокус на второе поле'),
                      onPressed: () {
                        myFocusNode.requestFocus();
                      }),
                )
              ],
            ),
            FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Column(
                children: [
                  FocusTraversalOrder(
                    order: NumericFocusOrder(2),
                    child: Row(
                      children: [
                        Expanded(child: TextFormField())
                      ],
                    ),
                  ),
                FocusTraversalOrder(
                    order: NumericFocusOrder(1),
                    child: Row(
                      children: [
                        Expanded(child: TextFormField())
                      ],
                    ),
                  ),
                 FocusTraversalOrder(
                    order: NumericFocusOrder(3),
                    child: Row(
                      children: [
                        Expanded(child: TextFormField())
                      ],
                    ),
                  ),
                ],
              ))
          ],
        ),
      ),
    );
  }
}
