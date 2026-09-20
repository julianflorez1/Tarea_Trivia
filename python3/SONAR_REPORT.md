# Informe de calidad SonarQube - Trivia Python 3

**Proyecto:** `Trivia`  
**Fuente analizada:** `python3/trivia.py`  
**Fecha del análisis:** 2026-09-19  
**Resultado del análisis:** Exitoso  
**Panel:** http://localhost:9000/dashboard?id=Trivia

## Resumen ejecutivo

SonarQube analizó correctamente la implementación de Python 3. El Quality Gate aparece como `OK` y no se detectaron errores de tipo bug. Sin embargo, el proyecto tiene cobertura de pruebas de `0%` y mantiene tres incidencias abiertas: dos vulnerabilidades de seguridad y un problema menor de mantenibilidad.

## Métricas

| Métrica | Resultado | Evaluación |
|---|---:|---|
| Quality Gate | `OK` | Cumple las condiciones actuales |
| Líneas de código | `127` | Código Python analizado |
| Bugs | `0` | Sin bugs detectados |
| Vulnerabilidades | `2` | Requieren revisión |
| Code smells | `1` | Requiere mejora menor |
| Violaciones totales | `3` | Incidencias abiertas |
| Cobertura | `0.0%` | No hay pruebas instrumentadas |
| Duplicación | `0.0%` | Sin duplicación detectada |
| Esfuerzo estimado | `22 min` | Tiempo aproximado de corrección |

## Incidencias encontradas

### 1. Uso de comparación negada

- **Regla:** `python:S1940`
- **Tipo:** Code smell
- **Severidad:** Minor
- **Ubicación:** [trivia.py](trivia.py#L143)
- **Mensaje:** Usar el operador opuesto (`!=`) en lugar de negar la igualdad.
- **Esfuerzo estimado:** 2 minutos

La expresión puede simplificarse para mejorar la legibilidad, sustituyendo la comparación negada por una comparación directa con `!=`.

### 2. Generador pseudoaleatorio en la ejecución del juego

- **Regla:** `python:S2245`
- **Tipo:** Vulnerabilidad / Security hotspot
- **Severidad:** Major
- **Ubicación:** [trivia.py](trivia.py#L158)
- **Esfuerzo estimado:** 10 minutos

### 3. Generador pseudoaleatorio en la selección de respuesta

- **Regla:** `python:S2245`
- **Tipo:** Vulnerabilidad / Security hotspot
- **Severidad:** Major
- **Ubicación:** [trivia.py](trivia.py#L160)
- **Esfuerzo estimado:** 10 minutos

En este juego el azar no parece estar relacionado con autenticación, tokens, contraseñas ni decisiones de seguridad. Por tanto, estas dos incidencias probablemente son falsos positivos desde el punto de vista funcional, pero deben revisarse y marcarse como aceptadas o refactorizarse según el criterio del proyecto.

## Limitaciones del análisis

- No se encontraron pruebas automatizadas para `trivia.py`.
- No se generó un informe `coverage.xml`.
- La cobertura reportada por SonarQube es `0.0%`, no necesariamente porque cada línea sea incorrecta, sino porque no se ejecutaron pruebas con cobertura.
- El análisis se limitó a la carpeta `python3`; las demás implementaciones del repositorio no fueron analizadas en esta ejecución.

## Plan recomendado

1. Crear pruebas de caracterización para `Game`.
2. Cubrir creación de preguntas, jugadores, categorías, movimiento, penalización y respuestas.
3. Ejecutar las pruebas con `coverage.py` y generar `coverage.xml`.
4. Volver a ejecutar SonarQube para actualizar la cobertura.
5. Revisar las dos incidencias `S2245` y documentar su aceptación si el azar solo controla la dinámica del juego.
6. Corregir la incidencia `S1940` y repetir el análisis.

## Conclusión

La ejecución original de SonarQube fue correcta y el Quality Gate estaba aprobado. Esta versión corrige los hallazgos de código y añade pruebas automatizadas. Aún falta generar `coverage.xml` y repetir el análisis con un token nuevo para confirmar las métricas actualizadas.

## Cambios aplicados para la siguiente versión

- Se corrigió el índice utilizado por `Game.add()`, evitando el desplazamiento de jugadores y el `IndexError` al agregar seis jugadores.
- Se reemplazó la comparación negada de `_did_player_win()` por `!=`, atendiendo la regla `python:S1940`.
- Se reemplazó `random.randrange` por `secrets.randbelow`, atendiendo las dos incidencias `python:S2245` del flujo ejecutable.
- Se añadieron cinco pruebas unitarias en [test_trivia.py](test_trivia.py), todas aprobadas localmente.
- La compilación de `trivia.py` y `test_trivia.py` también fue validada correctamente.

La nueva ejecución de SonarQube debe realizarse después de configurar un token nuevo para confirmar la desaparición de las tres incidencias y actualizar la cobertura.