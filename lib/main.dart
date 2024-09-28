import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafios Lógicos',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafios Lógicos'),
        centerTitle: true,
        elevation: 8.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuItem(context, '1. Verificar Fibonacci', Icons.functions,
                  FibonacciPage()),
              _buildMenuItem(context, '2. Verificar ocorrência de "a"',
                  Icons.text_fields, VerificarAPage()),
              _buildMenuItem(context, '3. Valor da soma no loop', Icons.loop,
                  SomaLoopPage()),
              _buildMenuItem(context, '4. Descobrir lógica das sequências',
                  Icons.quiz, SequenciasPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(icon, color: Colors.blueGrey, size: 32.0),
        title: Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

class FibonacciPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  bool isFibonacci(int num, List<int> fibSequence) {
    int a = 0, b = 1;
    fibSequence.add(a);
    fibSequence.add(b);
    while (b <= num) {
      int temp = b;
      b = a + b;
      a = temp;
      fibSequence.add(b);
      if (b == num) return true;
    }
    return num == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Fibonacci'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(context),
              SizedBox(height: 20.0),
              _buildButtonBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: 'Digite um número',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
      ),
      onSubmitted: (_) => _verificar(context),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.check_circle),
          label: Text('Verificar'),
          onPressed: () => _verificar(context),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.arrow_back),
          label: Text('Voltar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _verificar(BuildContext context) {
    int num = int.parse(_controller.text);
    List<int> fibSequence = [];
    bool result = isFibonacci(num, fibSequence);
    String sequence = fibSequence.join(', ');
    String message = result
        ? '$num pertence à sequência de Fibonacci.\nSomas: $sequence'
        : '$num não pertence à sequência de Fibonacci.\nSomas: $sequence';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text('Resultado'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class VerificarAPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar ocorrência de "a"'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(context),
              SizedBox(height: 20.0),
              _buildButtonBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return TextField(
      controller: _controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: 'Digite uma string',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
      ),
      onSubmitted: (_) => _verificar(context),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.check_circle),
          label: Text('Verificar'),
          onPressed: () => _verificar(context),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.arrow_back),
          label: Text('Voltar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _verificar(BuildContext context) {
    String input = _controller.text;
    int count = input.toLowerCase().split('a').length - 1;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text('Resultado'),
          content:
              Text('A letra "a" aparece $count vezes na string informada.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class SomaLoopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valor da soma no loop'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'O loop faz as seguintes operações:\n'
                'Inicialmente, SOMA = 0 e K = 1.\n'
                'Para cada iteração do loop, K é incrementado e SOMA acumula o valor de K.\n'
                'O loop para quando K é igual a 12.\n\n'
                'Assim, o valor final da variável SOMA ao final do loop é 91.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, height: 1.5),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text('Voltar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SequenciasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descobrir lógica das sequências'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'a) 1, 3, 5, 7, _\n'
                'Explicação: Sequência de números ímpares. O próximo número é 9.\n\n'
                'b) 2, 4, 8, 16, 32, 64, _\n'
                'Explicação: Potências de 2. O próximo número é 128.\n\n'
                'c) 0, 1, 4, 9, 16, 25, 36, _\n'
                'Explicação: Sequência de quadrados perfeitos (n^2). O próximo é 49 (7^2).\n\n'
                'd) 4, 16, 36, 64, _\n'
                'Explicação: Sequência de quadrados perfeitos começando com 2^2. O próximo é 100 (10^2).\n\n'
                'e) 1, 1, 2, 3, 5, 8, _\n'
                'Explicação: Sequência de Fibonacci. O próximo número é 13.\n\n'
                'f) 2, 10, 12, 16, 17, 18, 19, _\n'
                'Explicação: Sequência com padrão misto. O próximo número é 20.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, height: 1.5),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text('Voltar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
