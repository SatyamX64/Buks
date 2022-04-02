import 'package:biblio/src/presentation/shared/utils/font.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/color.dart';

enum ItemType { book, collection }

class ItemTypeController {
  ItemType _type;

  ItemTypeController() : _type = ItemType.book;

  ItemType get value => _type;

  set update(ItemType type) {
    _type = type;
  }
}

class ItemSelector extends StatefulWidget {
  const ItemSelector(this.controller, {Key? key}) : super(key: key);

  final ItemTypeController controller;
  @override
  _ItemSelectorState createState() => _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector> {
  late var selectedType = widget.controller.value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton.icon(
          label: Text("Book", style: FontUtils.textStyle),
          icon: Icon(
              widget.controller.value != ItemType.book
                  ? Icons.circle
                  : Icons.trip_origin,
              color: ColorUtils.primary),
          onPressed: () {
            setState(() {
              widget.controller.update = ItemType.book;
            });
          },
        ),
        const Spacer(),
        TextButton.icon(
          label: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Folder",
              style: FontUtils.textStyle,
            ),
          ),
          icon: Icon(
              widget.controller.value != ItemType.collection
                  ? Icons.circle
                  : Icons.trip_origin,
              color: ColorUtils.primary),
          onPressed: () {
            setState(() {
              widget.controller.update = ItemType.collection;
            });
          },
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
