import 'package:go_router/go_router.dart';
import 'package:proyecto_reconocimiento/view/screens/appliance_screen.dart';
import 'package:proyecto_reconocimiento/view/screens/batery_screen.dart';
import 'package:proyecto_reconocimiento/view/screens/cell_screen.dart';
import 'package:proyecto_reconocimiento/view/screens/computer_screen.dart';
import 'package:proyecto_reconocimiento/view/screens/other_screen.dart';
import 'package:proyecto_reconocimiento/view/screens/pick_image_screen.dart';



// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: PickImageScreen.name,
      builder: (context, state) => const PickImageScreen(),
    ),
    GoRoute(
      path: '/battery',
      name: BatteryScreen.name,
      builder: (context, state) => const BatteryScreen(),
    ),
    GoRoute(
      path: '/appliance',
      name: ApplianceScreen.name,
      builder: (context, state) => const ApplianceScreen(),
    ),
    GoRoute(
      path: '/cell',
      name: CellScreen.name,
      builder: (context, state) => const CellScreen(),
    ),
    GoRoute(
      path: '/computer',
      name: ComputerScreen.name,
      builder: (context, state) => const ComputerScreen(),
    ),
    GoRoute(
      path: '/other',
      name: OtherScreen.name,
      builder: (context, state) => const OtherScreen(),
    ),
  ],
);
