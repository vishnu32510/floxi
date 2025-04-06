import 'package:floxi/core/services/services.dart';
import 'package:floxi/core/utils/app_constants.dart';
import 'package:floxi/models/bar_code_model.dart';
import 'package:floxi/models/dasboard_model.dart';

class DashboardViewModel {
  Future<DashboardModel> getDashboardData() async {

    final String url = '${AppConstants.baseUrl}/dashboard/${AppConstants.username}';
    var response = await HttpServices().getMethod(url);
    if (response != null ) {
      DashboardModel dashboardModel = DashboardModel.fromJson(response);
        return dashboardModel;
      } else if (response is ServiceError) {
        throw Exception('Error: ${response.toString()}');
      } else {
        throw Exception('Unknown error occurred');
      }
  }
  Future<BarCodeModel> getBarCodeData({required String barcode}) async {

    final String url = '${AppConstants.baseUrl}/scan/$barcode';
    var response = await HttpServices().getMethod(url);
    if (response != null ) {
      BarCodeModel barCodeModel = BarCodeModel.fromJson(response);
        return barCodeModel;
      } else if (response is ServiceError) {
        throw Exception('Error: ${response.toString()}');
      } else {
        throw Exception('Unknown error occurred');
      }
  }
}
