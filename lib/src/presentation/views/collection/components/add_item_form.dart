import 'package:flutter/material.dart';

import '../../../shared/utils/color.dart';
import '../../../shared/utils/font.dart';
import '../../../shared/utils/utils.dart';
import 'item_type_selector.dart';

class AddItemForm extends StatelessWidget {
  AddItemForm({
    Key? key,
  }) : super(key: key);

  final _nameController = TextEditingController();
  final _storyController = TextEditingController();
  final _itemTypeController = ItemTypeController();
  final _file = "https://wwww.google.com";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: constraints.maxHeight * 0.04,
              horizontal: constraints.maxWidth * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Item",
                style: FontUtils.textStyle,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.04,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _form(),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.04,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  // TODO: Enabled only if creating Folder/ File is Selected
                  Navigator.of(context).pop(
                    {
                      "id":
                          'temp_${DateTime.now().millisecondsSinceEpoch}',
                      "name": _nameController.text,
                      "type": _itemTypeController.value.name,
                      "story": _storyController.text,
                      "file": _file,
                    },
                  );
                },
                backgroundColor: ColorUtils.primary,
                label: Text(
                  "     Save     ",
                  style: FontUtils.textStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _form() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text("Name : ", style: FontUtils.textStyle),
            Expanded(
              child: TextField(
                  controller: _nameController,
                  decoration: Utils.inputDecoration),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text("Type : ", style: FontUtils.textStyle),
            Expanded(
              child: ItemSelector(_itemTypeController),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "File : ",
              style: FontUtils.textStyle,
            ),
            const Expanded(
              child: TextField(decoration: Utils.inputDecoration),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Story : ",
              style: FontUtils.textStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 6,
          controller: _storyController,
          decoration: Utils.inputDecoration,
        ),
      ],
    );
  }
}
