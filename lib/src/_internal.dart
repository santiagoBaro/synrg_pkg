import 'package:synrg/synrg.dart';
import 'package:uuid/uuid.dart';

///
Future<void> setUserId({String? id}) async {
  if (id == null) {
    final uuid = const Uuid().v4();
    SynrgCrashlytics.instance.setUserIdentifier('anonyms-$uuid');
    await SynrgAnalytics.instance.setUserId('anonyms-$uuid');
  } else {
    SynrgCrashlytics.instance.setUserIdentifier(id);
    await SynrgAnalytics.instance.setUserId(id);
  }
}
