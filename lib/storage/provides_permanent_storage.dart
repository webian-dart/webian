import 'manages_preferences.dart';

abstract class ProvidesPermanentStorage {
    ManagesPreferencesStorage get preferences;
}