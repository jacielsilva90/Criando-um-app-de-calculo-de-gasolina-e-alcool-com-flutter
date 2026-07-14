
//Em flutter, para alterar o estado de tela do app devemos usar setState.
//A funçao setState é exclusiva da classe Statefulwidget. 
//Logo a tela deve ser criada em uma classe extendida de Statefulwidget.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {//StatelessWidget é classe pai 
  const MyApp({super.key});
  @override //sobrecrita do metodo build() de statelesswidget
  Widget build(BuildContext context) { //constroi o widget materialapp
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove a faixa de debug no canto da tela
      title: 'meu app Flutter', 
      theme: ThemeData( //define o tema do app
        colorScheme: .fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const MyHomePage(title: 'minha Flutter Home'),
    );
  }
}
//criamos uma classe estendida de statefulwidget e nela criamos um estado.
class MyHomePage extends StatefulWidget { //StatefulWidget é classe pai 
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState(); //cria a classe _myhomepagestate()
}

class _MyHomePageState extends State<MyHomePage> { //chama _myhomepagestate herdada de myhomepage
  //o controller deve ser colocado no Textfield para captura de dados.
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String counter = ''; //counter será exibida no text scaffold
  double calculo=0; //calculo da divisao será colocado na counter
  
  void _incrementCounter() { //Essa função será colocada no botão no body
    setState(() { //setstate altera o estado da tela ao clicar no botao.
      if(double.parse(_controller2.text)==0 || double.parse(_controller.text)==0){
        counter = 'Valores inválidos';
      }else {
        calculo = (double.parse(_controller2.text)/double.parse(_controller.text))*100;
        if(calculo>=70){
          counter='Resultado $calculo : melhor abastecer com alcool';
        }else{
          counter='Resultado $calculo : melhor abastecer com gasolina';
        }
      }
    });
  }

  @override
  void dispose(){ //esta função elimina o controlador após fechar o app
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override //sobrescreve build() da claasse pai
  Widget build(BuildContext context) { // constroi o widget scaffold
    return Scaffold( //forma a tela do app
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,        
        title: const Text('Gasolina x Alcool'), //(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .start, //.center,
          children: [
            Text(''),
            const Text('Gasolina x Alcool'),
            Text(''),
            Image.network( //importa uma imagem da web
              'https://i.pinimg.com/736x/ea/a4/4f/eaa44f8eed723134bf37bef80768d547.jpg',
              width: 150,
              height: 150,
            ),
            Text(''),
            SizedBox(
              width: 400.0,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], //filtro que so aceita numeros
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: UnderlineInputBorder(),
                  labelText: '  Valor da Gasolina',
                ),
                controller: _controller, // captura os dados
              ),
            ),
            SizedBox(
              width: 400.0,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: UnderlineInputBorder(),
                  labelText: '  Valor do Alcool',
                ),
                controller: _controller2,
              ),
            ),
            FloatingActionButton.extended(
              onPressed: _incrementCounter, //chama a função de calculo
              label: Text('Calcular'),
            ),
            Text(''),
            Text(
              ' $counter',
              
            ),

          ],
        ), 
      ),    
    );
  }
}
