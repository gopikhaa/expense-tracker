import 'package:flutter/material.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/others/editCategory.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.category,
      required this.removeCategory,
      required this.editCate})
      : super(key: key);
  final Category category;
  final Function removeCategory;
  final Function editCate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Text(category.name),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCategory(
                            editCategory: editCate, category: category),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    removeCategory(category);
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
