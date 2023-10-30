abstract class BaseRepository<T, N> {
  Future<List<T>> getAll();
  Future<N> getById(String id);
  Future<bool> add(T data);
  Future<bool> update(T data);
  Future<bool> delete(String id);
}
