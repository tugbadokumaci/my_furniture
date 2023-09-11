abstract class BaseModel {
  Map<String, dynamic> toJson();
  T fromJson<T>(Map<String, dynamic> json);
}
