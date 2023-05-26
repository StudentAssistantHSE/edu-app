enum Environment {
  test,
  dev,
  production,
}

extension EnvironmentConverter on Environment {
  String get asString {
    switch (this) {
      case Environment.test:
        return 'test';
      case Environment.dev:
        return 'dev';
      case Environment.production:
        return 'production';
    }
  }

  static Environment? fromString(String target) {
    switch (target.toLowerCase()) {
      case 'test':
        return Environment.test;
      case 'dev':
        return Environment.dev;
      case 'production':
        return Environment.production;
      default:
        return null;
    }
  }
}