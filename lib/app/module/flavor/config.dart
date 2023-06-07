class Config{
  final String baseUrl;
  final bool isDemo;
  final bool shouldCollectCrashLog;
  final String webPushBaseUrl;
  final String clientSecret;
  final String keyClockClientId;

  Config({
    required this.baseUrl,
    required this.isDemo,
    this.shouldCollectCrashLog = false,
    required this.webPushBaseUrl,
    required this.clientSecret,
    required this.keyClockClientId,
  });
}