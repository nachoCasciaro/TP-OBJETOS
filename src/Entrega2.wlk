class Personaje {

	const property valorBaseHechiceria = 3
	var valorBaseLucha = 1
	var hechizoPreferido
	var artefactos = []

	constructor(unHechizoPreferido) {
		hechizoPreferido = unHechizoPreferido
	}

	method nivelHechiceria() {
		return ( valorBaseHechiceria * hechizoPreferido.poder() ) + fuerzaOscura.valor()
	}

	method valorBaseLucha() {
		return valorBaseLucha
	}

	method valorBaseLucha(nuevoValor) {
		valorBaseLucha = nuevoValor
	}

	method hechizoPreferido(nuevoHechizo) {
		hechizoPreferido = nuevoHechizo
	}

	method habilidadLucha() {
		return self.valorBaseLucha() + self.artefactos().sum({ artefacto => artefacto.unidadesDeLucha(self.nivelHechiceria(), self.artefactos()) })
	}

	method artefactos() {
		return artefactos
	}

	method eliminarTodosLosArtefactos() {
		self.artefactos().clear()
	}

	method eliminarUnArtefacto(unArtefacto) {
		self.artefactos().remove(unArtefacto)
	}

	method agregarUnArtefacto(unArtefacto) {
		self.artefactos().add(unArtefacto)
	}

	method esMasLuchadorQueHechicero() {
		return self.habilidadLucha() > self.nivelHechiceria()
	}

	method esPoderoso() {
		return self.hechizoPreferido().esPoderoso()
	}

	method hechizoPreferido() {
		return hechizoPreferido
	}

	method estaCargado() {
		return self.artefactos().size() >= 5
	}

}

class Logo {

	var property nombre
	const multiplo

	constructor(unNombre, unMultiplo) {
		nombre = unNombre
		multiplo = unMultiplo
	}

	method poder() {
		return nombre.size() * multiplo
	}

	method esPoderoso() {
		return self.poder() > 15
	}
	
	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return self.poder()
	}

}

object hechizoBasico {

	var poder = 10

	method esPoderoso() {
		return false
	}

	method poder() {
		return poder
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return self.poder()
	}

}

object fuerzaOscura {

	var valor = 5

	method valor() {
		return valor
	}

	method valor(nuevoValor) {
		valor = nuevoValor
	}

	method eclipse() {
		valor *= 2
	}

}

class Arma {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return 3
	}

}

class Mascara {

	var property valorMinimoPoder = 4
	var property indiceDeOscuridad

	constructor(unIndice) {
		indiceDeOscuridad = unIndice
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return valorMinimoPoder.max((fuerzaOscura.valor() / 2 ) * indiceDeOscuridad)
	}

}

object collarDivino {

	var cantidadPerlas = 5

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return cantidadPerlas
	}

	method cantidadPerlas(unaCantidadPerlas) {
		cantidadPerlas = unaCantidadPerlas
	}

}

class Armadura {
	const property valorBase
	var property refuerzo

	constructor(unRefuerzo,unValorBase) {
		refuerzo = unRefuerzo
		valorBase = unValorBase
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		if (refuerzo == null) {
			return valorBase
		} else {
			return valorBase + refuerzo.unidadesDeLucha(nivelHechiceria, artefactos)
		}
	}

}

class CotaDeMalla{
	const property valorInicial 
	constructor(unValorInicial){
		valorInicial = unValorInicial
	}
	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return valorInicial
	}
}


object bendicion {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return nivelHechiceria
	}

}

class EspejoFantastico {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		if (self.esElUnico(artefactos)) {
			return 0
		} else {
			return artefactos.filter({ artefacto => artefacto != self }).max({ artefacto => artefacto.unidadesDeLucha(nivelHechiceria, artefactos) })
		}
	}

	method esElUnico(artefactos) {
		return artefactos.filter({ artefacto => artefacto != self }).isEmpty()
	}

}



class LibroHechizos {

	var hechizos = []

	method poder() {
		return hechizos.filter({ hechizo => hechizo.esPoderoso() }).sum({ hechizo => hechizo.poder() })
	}

	method agregarHechizo(nuevoHechizo) {
		hechizos.add(nuevoHechizo)
	}

// FALTAN CONTESTAR LAS DOS PREGUNTAS
}

