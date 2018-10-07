class Personaje {

	const property valorBaseHechiceria = 3
	var property valorBaseLucha = 1
	var property hechizoPreferido
	var artefactos = []
	var property monedas = 100

	constructor(unHechizoPreferido, unasMonedas) {
		hechizoPreferido = unHechizoPreferido
		monedas = unasMonedas
	}

	method nivelHechiceria() {
		return ( valorBaseHechiceria * hechizoPreferido.poder() ) + fuerzaOscura.valor()
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

	method estaCargado() {
		return self.artefactos().size() >= 5
	}

	method comprarUnHechizo(unHechizo) {
		feriaDeHechiceria.venderUnHechizoA(self, unHechizo)
	}

	method gastarDinero(unaCantidad) {
		monedas -= unaCantidad
	}

	method puedePagarUnHechizo(unHechizo) {
		return monedas - unHechizo.precio() + self.hechizoPreferido().precio() >= 0
	}

	method puedePagarUnArtefacto(unArtefacto) {
		return monedas - unArtefacto.precio() >= 0
	}

}

class Logo {

	var property nombre
	const property multiplo

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

	method precio(nivelHechiceria, artefactos) {
		return self.poder()
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return unaArmadura.valorBase() + self.precio(nivelHechiceria, artefactos)
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

	method precio(nivelHechiceria, artefactos) {
		return 10
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return unaArmadura.valorBase() + self.precio(nivelHechiceria, artefactos)
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

	method precio(nivelHechiceria, artefactos) {
		return 5 * self.unidadesDeLucha(nivelHechiceria, artefactos)
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

object collarDivino{
	var cantidadPerlas = 5
	method unidadesDeLucha(nivelHechiceria, artefactos){
		return cantidadPerlas
	}
	method cantidadPerlas(unaCantidadPerlas){
		cantidadPerlas = unaCantidadPerlas
	}
}


class Armadura {

	const property valorBase
	var property refuerzo

	constructor(unRefuerzo, unValorBase) {
		refuerzo = unRefuerzo
		valorBase = unValorBase
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return valorBase + refuerzo.unidadesDeLucha(nivelHechiceria, artefactos)
	}

	method precio(nivelHechiceria, artefactos, unaArmadura) {
		return refuerzo.precioSegun(nivelHechiceria, artefactos, self)
	}

}

class CotaDeMalla {

	const valorInicial

	constructor(unValorInicial) {
		valorInicial = unValorInicial
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return valorInicial
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return self.unidadesDeLucha(nivelHechiceria, artefactos) / 2
	}

}

object bendicion {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return nivelHechiceria
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return unaArmadura.valorBase()
	}

}

object sinRefuerzo {
	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return 0
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return 2
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

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return 90
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

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return hechizos.size() * 10 + hechizos.sum({ hechizo => hechizo.poder() })
	}

// FALTAN CONTESTAR LAS DOS PREGUNTAS
}

object feriaDeHechiceria {

	method venderUnHechizoA(unCliente, unHechizo) {
		if (unCliente.puedePagarUnHechizo(unHechizo)) {
			unCliente.gastarDinero(unHechizo.precio(unCliente.nivelHechiceria(),unCliente.artefactos()) - unCliente.hechizoPreferido().precio(unCliente.nivelHechiceria(),unCliente.artefactos()))
			unCliente.hechizoPreferido(unHechizo)
		} else {
			unCliente.gastarDinero(0)
		}
	}

	method venderUnArtefacto(unCliente, unArtefacto) {
		if (unCliente.puedePagarUnArtefacto(unArtefacto)) {
			unCliente.gastarDinero(unArtefacto.precio(unCliente.nivelHechiceria(),unCliente.artefactos()))
			unCliente.agregarUnArtefacto(unArtefacto)
		} else {
			unCliente.gastarDinero(0)
		}
	}

}

