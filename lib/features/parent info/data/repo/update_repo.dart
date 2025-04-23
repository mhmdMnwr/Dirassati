import 'package:dirasati/core/Networking/api_error_handler.dart';
import 'package:dirasati/core/Networking/api_result.dart';
import 'package:dirasati/core/Networking/api_service.dart';
import 'package:dirasati/core/helpers/constants.dart';
import 'package:dirasati/core/helpers/shared_pref_helper.dart';
import 'package:dirasati/features/choose%20son/data/model/get_me_response.dart';
import 'package:dirasati/features/parent%20info/data/model/update_parent_request.dart';

class UpdateRepo {
  final ApiService apiService;
  UpdateRepo(this.apiService);

  Future<ApiResult<GetMeResponse>> updateParent(
      UpdateParentRequest updatedParent) async {
    final parentIdFuture = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.parentId,
    );

    try {
      final response =
          await apiService.updateParent(parentIdFuture, updatedParent);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
