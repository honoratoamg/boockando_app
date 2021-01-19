import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';
import 'package:boockando_app/app/repositories/shared/themes/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_user_controller.dart';

class UserConfigsController extends ChangeNotifier {
  // Atributos da classe
  AppThemesEnum _userTheme = AppThemesEnum.system;
  double _fontSize = 19.5;
  final double defaultFontSize = 19.5;

  // Construtor da classe
  UserConfigsController();

  // Metodos da classe
  changeTheme({AppThemesEnum theme, BuildContext context}) {
    // Escolha sistema
    if (theme == AppThemesEnum.system) {
      // Primeiro verifica alto contraste
      (MediaQuery.of(context).highContrast == true)
          ? userTheme = AppThemesEnum.highContrast
          :
          // Depois verifica claro/escuro
          (MediaQuery.platformBrightnessOf(context) == Brightness.light)
              ? userTheme = AppThemesEnum.lightTheme
              : userTheme = AppThemesEnum.darkTheme;
      return;
    }

    userTheme = theme;
  }

  // Gets e Sets
  AppThemesEnum get userTheme => _userTheme;

  set userTheme(AppThemesEnum value) {
    _userTheme = value;
    notifyListeners();
  }

  double get fontSize => _fontSize;
  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
  }

  initializeConfigs(int userId) async {
    final appUserController = Modular.get<AppUserController>();

    await SharedPrefs.contains(
            "User[${appUserController.loggedUser.id}][Theme]")
        .then((value) async {
      if (value) {
        await SharedPrefs.read(
                "User[${appUserController.loggedUser.id}][Theme]")
            .then((value) {
          switch (value) {
            case 'lightTheme':
              _userTheme = AppThemesEnum.system;
              break;
            case 'darkTheme':
              _userTheme = AppThemesEnum.darkTheme;
              break;
            case 'highContrast':
              _userTheme = AppThemesEnum.highContrast;
              break;
            case 'system':
              _userTheme = AppThemesEnum.system;
              break;
            default:
              _userTheme = AppThemesEnum.lightTheme;
              break;
          }
        });
      } else {
        _userTheme = AppThemesEnum.system;
      }
    });

    await SharedPrefs.contains(
            "User[${appUserController.loggedUser.id}][FontSize]")
        .then((value) async {
      if (value) {
        await SharedPrefs.read(
                "User[${appUserController.loggedUser.id}][FontSize]")
            .then((value) {
          _fontSize = double.parse(value);
        });
      } else {
        _fontSize = defaultFontSize;
      }
    });

    notifyListeners();
  }
}
