import 'config.dart';

class FlavorConfig {
  late Flavor flavor;
  late Config config;
  bool _lock = false;

  static final FlavorConfig instance = FlavorConfig._internal();

  FlavorConfig._internal();

  factory FlavorConfig({required Flavor flavor, required Config config}) {
    if(instance._lock) {
      return instance;
    }

    instance.flavor = flavor;
    instance.config = config;
    instance._lock = true;

    return instance;
  }

}

enum Flavor{
  dev, uat, prod, qa
}