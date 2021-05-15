import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

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
        Text("This is my example.\n In it we have a dialog with submit button at bottom. Here the Date From must be lower or equal to Date To. \n"),
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
      'fulltext' : FormControl<String>(),
      'dateFrom' : FormControl<DateTime>(value: DateTime.now().subtract(Duration(days: 1)), validators: [Validators.required, Validators.max(DateTime.now())]),
      'dateTo' : FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required, Validators.max(DateTime.now().add(Duration(days: 1))), Validators.compare('dateTo', 'datrFrom', CompareOption.greaterOrEqual)],),
      'accessType' : FormControl<String>(value: "INCOME"),
    });

      return Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text("Filters"),
              ),
            ),
            Flexible(
              child: ReactiveFormBuilder(
                form: () => form,
                builder: (context, form, child) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ReactiveTextField(
                          formControlName: "fulltext",
                          decoration: InputDecoration(
                            labelText: "Search",
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                          ),
                          maxLines: 1,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ReactiveDatePicker(
                          formControlName: "dateFrom",
                          firstDate: DateTime(2021),
                          lastDate: DateTime.now().add(Duration(days: 1)),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          locale: Locale.fromSubtags(languageCode: 'es'),
                          builder: (context, picker, child) {
                            return ReactiveTextField(
                              formControlName: "dateFrom",
                              onTap: picker.showPicker,
                              readOnly: true,
                              valueAccessor: DateTimeValueAccessor(dateTimeFormat: DateFormat('dd-MM-yyyy')),
                              validationMessages: (control) => {
                                ValidationMessage.required: 'Field is required',
                                ValidationMessage.max: 'Date must be lower than today',
                              },
                              decoration: InputDecoration(
                                labelText: "Start Date",
                                prefixIcon: Icon(Icons.event_available),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ReactiveDatePicker(
                          formControlName: "dateTo",
                          firstDate: DateTime(2021, 1, 1),
                          lastDate: DateTime.now().add(Duration(days: 1)),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          locale: Locale.fromSubtags(languageCode: 'es'),
                          builder: (context, picker, child) {
                            return ReactiveTextField(
                              formControlName: "dateTo",
                              onTap: picker.showPicker,
                              readOnly: true,
                              valueAccessor: DateTimeValueAccessor(dateTimeFormat: DateFormat('dd-MM-yyyy')),
                              validationMessages: (control) => {
                                ValidationMessage.required: 'Field is required',
                                ValidationMessage.max: 'Date must be lower than tomorrow',
                                ValidationMessage.compare: 'Date must be greater or equal than Start Date',
                              },
                              decoration: InputDecoration(
                                labelText: "End Date",
                                prefixIcon: Icon(Icons.event_busy),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ReactiveDropdownField<String>(
                            items: ["INCOME", "PAYMENT"]
                                .map(
                                  (e) => DropdownMenuItem(
                                value: e.toUpperCase(),
                                child: Text(e.toUpperCase()),
                              ),
                            )
                                .toList(),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                ),
                                labelText: 'Transaction Type'),
                            formControlName: 'accessType'),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _onCancel(context),
                                  child: Text("Cancel"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).accentColor),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: form.valid
                                      ? () => _onCancel(context)
                                      : () {form.markAllAsTouched();},
                                  child: Text("Confirm")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }
}