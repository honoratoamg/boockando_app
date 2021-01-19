import 'package:boockando_app/app/controllers/app_user_configs_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';
import 'package:boockando_app/app/repositories/shared/themes/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChangeThemeWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ChangeThemeWidget> {
  final settings = Modular.get<UserConfigsController>();
  Map<AppThemesEnum, String> themeDescriptionMap = {
    AppThemesEnum.system: "System theme",
    AppThemesEnum.lightTheme: "Light Theme",
    AppThemesEnum.darkTheme: "Dark Theme",
    AppThemesEnum.highContrast: "Improves distinction",
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<UserConfigsController>(
      builder: (context, value) {
        return Card(
          child: ListTile(
            title: Text('Theme'),
            subtitle: Text(themeDescriptionMap[settings.userTheme]),
            trailing: LightDarkThemeDropDownButton(),
          ),
        );
      },
    );
  }
}

/// Dropdown Widget
class LightDarkThemeDropDownButton extends StatefulWidget {
  LightDarkThemeDropDownButton({Key key}) : super(key: key);

  @override
  LightDarkThemeDropDownButtonState createState() =>
      LightDarkThemeDropDownButtonState();
}

/// Dropdown widget
class LightDarkThemeDropDownButtonState
    extends State<LightDarkThemeDropDownButton> {
  List<String> values = [
    'System',
    'Light Theme',
    'Dark Theme',
    'High Contrast'
  ];
  String dropdownValue = 'System';
  final settings = Modular.get<UserConfigsController>();

  @override
  Widget build(BuildContext context) {
    final appUserController = Modular.get<AppUserController>();

    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.more_vert),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String newValue) async {
        dropdownValue = newValue;
        AppThemesEnum theme;
        switch (newValue) {
          case 'System':
            theme = AppThemesEnum.system;
            await SharedPrefs.save(
                "User[${appUserController.loggedUser.id}][Theme]", "system");
            break;
          case 'Dark Theme':
            theme = AppThemesEnum.darkTheme;
            await SharedPrefs.save(
                "User[${appUserController.loggedUser.id}][Theme]", "darkTheme");
            break;
          case 'High Contrast':
            theme = AppThemesEnum.highContrast;
            await SharedPrefs.save(
                "User[${appUserController.loggedUser.id}][Theme]",
                "highContrast");
            break;
          default:
            theme = AppThemesEnum.lightTheme;
            await SharedPrefs.save(
                "User[${appUserController.loggedUser.id}][Theme]",
                "lightTheme");
            break;
        }
        settings.changeTheme(theme: theme, context: context);
      },
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
