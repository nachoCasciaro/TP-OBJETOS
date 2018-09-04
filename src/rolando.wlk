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
	method cambiarHechizoPreferido(nuevoHechizo){
		hechizoPreferido = nuevoHechizo
	}
	method fuerzaOscura(){
		return fuerzaOscura
	}
	method habilidadLucha(){
		return self.valorBaseLucha() 
	}
	method artefactos(){
		return artefactos
	}
	method eliminarTodosLosArtefactos(){
		return self.artefactos.clear()
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
	var nombre = "hechizo basico"
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
	method unidadesDeLucha(){
		return 5
	}
}

