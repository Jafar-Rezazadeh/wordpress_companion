import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../core_export.dart';

class TimezoneDropdown extends StatefulWidget {
  final String? initialTimeZone;
  final String selectHint;
  final String searchHint;
  final Function(String timeZone) onTimezoneSelected;

  const TimezoneDropdown({
    super.key,
    required this.selectHint,
    required this.searchHint,
    required this.onTimezoneSelected,
    this.initialTimeZone,
  });

  @override
  TimezoneDropdownState createState() => TimezoneDropdownState();
}

class TimezoneDropdownState extends State<TimezoneDropdown> {
  String? selectedZone;
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedZone = widget.initialTimeZone?.isNotEmpty == true
        ? widget.initialTimeZone
        : null;
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: _hintText(),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.expand_more),
        ),
        items: allTimezones
            .map((item) =>
                DropdownMenuItem(value: item, child: _dropDownItem(item)))
            .toList(),
        value: selectedZone,
        onChanged: _onChanged,
        buttonStyleData: _dropDownButtonStyle(),
        dropdownStyleData: const DropdownStyleData(maxHeight: 200),
        menuItemStyleData: const MenuItemStyleData(height: 40),
        dropdownSearchData: _dropDownSearchData(),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchTextEditingController.clear();
          }
        },
      ),
    );
  }

  Text _hintText() {
    return Text(
      widget.selectHint,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),
    );
  }

  Text _dropDownItem(String item) {
    return Text(
      item,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  void _onChanged(String? value) {
    if (value == null) {
      return;
    }
    widget.onTimezoneSelected(value);
    setState(() => selectedZone = value);
  }

  ButtonStyleData _dropDownButtonStyle() {
    return ButtonStyleData(
      padding:
          const EdgeInsets.symmetric(horizontal: edgeToEdgePaddingHorizontal),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      height: 40,
      width: 200,
    );
  }

  DropdownSearchData<String> _dropDownSearchData() {
    return DropdownSearchData(
      searchController: searchTextEditingController,
      searchInnerWidgetHeight: 50,
      searchInnerWidget: Container(
        height: 50,
        padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
        child: TextField(
          expands: true,
          maxLines: null,
          controller: searchTextEditingController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            hintText: widget.searchHint,
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorPallet.border),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value.toString().toLowerCase().contains(searchValue);
      },
    );
  }
}
