abstract class BaseRepository<T, N> {
  Future<List<T>> getAll();
  Future<N> getById(String id);
  Future<List<T>> add(T data);
  Future<List<T>> update(T data);
  Future<List<T>> delete(String id);
}
