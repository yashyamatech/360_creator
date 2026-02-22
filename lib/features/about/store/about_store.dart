import 'package:mobx/mobx.dart';
import '../../../config/supabase_config.dart';
import '../../../config/app_constants.dart';
import '../../../data/models/agency_info_model.dart';

part 'about_store.g.dart';

class AboutStore = _AboutStore with _$AboutStore;

abstract class _AboutStore with Store {
  _AboutStore();

  @observable
  AgencyInfo? agencyInfo;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @computed
  bool get hasInfo => agencyInfo != null;

  @action
  Future<void> fetchAgencyInfo() async {
    try {
      isLoading = true;
      error = null;

      try {
        final response = await SupabaseConfig.client
            .from(AppConstants.agencyInfoTable)
            .select()
            .single();

        agencyInfo = AgencyInfo.fromJson(response as Map<String, dynamic>);
      } catch (e) {
        // Fall back to placeholder data if Supabase is not configured
        agencyInfo = AgencyInfo.placeholder;
      }
    } catch (e) {
      error = 'Failed to load agency information.';
      agencyInfo = AgencyInfo.placeholder;
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    error = null;
  }
}
