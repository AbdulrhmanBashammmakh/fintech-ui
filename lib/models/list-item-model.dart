class ListItemModel {
  final String no;
  final String name;
  final bool? statusFlag;

  ListItemModel({
    this.no = '',
    this.name = '',
    this.statusFlag,
  });

  bool isEqual(ListItemModel? model) {
    return no == model?.no;
  }

  @override
  String toString() {
    return '$no'.toString();
  }
}
