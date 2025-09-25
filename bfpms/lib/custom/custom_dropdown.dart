import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';

DropdownButtonFormField<String> customDropdown({
  required bool isDisabled,
  required String labelText,
  required List items,
  required String? selectedValue,
  required ValueChanged<String?> onChanged,
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),

    items: items.map((item) {
      return DropdownMenuItem(
        value: item['value'].toString(),
        child: AutoSizeText(
          item['text'].toString(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          maxFontSize: 16,
          maxLines: 2,
        ),
      );
    }).toList(),
    value: selectedValue,
    onChanged: isDisabled ? null : onChanged,
    validator: validator,
    isExpanded: true,
    focusNode: FocusNode(),
    icon: Icon(
      Icons.arrow_drop_down,
      color: items.isEmpty || isDisabled ? Colors.grey : Colors.black,
    ),
    dropdownColor: Colors.white,
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );
}
