import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os valores";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculaCombustivelIdeal() {
    double vAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
    double vGasolina =
    double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vAlcool / vGasolina;

    /*
    * se a proporção é menor que 0.7, então é melhor abastecer com álcool,
    * caso contrário, gasolina.
    * */
    // if(proporcao > 0.7) {
    //   _resultado = "Abasteça com Gasolina!";
    // } else {
    //   _resultado = "Abasteça com Álcool!";
    // }

    setState(() {
      _resultado =
      (proporcao > 0.7) ? "Abasteça com Gasolina!" : "Abasteça com Álcool!";
    });
    FocusScope.of(context).unfocus(); //abaixa o teclado
  }

  void _reset() {
    setState(() {
      alcoolController.text = "";
      gasolinaController.text = "";
      _resultado = "Informe os valores";
      FocusScope.of(context).unfocus(); //abaixa o teclado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool ou Gasolina?"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
              onPressed: () {
                _reset();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.local_gas_station,
                size: 140.0,
                color: Colors.pinkAccent,
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                value!.isEmpty ? "Informe o valor do Álcool" : null,
                decoration: InputDecoration(
                    labelText: "Valor do Álcool",
                    labelStyle:
                    TextStyle(color: Colors.pink, fontSize: 26)),
                style: TextStyle(color: Colors.pink, fontSize: 26),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                value!.isEmpty ? "Informe o valor do Gasolina" : null,
                decoration: InputDecoration(
                    labelText: "Valor do Gasolina",
                    labelStyle: TextStyle(color: Colors.pink)),
                style: TextStyle(color: Colors.pink, fontSize: 26),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent,
                          textStyle: const TextStyle(
                            fontSize: 24,
                          )),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculaCombustivelIdeal();
                        }

                        //se quiser apagar os dados assim que o
                        //cálculo é feito, descomente a linha abaixo
                        //e comente a variável "_resultado" no
                        //método "_reset()"
                        //_reset();
                      },
                      child: const Text(
                        "Calcular",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[700], fontSize: 26),
              )
            ],
          ),
        ),
      ),
    );
  }
}
