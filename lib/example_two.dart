import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExampleTwo extends StatefulWidget {
  ExampleTwo({Key key}) : super(key: key);

  @override
  _ExampleTwoState createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {

  FormGroup form = FormGroup({
    "text": FormControl<String>(),
    "selection" : FormControl<String>(),
    "number" : FormControl<int>(value: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 24,),
                Text("This is the another example.\n In it we have a very large form with submit button at bottom. In the beginning it is a TextField an down at the end a Dropdown field and another Text Field. \n"
                    "When you select something on the Dropdown, the focus returns to the text field forcing you to scroll back to the bottom. But if you fill the last TextField and then select another thing the Focus goes to that TextField (kboom!!)"),
                SizedBox(height: 16,),
                ReactiveTextField<String>(
                  formControlName: "text",
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit),
                      labelText: "Name of apprentice"
                  ),
                ),
                SizedBox(height: 16,),
                Text("Here should go many and many form fields... as many as you can imagine", style: TextStyle(fontSize: 48),),
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
                SizedBox(height: 8,),
                ReactiveTextField<int>(
                  formControlName: "number",
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.access_time),
                      labelText: "Age of apprentice"
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16,),
                ReactiveFormConsumer(
                  builder: (BuildContext context, FormGroup formGroup, Widget child) => ElevatedButton(onPressed: (){
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text("Chapter 1"),
                      content: Text("A long time ago, in a galaxy far away the ${formGroup.value["number"]} years old ${formGroup.value["selection"]} apprentice ${formGroup.value["text"]} hit this motherfucker button!" ),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Ok"))
                      ],
                    )).then((value) => formGroup.reset(value: {"number" : 0},));
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