import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DiversidadeApp());
}

class DiversidadeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Índice de Diversidade de Shannon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiversidadeCalculator(),
    );
  }
}

class DiversidadeCalculator extends StatefulWidget {
  @override
  _DiversidadeCalculatorState createState() => _DiversidadeCalculatorState();
}

class _DiversidadeCalculatorState extends State<DiversidadeCalculator> {
  // Mapa para armazenar as proporções de cada categoria de orientação sexual
  Map<String, double> _categorias = {
    'Heterossexual': 0.2,
    'Homossexual': 0.3,
    'Bissexual': 0.2,
    'Assexual': 0.1,
    'Pansexual': 0.2,
  };

  double _diversidade = 0.0;

  void _calcularDiversidade() {
    setState(() {
      // Calculando o índice de diversidade de Shannon
      _diversidade = _categorias.values
          .map((proporcao) => proporcao * log(proporcao))
          .reduce((soma, elemento) => soma + elemento);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Diversidade de Shannon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Proporções de cada categoria:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            // Lista de campos de entrada para as proporções de cada categoria
            Column(
              children: _categorias.keys.map((categoria) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        categoria + ':',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            // Atualiza a proporção no mapa
                            _categorias[categoria] =
                                double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _calcularDiversidade,
              child: Text('Calcular Diversidade'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Índice de Diversidade de Shannon:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              _diversidade.toStringAsFixed(2),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text('Daniel Soares N°5'),
          ],
        ),
      ),
    );
  }
}
