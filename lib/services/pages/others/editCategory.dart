import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';

class EditCategory extends StatefulWidget {
  EditCategory({Key? key, required this.editCategory, required this.category}) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
  final Function editCategory;
  final Category category;
}

class _EditCategoryState extends State<EditCategory> {
  late final oldName;
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    oldName = widget.category.name;
    _nameController.text = oldName;
    super.initState();
  }

  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Category'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              AddTextField(
                label: 'name',
                controller: _nameController,
                keyNumber: false,
                icon: Icon(Icons.category),
              ),
              const Gap(50),
              AuthButton(
                buttonText: 'Save',
                fun: () {
                  widget.editCategory(_nameController.text, widget.category);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
