import 'package:base_project/utils/utils.dart';

import '../../data/response/resolution_response.dart';
import '../entities/resolution_model.dart';

extension ResolutionTranslator on ResolutionResponse {
  ResolutionModel toResolutionModel() => ResolutionModel(
        id: id ?? Utils.generateId,
        cveId: cveId ?? '',
        resolution: resolution
                ?.map(
                  (e) => ResolutionInfoModel(
                    id: e.id ?? Utils.generateId,
                    createdBy: e.createdBy ?? '',
                    description: e.description ?? '',
                  ),
                )
                .toList() ??
            [],
      );
}
