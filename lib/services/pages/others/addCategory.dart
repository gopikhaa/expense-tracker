import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key? key, required this.addCategory}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
  final Function addCategory;
}

class _AddCategoryState extends State<AddCategory> {
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Category'),
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
                  Category category = Category(name: _nameController.text);
                  widget.addCategory(category);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
