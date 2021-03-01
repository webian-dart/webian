

abstract class ManagesPreferencesStorage {
    
    Future save(String key, String value);
    
    Future<String> get(String key);
    
    Future clear();

    Future remove(String key);
}