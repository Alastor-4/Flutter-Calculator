import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';

extension Strings on String {
  String get last => isEmpty ? '' : this[length - 1];
}

class CalcProvider with ChangeNotifier {
  String _result = '';
  bool showResult = true;

  final controller = TextEditingController();
  final focusNode = FocusNode();

  double get inputFontSize {
    //obtener tamaño de letra del resultado, dependiendo de la cantidad de caracteres que haya
    if (controller.text.length < 8) return 50;
    if (controller.text.length < 12) return 44;
    if (controller.text.length < 16) return 38;
    return 30;
  }

  String get input => controller.text;

  String get result => _result;

  String get getResult {
    try {
      //Este método evalúa en tiempo real los resultados en la y los actualiza
      final eval = num.parse(
          Expression(fixedCalc).eval()!.toDouble().toStringAsFixed(4));
      //pasarlo por el fixedCalc y redondearlo a 4 lugares luego de la coma
      if (eval.toInt() == eval) return eval.toInt().toString().toUpperCase();
      //Si es entero retornarlo asi, sino con coma
      return eval.toString().toUpperCase();
    } catch (err) {
      return ''; //Caso contrario mostrarlo vacío y capturar cualquier error, shhh
    }
  }

  //Método para equilibrar ()
  String get fixedCalc {
    //Este método es para detectar cuantos paréntesis '(' y equilibrarlos con ')' y asi poder retornar el cálculo
    if ('('.allMatches(controller.text).length >=
        ')'.allMatches(controller.text).length) {
      return controller.text +
          ')' *
              ('('.allMatches(controller.text).length -
                  ')'.allMatches(controller.text).length);
    }
    //Si todo está bien retorna el valor normal
    return controller.text;
  }

  //Botón AC Correcto
  void allClear() {
    controller.clear();
    showResult = false;
    notifyListeners();
  }

  //Botón DEL Correcto
  void delete() {
    showResult = true;
    //extrae el texto del controlador
    String textValue = controller.text;
    //extrae la posicion del cursor
    int cursorPosition = controller.selection.base.offset;

    //Si no esta marcado la pone en 0
    if (cursorPosition == -1) cursorPosition = 0;
    //Si no hay texto, o la posición del cursor es 0, sale del método
    if (textValue.isEmpty || cursorPosition == 0) return;

    //divide el texto en 2, a la derecha e izquierda de la posicion del cursor
    String rightPart = controller.text.substring(cursorPosition),
        leftPart = controller.text.substring(0, cursorPosition);

    // a la parte izquierda le resta el último caracter
    leftPart = leftPart.substring(0, leftPart.length - 1);

    //luego se une las dos partes en el texto del controller
    controller.text = leftPart + rightPart;

    //Estas líneas son para volver a dejar el cursor en donde borró, y asi poder seguir borrando
    controller.selection = TextSelection(
      baseOffset: cursorPosition - 1,
      extentOffset: cursorPosition - 1,
    );

    notifyListeners();
  }

  //Botón tanto para números, como simbolos
  void add(String text) async {
    showResult = true; //muestra el resultado

    int cursorPos =
        controller.selection.base.offset; //Extrae la posición del cursor

    if (cursorPos == -1) cursorPos = 0;

    //divide el texto en 2, a la derecha e izquierda de la posicion del cursor
    String rightPart = controller.text.substring(cursorPos),
        leftPart = controller.text.substring(0, cursorPos);

    //esta condición es para analizar si donde se va a poner el número le predecede un ) para poner un *
    if (leftPart.endsWith(')') && isNumber(text)) {
      controller.text = '$leftPart*$text$rightPart';
    } else {
      //agrega el texto entre las dos partes
      controller.text = '$leftPart$text$rightPart';
    }

    //deja el cursor donde estaba, para poder seguir agregando
    controller.selection = TextSelection(
      baseOffset: cursorPos + text.length,
      extentOffset: cursorPos + text.length,
    );

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
  }

  //Botón = Correcto
  void equal() {
    //Si existe resultado, asigna el resultado y lo asigna al controlador para que lo muestre
    if (getResult.isNotEmpty) {
      _result = getResult;
      controller.text = getResult;
    }
    //Devuelve el cursor al inicio para poder seguir tecleando
    controller.selection = TextSelection(
      baseOffset: getResult.length,
      extentOffset: getResult.length,
    );
    //Oculta la prediccion de resultado
    showResult = false;
    notifyListeners();
  }
  //TODO: %

  //TODO: Historial

  //TODO: Icono

  //Botones -+/* Añadir operador Correcto
  void addOperator(String operador) {
    if (operador == '-') {
      //Si es - si lo deja poner y sale del método
      add(operador);
      return;
    }
    //Si está vacía la caja de texto o hay un operador ya antes de este y no es - o +, entonces sale del método
    if (controller.text.isEmpty ||
        (!isMinusPlus(operador) && isOperator(controller.text.last))) return;
    add(operador); //Sino, añade el operador
  }

  //Botón () Correcto
  void parenthesisBehavior() {
    final text = controller.text;
    //Si el ultimo valor, es diferente de (, no es un operador, y hay mas '(' que ')', entonces coloca )
    if (text.last != '(' &&
        !isOperator(text.last) &&
        '('.allMatches(controller.text).length >
            ')'.allMatches(controller.text).length) {
      add(')');
      //si no esta vacío y el ultimo operador es un número, coloca un *(
    } else if (text.isNotEmpty && !isOperator(text.last) && text.last != '(') {
      add('*(');
    } else {
      add('('); //Sino coloca paréntesis abierto (
    }
  }

  //Método para saber si es un operador
  bool isOperator(String operador) {
    return RegExp(r'[-+/*%]').hasMatch(operador);
  }

//[/*-+%]
  //Retorna falso solo si es - o +
  bool isMinusPlus(String operador) {
    return RegExp(r'[-+]').hasMatch(operador);
  }

//Método para saber si es un número
  bool isNumber(String operador) {
    return RegExp(r'^[0-9]+$').hasMatch(operador);
  }
}
