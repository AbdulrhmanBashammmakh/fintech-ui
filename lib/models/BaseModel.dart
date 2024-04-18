class BaseModel {
  final int id;
  final String name;
  BaseModel({required this.id, required this.name});
  bool isEqual(BaseModel? model) {
    return id == model?.id;
  }
}
