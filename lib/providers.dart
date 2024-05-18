import 'package:myportfolio/viewmodels/aboutviewmodel.dart';
import 'package:myportfolio/viewmodels/homeViewModel.dart';
import 'package:provider/provider.dart';

class ProviderConfigs {
  List<ChangeNotifierProvider> get providerlist => [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<AboutViewModel>(
          create: (_) => AboutViewModel(),
        ),
      ];
}
