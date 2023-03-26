import 'package:calculadora/providers/calc_provider.dart';
import 'package:calculadora/shared_preferences/shared_preferences.dart';
import 'package:calculadora/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalcProvider>(context);
    final prefs = PreferenciasUsuario();
    final theme = Provider.of<ThemeProvider>(context);
    return Builder(
      builder: (context) {
        return Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: (prefs.isDarkmode)
                    ? const Color.fromARGB(175, 255, 255, 255)
                    : const Color.fromARGB(120, 0, 0, 0),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.white24,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 0)),
                ]),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            theme.setLightMode();
                            prefs.isDarkmode = false;
                          },
                          child: Icon(
                            Icons.light_mode_outlined,
                            color: (prefs.isDarkmode)
                                ? Colors.white
                                : Colors.black,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            theme.setDarkmode();
                            prefs.isDarkmode = true;
                          },
                          child: Icon(
                            Icons.dark_mode_outlined,
                            color: (prefs.isDarkmode)
                                ? Colors.black
                                : Colors.white,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                // contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                // border: OutlineInputBorder(borderSide: BorderSide.none),
                                readOnly: true,
                                autofocus: true,
                                showCursor: true,
                                controller: calc.controller,
                                focusNode: calc.focusNode,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: (prefs.isDarkmode)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: calc.inputFontSize,
                                ), //automatizar eso
                                cursorWidth: 2,
                                cursorColor: Colors.black,
                                cursorRadius: const Radius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: calc.getResult.isEmpty
                                ? const SizedBox.shrink()
                                : AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 150),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24,
                                      color: (prefs.isDarkmode)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    child: Text(
                                      (calc.showResult) ? calc.getResult : '',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
