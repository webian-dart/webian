import '../application/application.dart';
import 'activity.dart';

class DoNothingActivity extends Activity {
  DoNothingActivity(Application application) : super(application);

  @override
  Future start() {
      return Future.value(null);
  }
  
}