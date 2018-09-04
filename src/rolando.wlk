object rolando{
	var valorBase = 3
	var fuerzaOscura = 5
	var valorBaseLucha = 1
	var hechizoPreferido = espectroMalefico
	var artefactos = []
	
	method nivelHechiceria(){
		return ( valorBase * hechizoPreferido.poder() ) + fuerzaOscura
	}
	method eclipse(){
		fuerzaOscura *= 2
	}
	method valorBaseLucha(){
		return valorBaseLucha
	}
	method modificarValorBaseLucha(nuevoValor){
		valorBaseLucha = nuevoValor
	}
	method cambiarHechizoPreferido(nuevoHechizo){
		hechizoPreferido = nuevoHechizo
	}
	method fuerzaOscura(){
		return fuerzaOscura
	}
	method habilidadLucha(){
		return self.valorBaseLucha() + self.artefactos().sum({artefacto => artefacto.unidadesDeLucha()})
	}
	method artefactos(){
		return artefactos
	}
	method eliminarTodosLosArtefactos(){
		self.artefactos().clear()
	}
	method agregarUnArtefacto(unArtefacto){
		self.artefactos().add(unArtefacto)
	}
	method esMasLuchadorQueHechicero(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}
}

object espectroMalefico{
	var nombre = "espectro malefico"
	method esPoderoso() {
		return self.poder() > 15
	}
	method cambiarNombre(nombreNuevo){
		nombre = nombreNuevo
	}
	method poder() {
		return nombre.size()
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
	
}

object espadaDelDestino{
	method unidadesDeLucha(){
		return 3
	}
}
object mascaraOscura{
	method unidadesDeLucha(){
		return 4.max(rolando.fuerzaOscura()/2)
	}
}

object collarDivino{
	var cantidadPerlas = 5
	method unidadesDeLucha(){
		return cantidadPerlas
	}
	method modificarPerlas(unaCantidadPerlas){
		cantidadPerlas = unaCantidadPerlas
	}
}

