import wollok.game.*

const velocidad = 750

object juego{

	method configurar(){
		game.width(12)
		game.height(8)
		game.title("Dino Game")
		game.boardGround("fondo.png")
		game.addVisual(suelo)
		game.addVisual(cactus)
		game.addVisual(dino)
		game.addVisual(reloj)
	
		keyboard.space().onPressDo{ self.jugar()}
		game.onCollideDo(dino,{ obstaculo => obstaculo.chocar()})
		
	} 
	
	method iniciar(){
		dino.iniciar()
		reloj.iniciar()
		cactus.iniciar()
	}
	
	method jugar(){
		if (dino.estaVivo()) 
			dino.saltar()
		else {
			game.removeVisual(gameOver)
			self.iniciar()
		}
		
	}
	
	method terminar(){
		game.addVisual(gameOver)
		cactus.detener()
		reloj.detener()
		dino.morir()
	}
	
}

object gameOver {
	method position() = game.center()
	method text() = "GAME OVER"
}

object reloj {
	var property tiempo = 0 
	method text() = tiempo.toString()
  //method textColor() = "00FF00FF"
	method position() = game.at(1, game.height()-1)
	
	method pasarTiempo() {
		//COMPLETAR
	}
	method iniciar(){
		tiempo = 0
		game.onTick(100,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		//COMPLETAR
	}
}

object cactus {
	var property position = self.posicionInicial()

	method image() = "cactus.png"
	method posicionInicial() = game.at(game.width()-1,suelo.position().y())

	method iniciar(){
		position = self.posicionInicial()
		game.onTick(velocidad,"moverCactus",{self.mover()})
	}
	
	method mover(){
		//COMPLETAR
		if(self.paso()){
			position = self.posicionInicial()
		}else{
			position = position.left(1)
		}
	}

	method paso()= self.position().x()==0
	
	method chocar(){
		//COMPLETAR
		juego.terminar()
	}
    method detener(){
		//COMPLETAR
		game.removeTickEvent("moverCactus")
		
	}
}

object suelo{

	method position() = game.origin().up(1)
	method image() = "suelo.png"
}


object dino {
	var vivo = true
	var property position = game.at(1,suelo.position().y())
	
	method image() = "dino.png"
	
	method saltar(){
		//COMPLETAR
		if(self.estaEnElSuelo()){
			self.subir()
			game.onTick(velocidad*3,"gravedad",{self.bajar()})
		}
	}
	method estaEnElSuelo()= self.position().y()==suelo.position().y()
	
	method subir(){
		position = position.up(1)
	}
	
	method bajar(){
		if(!self.estaEnElSuelo()){
			position = position.down(1)
			game.removeTickEvent("gravedad")
		}
	}
	method morir(){
		game.say(self,"¡Auch!")
		vivo = false
	}
	method iniciar() {
		game.say(self,"")
		vivo = true
	}
	method estaVivo() {
		return vivo
	}
}
