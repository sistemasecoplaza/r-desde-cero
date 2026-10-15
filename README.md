# 📊 R desde cero · Guía de estudio (nivel 0 a 4.5)

Guía para aprender R **sin saber programar**, pensada para preparar un examen.
Cada tema incluye una explicación en palabras simples, código listo para copiar, **el resultado exacto que muestra R**, ejercicios con solución y preguntas tipo examen.

👉 **Ver la guía:** https://sistemasecoplaza.github.io/r-desde-cero/

Funciona en celular, tablet y laptop, tiene modo claro/oscuro y recuerda en qué capítulo te quedaste.

## Contenido

| # | Capítulo | Nivel |
|---|----------|-------|
| 1 | Qué es R y cómo instalarlo | 0 |
| 2 | R como calculadora, variables y tipos | 1 |
| 3 | Vectores, factores y listas | 2 |
| 4 | Data frames: tus tablas | 2 |
| 5 | Condicionales, bucles y funciones | 3 |
| 6 | Paquetes, importar datos y dplyr | 4 |
| 7 | Gráficos con ggplot2 | 4 |
| 8 | Estadística básica (descriptiva, NA, correlación, prueba t, regresión) | 4.5 |
| 9 | Simulacro de examen (6 preguntas con solución) | — |
| 10 | Chuleta final para repaso rápido | — |

## Casos con datos simulados

| Caso | Objeto en R | Descripción |
|------|-------------|-------------|
| 🍽️ La cuenta del menú | variables sueltas | Cálculos básicos |
| 🎓 Salón de clase | `alumnos` | 8 alumnos con sección, horas de estudio y nota |
| 🛒 Bodegas | `ventas` | 120 ventas en Lima, Arequipa y Cusco, con o sin promoción |
| 📚 Estudio vs nota | `estudio` | 50 estudiantes para correlación y regresión |

Los datos se generan con `set.seed()`, así que al ejecutar el código obtendrás **exactamente** los mismos resultados que muestra la guía (verificado con R 4.6.1).

## Archivos

```
index.html               ← la guía (ábrela en el navegador)
codigo/guia_completa.R   ← todo el código de la guía, en orden
datos/ventas.csv         ← la base de ventas simulada, por si quieres practicar importando
img/                     ← gráficos generados con ggplot2
```

## Cómo practicar

1. Instala **R** (cran.r-project.org) y **RStudio Desktop** (posit.co).
2. Abre `codigo/guia_completa.R` en RStudio.
3. Instala los paquetes una sola vez: `install.packages(c("dplyr", "ggplot2"))`.
4. Ejecuta línea por línea con `Ctrl + Enter` mientras lees la guía.
