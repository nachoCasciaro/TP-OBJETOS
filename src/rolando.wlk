object rolando{
	var valorBase = 3
	var fuerzaOscura = 5
	var habilidadLucha = 1
	method nivelHechiceria(unHechizo){
		return ( valorBase * unHechizo.poder() ) + fuerzaOscura
	}
	method eclipse(){
		fuerzaOscura *= 2
	}
	method seCreePoderoso(){
		if bf
	}
	method habilidadLucha(){
		return habilidadLucha
	}
}

object espectroMalefico{
	var poder = 17
	var esPoderoso = true
	method poder() {
		return poder
	}
}

object hechizoBasico{
	var poder = 10
	var esPoderoso = false
	method poder() {
		return poder
	}
}

object espadaDelDestino{
	method modificarLucha(){
		habilidadLucha += 3
	}
}

