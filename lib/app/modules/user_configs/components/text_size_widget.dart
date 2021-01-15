import 'package:boockando_app/app/controllers/app_user_configs_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Size Manager Widget
class TextSizeWidget extends StatelessWidget {
  final settings = Modular.get<UserConfigsController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Font Size',
              ),
            ),
            Container(child: TextSizeSlider()),
          ],
        ),
      ),
    );
  }
}

/// Slider Widget
class TextSizeSlider extends StatelessWidget {
  final settings = Modular.get<UserConfigsController>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserConfigsController>(
      builder: (context, value) {
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).cardColor.withOpacity(0),
                inactiveTrackColor: Theme.of(context).cardColor.withOpacity(0),
                trackHeight: 14,
                trackShape: RoundedRectSliderTrackShape(),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
                inactiveTickMarkColor:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
              ),
              child: Slider(
                value: settings.fontSize,
                min: 14,
                max: 25,
                divisions: 6,
                onChanged: (newSliderValue) {
                  settings.fontSize = newSliderValue;
                },
              ),
            ),
            RaisedButton(
              child: Text('Default Size'),
              onPressed: settings.fontSize == settings.defaultFontSize
                  ? null
                  : () {
                      settings.fontSize = settings.defaultFontSize;
                    },
            )
          ],
        ));
      },
    );
  }
}
