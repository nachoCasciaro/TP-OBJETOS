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
		return valorMinimoPoder.max( (fuerzaOscura.valor() / 2 ) * indiceDeOscuridad)
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

object armadura {

	var refuerzo = null

	method refuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		if (refuerzo == null) {
			return 2
		} else {
			return 2 + refuerzo.unidadesDeLucha(nivelHechiceria, artefactos)
		}
	}

}

object cotaDeMalla {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return 1
	}

}

object bendicion {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return nivelHechiceria
	}

}

object espejoFantastico {

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

object libroHechizos {

	var hechizos = []

	method poder() {
		return hechizos.filter({ hechizo => hechizo.esPoderoso() }).sum({ hechizo => hechizo.poder() })
	}

	method agregarHechizo(nuevoHechizo) {
		hechizos.add(nuevoHechizo)
	}

// Si el LibroDeHechizos se incluye a si mismo, al intentar obtener el poder, este no reconoce el mensaje esPoderoso()
}

