//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable, unrelated_type_equality_checks, avoid_print, library_private_types_in_public_api, unnecessary_const

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp([Key? key]) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<String>> matriz = [
    ['15', '06', '04', '02'],
    ['01', '11', '10', '07'],
    ['09', '03', '05', '08'],
    ['12', '14', '13', '']
  ];
  List<List<String>> completo = [
    ['01', '02', '03', '04'],
    ['05', '06', '07', '08'],
    ['09', '10', '11', '12'],
    ['13', '14', '15', '']
  ];
  List<List<String>> inicial = [
    ['15', '06', '04', '02'],
    ['01', '11', '10', '07'],
    ['09', '03', '05', '08'],
    ['12', '14', '13', '']
  ];

  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    // ignore: unnecessary_new
    new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 50000) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  int linha = -1;
  int coluna = -1;
  String mat = 'X,Y';
  int calc = 0;
  int cont = 0;

  void moveKey(var tecla) {
    if (cont == 0) {
      startTimer();
    }
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (matriz[i][j] == tecla) {
          setState(() {
            linha = i;
            coluna = j;
            mat = ('$linha,$coluna');
            cont++;
          });
          break;
        }
      }
    }
    void calcular() {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          if (matriz[i][j] == completo[i][j]) {
            setState(() {
              calc++;
            });
          } else {
            setState(() {
              calc = 0;
            });
          }
        }
        if (calc == 16) {
          setState(() {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Vitória!'),
                    content: Text('Deseja continuar jogando?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            matriz.shuffle();
                            mat = '0,0';
                            cont = 0;
                            _start = 0;
                          });
                        },
                        child: Text('Sim'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                          });
                        },
                        child: Text('Não'),
                      )
                    ],
                  );
                });
          });
        }
      }
    }

    setState(() {
      if (linha - 1 >= 0) {
        if (matriz[linha - 1][coluna] == '') {
          matriz[linha - 1][coluna] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (linha + 1 <= 3) {
        if (matriz[linha + 1][coluna] == '') {
          matriz[linha + 1][coluna] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (coluna - 1 >= 0) {
        if (matriz[linha][coluna - 1] == '') {
          matriz[linha][coluna - 1] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }

      if (coluna + 1 <= 3) {
        if (matriz[linha][coluna + 1] == '') {
          matriz[linha][coluna + 1] = tecla;
          matriz[linha][coluna] = '';
          calcular();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Puzzle')),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    mat,
                    style: TextStyle(fontSize: 72),
                  ),
                  Text(
                    ' -//- ',
                    style: TextStyle(fontSize: 72),
                  ),
                  Text(
                    cont.toString(),
                    style: TextStyle(fontSize: 72),
                  ),
                  Text(
                    ' -//- ',
                    style: TextStyle(fontSize: 72),
                  ),
                  Text(
                    _start.toString(),
                    style: TextStyle(fontSize: 72),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][0]),
                      child: Text(
                        matriz[0][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][1]),
                      child: Text(
                        matriz[0][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][2]),
                      child: Text(
                        matriz[0][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[0][3]),
                      child: Text(
                        matriz[0][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][0]),
                      child: Text(
                        matriz[1][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][1]),
                      child: Text(
                        matriz[1][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][2]),
                      child: Text(
                        matriz[1][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[1][3]),
                      child: Text(
                        matriz[1][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][0]),
                      child: Text(
                        matriz[2][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][1]),
                      child: Text(
                        matriz[2][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][2]),
                      child: Text(
                        matriz[2][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[2][3]),
                      child: Text(
                        matriz[2][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][0]),
                      child: Text(
                        matriz[3][0],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][1]),
                      child: Text(
                        matriz[3][1],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][2]),
                      child: Text(
                        matriz[3][2],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => moveKey(matriz[3][3]),
                      child: Text(
                        matriz[3][3],
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
