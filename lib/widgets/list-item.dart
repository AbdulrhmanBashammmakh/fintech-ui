import 'package:dropdown_search/dropdown_search.dart';
import 'package:fintech/views/Sales/newSaleController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../endPoint/send-req.dart';
import '../models/Models.dart';
import '../models/list-item-model.dart';
import '../utils/AColors.dart';

class ListItem extends StatelessWidget {
  final Future<ResponseObject>? future;
  final SaleController controller;
  final String lang;
  final bool enabled;
  final bool mndtry;
  final String label;
  final onChanged;
  final onSaved;
  final selectedItem;
  final validator;
  final bool clearBtn;
  final bool showSearchBox;
  final bool? showStatusFlag;
  final bool multiSelection;
  final clearButtonPressed;

  final _editTextController = TextEditingController();
  final _multiKey = GlobalKey<DropdownSearchState<String>>();

  ListItem({
    Key? key,
    required this.future,
    required this.lang,
    required this.enabled,
    required this.mndtry,
    required this.label,
    required this.onChanged,
    required this.controller,
    required this.onSaved,
    required this.selectedItem,
    required this.validator,
    required this.clearBtn,
    this.showSearchBox = false,
    this.showStatusFlag,
    this.multiSelection = false,
    this.clearButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getContainer();
  }

  Widget getContainer() {
    return FutureBuilder<ResponseObject>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data!.data.mainStock;
            List<MainStock> uList = list!.map((e) {
              MainStock model = MainStock(
                  barcode: e.barcode,
                  createdAt: e.createdAt,
                  cateId: e.cateId,
                  code: e.code,
                  cate: e.cate,
                  qty: e.qty,
                  unit: e.unit,
                  cost: e.cost,
                  lastBuy: e.lastBuy,
                  salePrice: e.salePrice,
                  product: e.product,
                  id: e.id);
              return model;
            }).toList();
            List<dynamic> sList = list.map((e) {
              String no = e.code;
              String name = e.product;
              bool? status;
              ListItemModel model =
                  ListItemModel(no: no, name: name, statusFlag: status);
              return model;
            }).toList();
            controller.setMainList(uList.toList());
            if (list.isEmpty) {
              return getDropdown(null);
            }
            return getDropdown(sList);
          } else if (snapshot.hasError) {
            return getDropdown(null);
          }

          return getDropdown(null);
        });
  }

  getDropdown(sList) {
    if (multiSelection) return multiSelectionDropDown(sList);

    return DropdownSearch<dynamic>(
      onChanged: onChanged,
      compareFn: (i, s) => i?.isEqual(s) == null ? false : i.isEqual(s),
      enabled: enabled,
      selectedItem: selectedItem,
      items: sList ?? [],
      dropdownBuilder: listItem,
      itemAsString: showSearchBox ? itemAsString : null,
      dropdownSearchDecoration:
          InputDecoration(labelText: '${label.tr} ' + (mndtry ? ' *' : '')),
      onSaved: onSaved,
      popupProps: PopupProps.dialog(
        showSelectedItems: true,
        dialogProps: DialogProps(elevation: 10),
        itemBuilder: listItemBuilder,
        showSearchBox: showSearchBox,
        searchFieldProps: showSearchBox
            ? TextFieldProps(
                controller: _editTextController,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: InputDecoration(
                  labelText: 'search-field'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      _editTextController.clear();
                    },
                  ),
                ),
              )
            : TextFieldProps(),
      ),
      dropdownButtonProps: IconButtonProps(
        icon: Icon(Icons.arrow_drop_down, color: constPrimaryColor),
        splashRadius: 1,
      ),
      showClearButton: clearBtn,
      clearButtonProps:
          IconButtonProps(icon: Icon(Icons.clear), splashRadius: 1),
      validator: validator,
    );
  }

  String itemAsString(var item) => "${item.no} - ${item.name}";

  Widget listItem(BuildContext context, var item) {
    String selectItem = 'select-a-item';
    var no;
    var name;
    bool? status;

    if (item is ListItemModel) {
      no = item.no;
      name = item.name;
      status = item.statusFlag;
    }

    if (label == 'product' || label == 'copy-from-user-name') {
      selectItem = 'select-a-item';
    }

    return Container(
      child: (no == null || no == 0 || no == '0' || no == '')
          ? Text(selectItem.tr)
          : ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${no} - ${name}"),
                  status == null
                      ? Container()
                      : status
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.do_not_disturb_on, color: Colors.red)
                ],
              ),
            ),
    );
  }

  Widget listItemBuilder(BuildContext context, var item, bool isSelected) {
    var no;
    var name;
    bool? status;

    if (item is ListItemModel) {
      no = item.no;
      name = item.name;
      status = item.statusFlag;
    }

    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${no} - ${name}"),
            status == null
                ? Container()
                : status
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.do_not_disturb_on, color: Colors.red)
          ],
        ),
      ),
    );
  }

  Widget multiSelectionDropDown(List<ListItemModel>? list) {
    return DropdownSearch<ListItemModel>.multiSelection(
      key: _multiKey,
      items: list ?? [],
      enabled: enabled,
      onChanged: onChanged,
      onSaved: onSaved,
      selectedItems: selectedItem,
      compareFn: (i, s) => i.no == s.no,
      itemAsString: showSearchBox ? itemAsString : null,
      validator: validator,
      popupProps: PopupPropsMultiSelection.dialog(
        showSelectedItems: true,
        popupSelectionWidget: (cnt, ListItemModel item, bool isSelected) {
          return isSelected
              ? Icon(Icons.check_circle, color: Colors.green)
              : Container();
        },
        // popupCustomMultiSelectionWidget: optionButtons,
        showSearchBox: showSearchBox,
        searchFieldProps: showSearchBox
            ? TextFieldProps(
                controller: _editTextController,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: InputDecoration(
                  labelText: 'search-field'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      _editTextController.clear();
                    },
                  ),
                ),
              )
            : TextFieldProps(),
        dialogProps: DialogProps(elevation: 10),
      ),
      dropdownBuilder: (context, List<ListItemModel>? selectedItems) {
        Widget item(ListItemModel i) => multiSelectionBuilder(i);
        if (selectedItems != null)
          selectedItems.removeWhere((e) => e.no == '' || e.no == '0');
        if (selectedItems == null || selectedItems.isEmpty)
          return Text('select-option'.tr);
        return Wrap(children: selectedItems.map((e) => item(e)).toList());
      },
      dropdownSearchDecoration:
          InputDecoration(labelText: '${label.tr} ' + (mndtry ? ' *' : '')),
      dropdownButtonProps: IconButtonProps(
        icon: Icon(Icons.arrow_drop_down, color: constPrimaryColor),
        splashRadius: 1,
      ),
      showClearButton: clearBtn,
      clearButtonProps:
          IconButtonProps(icon: Icon(Icons.clear), splashRadius: 15),
      // clearButtonPressed: clearButtonPressed,
    );
  }

  Widget multiSelectionBuilder(ListItemModel i) {
    return Container(
      height: 32,
      padding: EdgeInsets.only(left: 6),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(i.no.toString(), textAlign: TextAlign.center),
          /*MaterialButton(
            height: 20,
            shape: CircleBorder(),
            padding: EdgeInsets.all(0),
            color: Colors.red[200],
            minWidth: 20,
            onPressed: () => _multiKey.currentState?.removeItem(i),
            child: Icon(Icons.close_outlined, size: 18),
          )*/
        ],
      ),
    );
  }

  Widget optionButtons(BuildContext context, List list) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: OutlinedButton(
            onPressed: () {
              _multiKey.currentState?.closeDropDownSearch();
            },
            child: Text('cancel'.tr),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: OutlinedButton(
            onPressed: () {
              _multiKey.currentState?.popupSelectAllItems();
            },
            child: Text('select-all'.tr),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: OutlinedButton(
            onPressed: () {
              _multiKey.currentState?.popupDeselectAllItems();
            },
            child: Text('unselect-all'.tr),
          ),
        ),
      ],
    );
  }
}
