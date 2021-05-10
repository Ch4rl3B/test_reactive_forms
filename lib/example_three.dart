import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExampleThree extends StatefulWidget {
  ExampleThree({Key key}) : super(key: key);

  @override
  _ExampleThreeState createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 24,),
        Text("This is my example.\n In it we have a dialog with submit button at bottom. It is like Example 1 and haves the same behavior. \n"),
        Expanded(child: Container(
          child: Center(
            child: ElevatedButton(child: Text("Open dialog"), onPressed: (){
              showDialog(context: context, builder: (_) => _builder(context));
            },),
          ),
        ))
      ],
    );
  }

  Widget _builder(BuildContext root) {
    FormGroup form = FormGroup({
      "text": FormControl<String>(),
      "selection" : FormControl<String>()
    });

      return AlertDialog(
        title: Text("Make your intro"),
        content: ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: "text",
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        labelText: "Name of apprentice"
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text("Here should go many and many form fields... as many as you can imagine", style: TextStyle(fontSize: 22),),
                  SizedBox(height: 16,),
                  ReactiveDropdownField<String>(
                    formControlName: "selection",
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.list),
                        labelText: "Which class do you are?"
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "jedi",
                        child: Text("jedi".toUpperCase()),
                      ),
                      DropdownMenuItem(
                        value: "sith",
                        child: Text("sith".toUpperCase()),
                      ),
                      DropdownMenuItem(
                        value: "storm trooper",
                        child: Text("storm trooper".toUpperCase()),
                      ),
                      DropdownMenuItem(
                        value: "rebel wing",
                        child: Text("Rebel Wing".toUpperCase()),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  ReactiveFormConsumer(
                    builder: (BuildContext context, FormGroup formGroup, Widget child) => ElevatedButton(onPressed: (){
                      Navigator.pop(root);
                      showDialog(context: root, builder: (_) => AlertDialog(
                        title: Text("Chapter 1"),
                        content: Text("A long time ago, in a galaxy far away the young ${formGroup.value["selection"]} apprentice ${formGroup.value["text"]} hit this motherfucker button!" ),
                        actions: [
                          ElevatedButton(onPressed: (){
                            Navigator.pop(root);
                          }, child: Text("Ok"))
                        ],
                      )).then((value) => formGroup.reset());
                    }, child: Text("Submit", style: TextStyle(fontSize: 22),)),
                  ),
                  SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ),
      );
  }
}