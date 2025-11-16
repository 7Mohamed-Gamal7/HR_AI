/// واجهة عامة للمستودعات لتوحيد أساليب الوصول للبيانات
abstract class BaseRepository<T> {
  Future<List<T>> list({Map<String, dynamic>? query});
  Future<T> getById(String id);
  Future<T> create(T item);
  Future<T> update(String id, T item);
  Future<void> delete(String id);
}