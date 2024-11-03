
enum Flavor { STAGING, PRODUCTION }

class EnvironmentConfig {
  static EnvironmentConfig instance = EnvironmentConfig();
  Flavor flavor = Flavor.STAGING;
}