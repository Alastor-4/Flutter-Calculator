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
            height: 250.0,
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
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            padding: const EdgeInsets.all(15),
                            color: Colors
                                .white, //TODO: theme botoncitos y container trasero
                            splashRadius: 5,
                            shape: Border.all(width: 1, color: Colors.black),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Modo Oscuro',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text(
                                  'Acerca de',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 2) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Center(child: Text('Información')),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    titlePadding:
                                        const EdgeInsets.only(left: 30),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 5, 5),
                                        child: ListTile(
                                          title: const Text(
                                            "Alexis Manuel Hurtado García",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          leading: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.phone)),
                                          subtitle: const Text("+53 55529865"),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'))
                                    ],
                                  ),
                                );
                              } else if (value == 1) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Center(child: Text('Modo oscuro')),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    titlePadding:
                                        const EdgeInsets.only(left: 20),
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                theme.setDarkmode();
                                                prefs.isDarkmode = true;
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
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                theme.setLightMode();
                                                prefs.isDarkmode = false;
                                              },
                                              child: Icon(
                                                Icons.dark_mode_outlined,
                                                color: (prefs.isDarkmode)
                                                    ? Colors.black
                                                    : Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'))
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
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
                                  readOnly: true,
                                  autofocus: true,
                                  showCursor: true,
                                  controller: calc.controller,
                                  focusNode: calc.focusNode,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: (prefs.isDarkmode)
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: calc.inputFontSize,
                                  ), //automatizar eso
                                  cursorWidth: 2,
                                  cursorColor: (prefs.isDarkmode)
                                      ? Colors.black
                                      : Colors.white,
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
                                      duration:
                                          const Duration(milliseconds: 150),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 24,
                                        color: (prefs.isDarkmode)
                                            ? Colors.black
                                            : Colors.white,
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
              ),
            ));
      },
    );
  }
}
