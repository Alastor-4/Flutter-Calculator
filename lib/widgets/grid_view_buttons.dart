import 'package:calculadora/shared_preferences/shared_preferences.dart';
import 'package:calculadora/providers/theme_provider.dart';
import 'package:calculadora/widgets/create_button.dart';
import 'package:flutter/material.dart';
import 'package:calculadora/providers/calc_provider.dart';
import 'package:provider/provider.dart';

class GridViewButtons extends StatelessWidget {
  final List<String> allButtons;
  const GridViewButtons({super.key, required this.allButtons});

  @override
  Widget build(BuildContext context) {
    final calcs = Provider.of<CalcProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    final theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allButtons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0: //Botón AC
              return CreateButton(
                  color: Colors.greenAccent,
                  textColor: Colors.black,
                  text: allButtons[index],
                  action: () {
                    calcs.allClear();
                  });

            case 1: //Botón ()
              return CreateButton(
                  color: Colors.blue.shade400,
                  textColor: Colors.black,
                  text: allButtons[index],
                  action: calcs.parenthesisBehavior);

            case 3: //Botón /
            case 7: //Botón *
            case 11: //Botón -
            case 15: //Botón +
              return CreateButton(
                  color: Colors.blue.shade400,
                  textColor: Colors.black,
                  text: allButtons[index],
                  action: () => calcs.addOperator(allButtons[index]));

            case 18: //Botón DEl
              return CreateButton(
                  color: (prefs.isDarkmode) ? Colors.white : Colors.white10,
                  textColor: (prefs.isDarkmode) ? Colors.black : Colors.white,
                  text: allButtons[index],
                  action: calcs.delete);

            case 19: //Botón =
              return CreateButton(
                  color: (prefs.isDarkmode) ? Colors.white30 : Colors.white70,
                  textColor: Colors.black,
                  text: allButtons[index],
                  action: calcs.equal);

            default:
              return CreateButton(
                  color: (allButtons[index] == "%")
                      ? Colors.blue.shade400
                      : (prefs.isDarkmode)
                          ? Colors.white
                          : Colors.white10,
                  textColor: (allButtons[index] == "%")
                      ? Colors.black
                      : (prefs.isDarkmode)
                          ? Colors.black
                          : Colors.white,
                  text: allButtons[index],
                  action: () => calcs.add(allButtons[index]));
          }
        },
      ),
    );
  }
}
