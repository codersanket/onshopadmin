import 'dart:io';

import 'package:admin/Controllers/categoryControllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class addCategory extends StatelessWidget {
  TextEditingController categoryName = TextEditingController();

  CategoryControllers categoryControllers = Get.put(CategoryControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add Category".text.make(),
      ),
      body: Container(
        child: VStack(
          [
            TextField(
              controller: categoryName,
              decoration: InputDecoration(
                labelText: "Category Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ).p8(),
            GetX<CategoryControllers>(builder: (controller) {
              if (controller.image.value.path.isNotEmpty) {
                return Image.file(File(controller.image.value.path))
                    .box
                    .height(200)
                    .make();
              } else
                return Container();
            }),
            RaisedButton(
              onPressed: () => categoryControllers.removeImage(),
              child: "Remove Image".text.make(),
            ).centered(),
            RaisedButton(
              onPressed: () => categoryControllers.chooseFile(),
              child: "Select Image".text.make(),
            ).centered(),
            Obx(
              () => RaisedButton(
                onPressed: () => categoryControllers.addToDb(categoryName.text),
                child: categoryControllers.loading.value == true
                    ? "Loading".text.make()
                    : "Add Category".text.make(),
              ).centered(),
            )
          ],
        ).centered(),
      ),
    );
  }
}
