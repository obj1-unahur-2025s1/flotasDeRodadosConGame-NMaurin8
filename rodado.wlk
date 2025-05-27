import colores.*
class RodadoCorsa{
    var property color 
    method capacidad() = 4
    
    method velocidadMaxima() = 150
    method peso() = 1300
}

class RodadoKwid{
    var property tieneTanqueAdicional

    
    method capacidad() = if(tieneTanqueAdicional) 3 else 4
    method velocidadMaxima() = if(tieneTanqueAdicional) 120 else 110
    method peso() = if(tieneTanqueAdicional)1200 + 150 else 1200
    method color() = azul
}

object trafic{
    var interior = comodo
    var motor = pulenta
    method cambiarInterior(unInterior){
        interior = unInterior   
    }
    method cambiarMotor(unMotor){
        motor = unMotor
    }
    method capacidad() = interior.capacidad()
    method velocidadMaxima() = motor.velocidadMaxima()
    method peso() = 4000 + interior.peso() + motor.peso()
    method color() = blanco

}
object pulenta{
    method peso() = 800
    method velocidadMaxima() = 130
}

object bataton{
    method peso() = 500
    method velocidadMaxima() = 80
}

object comodo{
    method capacidad() = 5
    method peso() = 700
}
object popular{
    method capacidad() = 12
    method peso() = 1000
}

class AutoEspecial{
    var property capacidad
    var property velocidadMaxima
    var property peso
    var property color
}

class Dependencia{
    const property pedidos = []
    method agregarPedido(unPedido){
        pedidos.add(unPedido)
    }
    method quitarPedido(unPedido){
        pedidos.remove(unPedido)
    }
    method pasajerosTotalesEnPedidos() = pedidos.sum({pedido => pedido.cantidadDePasajeros()})

    method pedidosInstatisfechos() = pedidos.filter({pedido => flota.all({flota => not pedido.puedeSerSatisfecho(flota)})})
    
    method colorIncompatibleEnPedidos(unColor) = pedidos.all({pedido => pedido.coloresIncompatibles().contains(unColor)})
    method relajarPedidos(){
        pedidos.forEach({pedido => pedido.relajar()})
    }

    const property flota = []
    var property cantidadDeEmpleados 
    method agregarAFlota(rodado){
        flota.add(rodado)
    }
    method quitarDeFlota(rodado){
        flota.remove(rodado)
    }
    method capacidadTotal() = flota.sum({rodado => rodado.capacidad()})
    method pesoTotal() = flota.sum({rodado => rodado.peso()})
    method estaBienEquipada() = flota.size() >= 3 and flota.all({rodado => rodado.velocidadMaxima() >= 100})

    method capacidadTotalEnColor(unColor) = flota.sum({rodado => if(rodado.color() == unColor) rodado.capacidad() else 0 })

    method colorDelRodadoMasRapido() = flota.max({rodado => rodado.velocidadMaxima()}).color()
    method capacidadFaltante() = cantidadDeEmpleados - self.capacidadTotal()
    method esGrande() = cantidadDeEmpleados >= 40 and flota.size() >= 5

}

class Pedido{
    var property distanciaARecorrer
    var property tiempoMaximo
    var property cantidadDePasajeros
    var property coloresIncompatibles

    method velocidadRequerida() = distanciaARecorrer / tiempoMaximo

    method puedeSerSatisfecho(unAuto) = 
    (unAuto.velocidadMaxima() > self.velocidadRequerida() + 10) and (unAuto.capacidad() >= cantidadDePasajeros) and not coloresIncompatibles.contains(unAuto.color())

    method acelerar(){
        tiempoMaximo = 0.max(tiempoMaximo -1)
    }
    method relajar(){
        tiempoMaximo += 1
    }
}