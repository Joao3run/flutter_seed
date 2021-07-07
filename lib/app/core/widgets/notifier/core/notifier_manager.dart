import './notifier_future.dart';

class NotifierManager {
  static NotifierManager? _instance;

  NotifierManager._();

  factory NotifierManager() {
    _instance ??= NotifierManager._();
    return _instance!;
  }

  Set<NotifierFuture> NotifierSet = Set();

  void dismissAll({bool showAnim = false}) {
    NotifierSet.toList().forEach((v) {
      v.dismiss(showAnim: showAnim);
    });
  }

  void removeFuture(NotifierFuture future) {
    NotifierSet.remove(future);
  }

  void addFuture(NotifierFuture future) {
    NotifierSet.add(future);
  }
}
