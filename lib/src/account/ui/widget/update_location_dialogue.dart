import 'package:flutter/material.dart';
import 'package:ocad/src/auth/ui/widget/cuistom_text_field.dart';

class UpdateLocationDialogue extends StatelessWidget {
  UpdateLocationDialogue({super.key});
  final TextEditingController locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text("Update Location"),
        content: CustomTextField(
          enabledBorderColor: Colors.grey,
          focusedBorderColor: Colors.brown,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Location cannot be empty";
            }
            return null;
          },
          controller: locationController,
          hintText: "Enter your location",
          keyboardType: TextInputType.text,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
              // Navigator.of(context).pop();
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
