class Personaje {

	const property valorBaseHechiceria = 3
	var property valorBaseLucha = 1
	var property hechizoPreferido
	var property artefactos = []
	var property monedas 

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

	method cumplirUnObjetivo() {
		monedas += 10
	}

	method comprarUnHechizo(unHechizo) {
		feriaDeHechiceria.venderUnHechizoA(self, unHechizo)
		self.hechizoPreferido(unHechizo)
	}

	method comprarUnArtefacto(unArtefacto) {
		feriaDeHechiceria.venderUnArtefactoA(self, unArtefacto)
		self.agregarUnArtefacto(unArtefacto)
	}

	method gastarDinero(unaCantidad) {
		monedas = monedas - 0.max(unaCantidad)
	}

	method puedePagarUnHechizo(unHechizo) {
		return monedas - unHechizo.precio(self.nivelHechiceria(), self.artefactos()) + (hechizoPreferido.precio(self.nivelHechiceria(), self.artefactos()) / 2) >= 0
	}

	method puedePagarUnArtefacto(unArtefacto) {
		return monedas - unArtefacto.precio(self.nivelHechiceria(), self.artefactos()) >= 0
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

object collarDivino {

	var property cantidadPerlas = 5

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return cantidadPerlas
	}

	method precio(nivelHechiceria, artefactos) {
		return 2 * cantidadPerlas
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

	method precio(nivelHechiceria, artefactos) {
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
			return artefactos.filter({ artefacto => artefacto != self }).map({ artefacto => artefacto.unidadesDeLucha(nivelHechiceria, artefactos) }).max()
		}
	}

	method esElUnico(artefactos) {
		return artefactos.filter({ artefacto => artefacto != self }).isEmpty()
	}

	method precio(nivelHechiceria, artefactos) {
		return 90
	}

}

class LibroHechizos {

	var hechizos = []

	constructor(unosHechizos) {
		hechizos = unosHechizos
	}

	method poder() {
		return hechizos.filter({ hechizo => hechizo.esPoderoso() }).sum({ hechizo => hechizo.poder() })
	}

	method agregarHechizo(nuevoHechizo) {
		hechizos.add(nuevoHechizo)
	}

	method precio(nivelHechiceria, artefactos) {
		return hechizos.size() * 10 + hechizos.filter({ hechizo => hechizo.esPoderoso() }).sum({ hechizo => hechizo.poder() })
	}


/*1) Es conveniente que haya muchos libros de hechizos ya que si se uitlizara el metodo agregar hechizo para agregarle un hechizo al libro,
     y este fuera unico, entonces esto estaria modificando al libro de hechizos que poseen todos los jugadores y esto no es el objetivo.
     En cambio para el espejo no es necesario, sintacticamente, que sean muchos ya que este no se modifica pero para mantener la realidad del mundo ,
     no seria posible que el mismo artefacto sea poseido por personas diferentes.
     
  2) Al querer preguntarle el poder al libro de hechizos que posee el libro de hechizos, este se qeudaria atrapado en un bucle infinito.*/

}

object feriaDeHechiceria {

	method venderUnHechizoA(unCliente, unHechizo) {
		if (!unCliente.puedePagarUnHechizo(unHechizo)) {
			throw new Exception("No se puede gastar mas de lo que tenes")
		}
		unCliente.gastarDinero(unHechizo.precio(unCliente.nivelHechiceria(), unCliente.artefactos()) - (unCliente.hechizoPreferido().precio(unCliente.nivelHechiceria(), unCliente.artefactos()) / 2))
	}

	method venderUnArtefactoA(unCliente, unArtefacto) {
		if (!unCliente.puedePagarUnArtefacto(unArtefacto)) {
			throw new Exception("No se puede gastar mas de lo que tenes")
		}
		unCliente.gastarDinero(unArtefacto.precio(unCliente.nivelHechiceria(), unCliente.artefactos()))
	}

}

