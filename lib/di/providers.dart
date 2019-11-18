import 'package:flutter_workshop/domain/repository/point_repository.dart';
import 'package:flutter_workshop/network/api_service.dart';
import 'package:provider/provider.dart';

final providers = <SingleChildCloneableWidget>[
  Provider.value(value: ApiService()),
  ProxyProvider<ApiService, PointRepository>(
    builder: (_, service, __) => PointRepository(service),
  )
];
