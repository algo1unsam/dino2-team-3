import wollok.game.*

const velocidad = 250

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
	var property segundos = 0
	var property minutos = 0
	method text() = "" + minutos + ": " + segundos
    method textColor() = "FF0000FF"
	method position() = game.at(1, game.height()-1)
	
	method pasarTiempo() {
	if (segundos == 60){
		minutos = minutos + 1
		segundos = 0
	}
	segundos = segundos + 1
	}
	method iniciar(){
		segundos = 0
		game.onTick(1000,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
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
	}
	
	method chocar(){
		//COMPLETAR
	}
    method detener(){
		//COMPLETAR
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
	}
	
	method subir(){
		position = position.up(1)
	}
	
	method bajar(){
		position = position.down(1)
	}
	method morir(){
		game.say(self,"¡Auch!")
		vivo = false
	}
	method iniciar() {
		vivo = true
	}
	method estaVivo() {
		return vivo
	}
}
