import 'package:hive_ce/hive.dart';

import '../../features/movies/data/models/movie_hive_model.dart';

@GenerateAdapters([AdapterSpec<MovieHiveModel>()])
part 'hive_adapters.g.dart';
