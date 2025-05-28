import 'package:flutter/material.dart';

class BotaoAnimado extends StatelessWidget {

  final AnimationController controller;
  final Animation<double> largura;
  final Animation<double> altura;
  final Animation<double> opacidade;

  BotaoAnimado({super.key, required this.controller}) :

        largura = Tween<double>(
            begin: 0,
            end: 500
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1)
        )),

        altura = Tween<double>(
            begin: 0,
            end: 50
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.7)
        )),

        opacidade = Tween<double>(
            begin: 0,
            end: 1
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 0.8)
        ))
  ;



  Widget _buildAnimation(BuildContext context, Widget? child){
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: altura.value,
        width: largura.value,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 100, 127, 1),
              Color.fromRGBO(150, 123, 145, 1),
            ])
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacidade,
            child: Text("Entrar", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: _buildAnimation);
        }

  }

