class DI {
  // Singleton instance
  static final DI _instance = DI._internal();

  factory DI() => _instance;

  DI._internal();

  // Store for registered services
  final Map<Type, dynamic> _services = {};

  // Register a singleton service
  void registerSingleton<T>(T instance) {
    _services[T] = instance;
  }

  // Register a factory that creates a new instance every time
  void registerFactory<T>(T Function() factory) {
    _services[T] = factory;
  }

  // Retrieve a registered service
  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception("Service of type $T not registered.");
    }

    if (service is T Function()) {
      return service();
    } else {
      return service as T;
    }
  }
}
