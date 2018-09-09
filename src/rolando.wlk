object rolando{
	var valorBaseHechiceria = 3
	var valorBaseLucha = 1
	var hechizoPreferido = espectroMalefico
	var artefactos = [espadaDelDestino,collarDivino, mascaraOscura]
	
	method nivelHechiceria(){
		return ( valorBaseHechiceria * hechizoPreferido.poder() ) + fuerzaOscura.valor()
	}

	method valorBaseLucha(){
		return valorBaseLucha
	}
	method valorBaseLucha(nuevoValor){
		valorBaseLucha = nuevoValor
	}
	method hechizoPreferido(nuevoHechizo){
		hechizoPreferido = nuevoHechizo
	}

	method habilidadLucha(){
		return self.valorBaseLucha() + self.artefactos().sum({artefacto => artefacto.unidadesDeLucha( self.nivelHechiceria())})
	}
	method artefactos(){
		return artefactos
	}
	method eliminarTodosLosArtefactos(){
		self.artefactos().clear()
	}
	method eliminarUnArtefacto(unArtefacto){
		self.artefactos().remove(unArtefacto)
	}
	method agregarUnArtefacto(unArtefacto){
		self.artefactos().add(unArtefacto)
	}
	method esMasLuchadorQueHechicero(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}
	
	method esPoderoso(){
		return self.hechizoPreferido().esPoderoso()
	}
	method hechizoPreferido(){
		return hechizoPreferido
	}
	method estaCargado(){
		return self.artefactos().size() >= 5
	}
	
}

object espectroMalefico{
	var nombre = "espectro malefico"
	method esPoderoso() {
		return self.poder() > 15
	}
	method nombre(nombreNuevo){
		nombre = nombreNuevo
	}
	method poder() {
		return nombre.size()
	}
	method unidadesDeLucha(nivelHechiceria){
		return self.poder()
	}
	
}

object hechizoBasico{
	var poder = 10
	method esPoderoso() {
		return false
	}
	method poder() {
		return poder
	}
	method unidadesDeLucha(nivelHechiceria){
		return self.poder()
	}
	
}

object espadaDelDestino{
	method unidadesDeLucha(){
		return 3
	}
}
object mascaraOscura{
	method unidadesDeLucha(){
		return 4.max(fuerzaOscura.valor()/2)
	}
}

object collarDivino{
	var cantidadPerlas = 5
	method unidadesDeLucha(){
		return cantidadPerlas
	}
	method cantidadPerlas(unaCantidadPerlas){
		cantidadPerlas = unaCantidadPerlas
	}
}

object fuerzaOscura {
  var valor = 5
  
  method valor() {
  return valor
  }
  
  method valor(nuevoValor){
  valor = nuevoValor
  }
  
  method eclipse(){
  valor *= 2
  }
}

object armadura {
	var refuerzo = null
	
	method refuerzo (unRefuerzo){
	refuerzo = unRefuerzo
	}


	method unidadesDeLucha(nivelHechiceria){
		return 2 + refuerzo.unidadesDeLucha(nivelHechiceria)	
	}
}

object cotaDeMalla{
	method unidadesDeLucha(nivelHechiceria){
		return 1
	}
}

object bendicion{
	method unidadesDeLucha(nivelHechiceria){
		return nivelHechiceria
	}
}

