object rolando{
	var valorBase = 3
	var fuerzaOscura = 5
	var habilidadLucha = 1
	var hechizoPreferido = espectroMalefico
	method nivelHechiceria(){
		return ( valorBase * hechizoPreferido.poder() ) + fuerzaOscura
	}
	method eclipse(){
		fuerzaOscura *= 2
	}
	method habilidadLucha(){
		return habilidadLucha
	}
	method cambiarHechizoPreferido(nuevoHechizo){
		hechizoPreferido = nuevoHechizo
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
	
}

