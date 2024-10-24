abstract class UserRepository {
  Future<void> saveUser(String name, String email, String password);
  Future<Map<String, String>?> getUser(String email);
  Future<void> updateUser(String name, String email); // Додано метод для оновлення
}
