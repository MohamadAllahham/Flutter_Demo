import 'package:flutter_common/network/api_service.dart';
import 'package:flutter_common/network/browser_service.dart';

class LegalitiesService {
  final ApiService apiService;
  final BrowserService browserService;

  LegalitiesService(this.browserService, this.apiService);

  Future<void> viewPrivacyPolicy() async {
    await browserService.tryLaunchUrl(apiService.url('privacy-policy.pdf'));
  }

  Future<void> viewGeneralBusinessTerms() async {
    await browserService
        .tryLaunchUrl(apiService.url('general-business-terms.pdf'));
  }
}
