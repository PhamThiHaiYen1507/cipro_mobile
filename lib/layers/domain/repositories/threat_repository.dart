import 'package:base_project/layers/domain/entities/threat_model.dart';

import '../../../core/type_def/api_response_data.dart';

abstract class ThreatRepository {
  Future<ApiResponseData<bool>> createNewThreat({
    required String name,
    required String description,
    required String type,
    required double total,
    required int damage,
    required int reproducibility,
    required int exploitability,
    required int affectedUsers,
    required int discoverability,
  });

  Future<ApiResponseData<List<ThreatModel>>> getThreats();
}
