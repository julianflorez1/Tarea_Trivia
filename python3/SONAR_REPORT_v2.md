# Informe de calidad - Trivia Python 3 - Version 2

**Proyecto:** `Trivia`  
**Fuente:** `python3/trivia.py`  
**Fecha:** 2026-09-19  
**Repositorio:** https://github.com/julianflorez1/Tarea_Trivia

## Estado de validacion

La nueva version fue validada localmente antes del commit:

- Pruebas ejecutadas: `5`
- Pruebas aprobadas: `5`
- Pruebas fallidas: `0`
- Compilacion de `trivia.py` y `test_trivia.py`: correcta
- Cobertura: pendiente; `coverage.py` no esta instalado
- Analisis SonarQube v2: pendiente de ejecutar con un token nuevo

## Cambios incluidos

1. Se corrigio el indice usado por `Game.add()`. Los jugadores ahora ocupan las posiciones `0` a `5` y el sexto jugador ya no provoca `IndexError`.
2. Se reemplazo la comparacion negada de `_did_player_win()` por el operador `!=`, atendiendo la regla `python:S1940`.
3. Se reemplazo `random.randrange` por `secrets.randbelow`, atendiendo las incidencias `python:S2245` detectadas en la version anterior.
4. Se agregaron cinco pruebas unitarias en [test_trivia.py](test_trivia.py).

## Pruebas cubiertas

- Inicializacion de 50 preguntas por categoria.
- Registro de seis jugadores sin desplazamiento de estado.
- Determinacion de categorias por posicion del tablero.
- Envio del jugador actual a la caja de penalizacion.
- Incremento de monedas y rotacion del jugador tras una respuesta correcta.

## Comparacion con el reporte anterior

El reporte original de SonarQube registro:

- `0` bugs.
- `2` vulnerabilidades asociadas al generador pseudoaleatorio.
- `1` code smell asociado a una comparacion negada.
- `0%` de cobertura porque no habia pruebas instrumentadas.

El codigo de esta version atiende las tres incidencias de codigo identificadas. SonarQube debe ejecutarse nuevamente para confirmar el resultado y actualizar las metricas de cobertura.

## Ejecucion pendiente de SonarQube

Desde la raiz del repositorio, con un token nuevo configurado en la sesion actual de PowerShell:

```powershell
$env:SONAR_TOKEN = "TU_TOKEN_NUEVO"
.\python3\Trivia_Test.ps1
```

El token debe mantenerse fuera del repositorio y no debe incluirse en URLs, scripts ni documentos.

## Conclusion

La version 2 tiene pruebas automatizadas basicas y corrige el defecto funcional del limite de seis jugadores, junto con los tres hallazgos de la ejecucion SonarQube anterior. El siguiente paso de calidad es repetir SonarQube con autenticacion valida y añadir cobertura formal cuando `coverage.py` este disponible.
