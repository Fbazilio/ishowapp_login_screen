import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ishowapp/botaoanimado.dart';
import 'package:ishowapp/inputcustomizado.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animacaoBlur;
  late Animation<double> _animacaoFade;
  late Animation<double> _animacaoSize;

  @override
  //-----------------------------------------------------------------------------

  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
    );

    _animacaoBlur = Tween<double>(
      begin: 5,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //-----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //timeDilation = 8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(

          child: Column(children: [

            AnimatedBuilder(
                animation: _animacaoBlur,
                builder: (context, widget){

                  return Container(
                      height: 400,
                      decoration: BoxDecoration(
                        //border: BoxBorder.all(),
                          image: DecorationImage(image: AssetImage("imagens/fundo.png"),
                            fit: BoxFit.fill,
                          )
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: _animacaoBlur.value, sigmaY: _animacaoBlur.value),
                        child: Stack(
                          children: [
                            Positioned(
                                left: 10,
                                child: FadeTransition(
                                    opacity: _animacaoFade,
                                    child: Image.asset("imagens/detalhe1.png"),
                                )
                            ),
                            Positioned(
                                left: 50,
                                child: FadeTransition(
                                  opacity: _animacaoFade,
                                  child: Image.asset("imagens/detalhe2.png"),
                                )
                            )
                          ],
                        ),
                      )
                  );
                }
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(left: 30, right: 30),
              child: Column(children: [
                AnimatedBuilder(
                    animation: _animacaoSize,
                    builder: (context, widget){
                      return Container(
                        width: _animacaoSize.value,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          //boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 15,spreadRadius: 4)]
                        ),

                        child: Column(children: [
                          InputCustomizado(hint: "Email",),
                          InputCustomizado(hint: "Senha", obscure: true, icon: Icon(Icons.lock),),
                        ],),

                      );
                    }

                ),

                SizedBox(height: 20),

                BotaoAnimado(controller: _controller),

                SizedBox(height: 10),


                FadeTransition(
                  opacity: _animacaoFade,
                  child: Text("Esqueci minha senha!", style: TextStyle(
                      color: Color.fromRGBO(255, 100, 157, 1),
                      fontWeight: FontWeight.bold
                  ),)
                )


                ]),
            )


            
            
          ]),
        ),
      ),
    );
  }
}
