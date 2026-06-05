enum Flavor {
  dev,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'dev';
      case Flavor.prod:
        return 'prod';
    }
  }

  static String get apiKey{
    switch (appFlavor) {
      case Flavor.dev:
        return 'G3XERFPWBV856BAN5HFGME434';
      case Flavor.prod:
        return 'G3XERFPWBV856BAN5HFGME434';
    }
  }

  static String get baseUrl{
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';
      case Flavor.prod:
        return 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline';
    }
  }

}
