class Personaje {

	const property valorBaseHechiceria = 3
	var property valorBaseLucha = 1
	var property hechizoPreferido
	var property artefactos = []
	var property monedas
	const property capacidadMaxima

	constructor(unHechizoPreferido, unasMonedas, unaCapacidadMaxima) {
		hechizoPreferido = unHechizoPreferido
		monedas = unasMonedas
		capacidadMaxima = unaCapacidadMaxima
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

	method comprarUnArtefacto(unArtefacto, unComerciante) {
		if (!self.tieneLugar(unArtefacto)) {
			self.error("capacidad insuficiente")
		}
		feriaDeHechiceria.venderUnArtefactoA(self, unArtefacto, unComerciante)
		self.agregarUnArtefacto(unArtefacto)
	}

	method tieneLugar(unArtefacto) {
		return capacidadMaxima - artefactos.sum({ artefacto => artefacto.pesoTotal(self.nivelHechiceria(), self.artefactos()) }) >= unArtefacto.pesoTotal(self.nivelHechiceria(), self.artefactos())
	}

	method gastarDinero(unaCantidad) {
		monedas = monedas - 0.max(unaCantidad)
	}

	method puedePagarUnHechizo(unHechizo) {
		return monedas - unHechizo.precio(self.nivelHechiceria(), self.artefactos()) + (hechizoPreferido.precio(self.nivelHechiceria(), self.artefactos()) / 2) >= 0
	}

	method puedePagarUnArtefacto(unArtefacto, unComerciante) {
		return monedas - unArtefacto.precio(self.nivelHechiceria(), self.artefactos()) - unComerciante.impuesto() >= 0
	}

}

class NPC inherits Personaje {

	var property nivelJuego

	constructor(unHechizoPreferido, unasMonedas, unaCapacidadMaxima, unNivelJuego) = super(unHechizoPreferido, unasMonedas, unaCapacidadMaxima) {
		nivelJuego = unNivelJuego
	}

	override method habilidadLucha() {
		return super() * nivelJuego.valor()
	}

}

object nivelFacil {

	method valor() {
		return 1
	}

}

object nivelModerado {

	method valor() {
		return 2
	}

}

object nivelDificil {

	method valor() {
		return 4
	}

}

class HechizoGeneral {

	method poder()

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

	method pesoSegun() {
		if (self.poder().even()) {
			return 2
		} else {
			return 1
		}
	}

}

class Logo inherits HechizoGeneral {

	var property nombre
	const property multiplo

	constructor(unNombre, unMultiplo) {
		nombre = unNombre
		multiplo = unMultiplo
	}

	override method poder() {
		return nombre.size() * multiplo
	}

}

object hechizoBasico inherits HechizoGeneral {

	var poder = 10

	override method poder() {
		return poder
	}

}

object elHechizoComercial inherits HechizoGeneral {

	var property porcentaje = 0.2
	var property multiplicador = 8

	override method poder() {
		return porcentaje * multiplicador
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

class Artefacto {

	const property peso
	var property diasAntiguedad

	constructor(unPeso, antiguedad) {
		peso = unPeso
		diasAntiguedad = antiguedad
	}

	method pesoTotal(nivelHechiceria, artefactos) {
		return peso - self.factorCorrecion() + self.condicionParticular(nivelHechiceria, artefactos)
	}

	method factorCorrecion() {
		return (diasAntiguedad / 1000).min(1)
	}

	method condicionParticular(nivelHechiceria, artefactos)

}

class Arma inherits Artefacto {

	override method condicionParticular(nivelHechiceria, artefactos) {
		return 0
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return 3
	}

	method precio(nivelHechiceria, artefactos) {
		return 5 * peso
	}

}

class Mascara inherits Artefacto {

	var property valorMinimoPoder = 4
	var property indiceDeOscuridad

	constructor(unPeso, antiguedad,unIndice) = super(unPeso, antiguedad) {
		indiceDeOscuridad = unIndice
	}

	override method condicionParticular(nivelHechiceria, artefactos) {
		return (self.unidadesDeLucha(nivelHechiceria, artefactos) - 3).max(0)
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return valorMinimoPoder.max((fuerzaOscura.valor() / 2 ) * indiceDeOscuridad)
	}

	method precio(nivelHechiceria, artefactos) {
		return 10 * indiceDeOscuridad
	}

}

class CollarDivino inherits Artefacto {

	var property cantidadPerlas = 5

	override method condicionParticular(nivelHechiceria, artefactos) {
		return cantidadPerlas * 0.5
	}

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return cantidadPerlas
	}

	method precio(nivelHechiceria, artefactos) {
		return 2 * cantidadPerlas
	}

}

class Armadura inherits Artefacto {

	const property valorBase
	var property refuerzo

	constructor(unRefuerzo, unValorBase) = super(unPeso, antiguedad) {
		refuerzo = unRefuerzo
		valorBase = unValorBase
	}

	override method condicionParticular(nivelHechiceria, artefactos) {
		return refuerzo.pesoSegun()
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

	method pesoSegun() {
		return 1
	}

}

object bendicion {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return nivelHechiceria
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return unaArmadura.valorBase()
	}

	method pesoSegun() {
		return 0
	}

}

object sinRefuerzo {

	method unidadesDeLucha(nivelHechiceria, artefactos) {
		return 0
	}

	method precioSegun(nivelHechiceria, artefactos, unaArmadura) {
		return 2
	}

	method pesoSegun() {
		return 0
	}

}

class EspejoFantastico inherits Artefacto {

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

	override method condicionParticular(nivelHechiceria, artefactos) {
		return 0
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
	/*1) Es conveniente que haya muchos libros de hechizos ya que si se uitlizara el metodo agregar hechizo para agregarle un hechizo al libro,
	 *      y este fuera unico, entonces esto estaria modificando al libro de hechizos que poseen todos los jugadores y esto no es el objetivo.
	 *      En cambio para el espejo no es necesario, sintacticamente, que sean muchos ya que este no se modifica pero para mantener la realidad del mundo ,
	 *      no seria posible que el mismo artefacto sea poseido por personas diferentes.
	 *      
	 2) Al querer preguntarle el poder al libro de hechizos que posee el libro de hechizos, este se qeudaria atrapado en un bucle infinito.*/
	}

}

object feriaDeHechiceria {

	method venderUnHechizoA(unCliente, unHechizo) {
		if (!unCliente.puedePagarUnHechizo(unHechizo)) {
			throw new Exception("No se puede gastar mas de lo que tenes")
		}
		unCliente.gastarDinero(unHechizo.precio(unCliente.nivelHechiceria(), unCliente.artefactos()) - (unCliente.hechizoPreferido().precio(unCliente.nivelHechiceria(), unCliente.artefactos()) / 2))
	}

	method venderUnArtefactoA(unCliente, unArtefacto, unComerciante) {
		if (!unCliente.puedePagarUnArtefacto(unArtefacto, unComerciante)) {
			throw new Exception("No se puede gastar mas de lo que tenes")
		}
		unCliente.gastarDinero(unArtefacto.precio(unCliente.nivelHechiceria() + unComerciante.impuesto(unArtefacto), unCliente.artefactos()))
	}

}

class Comerciante {

	var property tipo
	var property comision
	const property minimoImponible

	constructor(unTipo, unMinimoImponible, unaComision) {
		tipo = unTipo
		minimoImponible = unMinimoImponible
		comision = unaComision
	}

	method cambiarSituacion(unTipo) {
		tipo.recategorizacion(self)
	}

	method cambiarA(unTipo) {
		tipo = unTipo
	}

	method impuesto(unArtefacto) {
		tipo.impuestoSegun(comision, unArtefacto)
	}

	method superaLimite() {
		return comision * 2 > 21
	}

}

object comercianteIndependiente {

	method impuestoSegun(comerciante, unArtefacto) {
		return comerciante.comision()
	}

	method recategorizacion(comerciante) {
		if (comerciante.superaLimite()) {
			comerciante.duplicarComision()
			comerciante.cambiarA(comercianteRegistrado)
		} else {
			comerciante.duplicarComision()
		}
	}

}

object comercianteRegistrado {

	method impuestoSegun(comerciante, unArtefacto) {
		return unArtefacto.precio() * 0.21
	}

	method recategorizacion(comerciante) {
		comerciante.cambiarA(comercianteConGanancias)
	}

}

object comercianteConGanancias {

	method impuestoSegun(comerciante, unArtefacto) {
		if (unArtefacto.precio() < comerciante.minimoImponible()) {
			return 0
		} else {
			return (unArtefacto.precio() - comerciante.minimoImponible()) * 0.35
		}
	}

	method recategorizacion(comerciante) {
	}

}

