import 'package:di/di.dart';
import 'package:flutter_test/flutter_test.dart';

class ServiceA {
  final String name;
  ServiceA(this.name);
}

class ServiceB {
  final int value;
  ServiceB(this.value);
}

void main() {
  group('Dependency Injection Tests', () {
    late DI di;

    setUp(() {
      di = DI(); // Reset the DI instance before each test
    });

    test('Register and retrieve singleton service', () {
      final serviceA = ServiceA('SingletonA');
      di.registerSingleton<ServiceA>(serviceA);

      final retrievedServiceA = di.get<ServiceA>();

      expect(retrievedServiceA, equals(serviceA));
    });

    test('Singleton service returns the same instance', () {
      final serviceA1 = ServiceA('SingletonA1');
      di.registerSingleton<ServiceA>(serviceA1);

      final serviceA2 = di.get<ServiceA>();

      expect(identical(serviceA1, serviceA2), isTrue);
    });

    test('Register and retrieve factory service', () {
      di.registerFactory<ServiceB>(() => ServiceB(42));

      final serviceB1 = di.get<ServiceB>();
      final serviceB2 = di.get<ServiceB>();

      expect(serviceB1.value, equals(42));
      expect(serviceB2.value, equals(42));
      expect(identical(serviceB1, serviceB2), isFalse);
    });

    test('Exception thrown when retrieving unregistered service', () {
      expect(() => di.get<String>(), throwsA(isA<Exception>()));
    });

    test('Factory service creates a new instance every time', () {
      di.registerFactory<ServiceB>(() => ServiceB(100));

      final serviceB1 = di.get<ServiceB>();
      final serviceB2 = di.get<ServiceB>();

      expect(serviceB1.value, equals(100));
      expect(serviceB2.value, equals(100));
      expect(identical(serviceB1, serviceB2), isFalse);
    });

    test('Overwriting a registered singleton', () {
      final serviceA1 = ServiceA('FirstInstance');
      di.registerSingleton<ServiceA>(serviceA1);

      final serviceA2 = ServiceA('SecondInstance');
      di.registerSingleton<ServiceA>(serviceA2); // Overwrite

      final retrievedServiceA = di.get<ServiceA>();

      expect(retrievedServiceA, equals(serviceA2));
    });

    test('Overwriting a registered factory', () {
      di.registerFactory<ServiceB>(() => ServiceB(200));
      di.registerFactory<ServiceB>(() => ServiceB(300)); // Overwrite

      final serviceB = di.get<ServiceB>();

      expect(serviceB.value, equals(300));
    });
  });
}
