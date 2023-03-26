import 'package:calculadora/shared_preferences/shared_preferences.dart';
import 'package:calculadora/providers/theme_provider.dart';
import 'package:calculadora/widgets/grid_view_buttons.dart';
import 'package:calculadora/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  //Controller del textField para manejar y cambiar su valor
  final TextEditingController _controller = TextEditingController();
  //Primer y segundo número de la operación, double por si acaso
  final double number1 = 0, number2 = 0;
  final String operator = ''; //Este es el operador
  final List<String> allButtons = [
    'AC',
    '( )',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final prefs = PreferenciasUsuario();
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: (prefs.isDarkmode) ? Colors.grey : Colors.black87,
      body: Column(
        children: [
          Header(controller: _controller),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: GridViewButtons(
            allButtons: allButtons,
          ))
        ],
      ),
    );
  }
}
