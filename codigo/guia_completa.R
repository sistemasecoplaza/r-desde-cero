# =============================================================
#  R DESDE CERO - Código completo de la guía (nivel 0 a 4.5)
#  Copia, pega y ejecuta línea por línea con Ctrl + Enter.
#  Todos los datos son SIMULADOS (inventados) para practicar.
# =============================================================


# -------------------------------------------------------------
# NIVEL 0 - Primer código
# -------------------------------------------------------------
print("Hola, R")
2 + 2


# -------------------------------------------------------------
# NIVEL 1 - R como calculadora, variables y tipos
# -------------------------------------------------------------
5 + 3
9 / 2
2 ^ 3
10 %% 3      # resto de la división
10 %/% 3     # división entera
sqrt(16)
round(3.14159, 2)

# Caso: la cuenta del menú
precio_menu <- 12.5
personas    <- 4
total       <- precio_menu * personas
total
total / personas

nombre <- "Ana"
class(precio_menu)
class(nombre)
class(TRUE)
class(5L)

5 > 3
5 == 5
5 != 4
(7 > 3) & (2 > 5)   # Y: ambas deben ser TRUE
(7 > 3) | (2 > 5)   # O: basta con una TRUE


# -------------------------------------------------------------
# NIVEL 2 - Vectores, factores y listas
# -------------------------------------------------------------
notas <- c(14, 18, 9, 16, 11)
notas
notas[2]
notas[c(1, 3)]
notas[-1]
length(notas)
mean(notas)
sum(notas); max(notas); min(notas)
notas + 1
notas >= 11
notas[notas >= 11]
sum(notas >= 11)    # cuántos aprobaron

1:5
seq(0, 20, by = 5)
rep("A", 3)

c(1, "dos", TRUE)   # se convierte todo a texto

seccion <- factor(c("A", "B", "A", "A", "B"))
levels(seccion)
table(seccion)

alumno <- list(nombre = "Ana", edad = 20, notas = c(14, 18))
alumno$nombre
alumno$notas


# -------------------------------------------------------------
# NIVEL 2 - Data frames (Caso: salón de clase)
# -------------------------------------------------------------
alumnos <- data.frame(
  nombre  = c("Ana", "Bruno", "Carla", "Diego", "Elena", "Fabio", "Gina", "Hugo"),
  seccion = c("A", "A", "B", "B", "A", "B", "A", "B"),
  horas   = c(10, 4, 8, 2, 12, 6, 9, 3),
  nota    = c(17, 10, 15, 8, 19, 12, 16, 9)
)
alumnos
str(alumnos)
nrow(alumnos); ncol(alumnos)
names(alumnos)
summary(alumnos$nota)

alumnos$nota
alumnos[3, ]
alumnos[3, "nota"]
alumnos[alumnos$nota >= 11, ]
alumnos[alumnos$seccion == "A", c("nombre", "nota")]

alumnos$aprobado <- alumnos$nota >= 11
alumnos[order(-alumnos$nota), c("nombre", "nota")]


# -------------------------------------------------------------
# NIVEL 3 - Condicionales, bucles y funciones
# -------------------------------------------------------------
nota <- 13
if (nota >= 11) {
  print("Aprobado")
} else {
  print("Desaprobado")
}

alumnos$estado <- ifelse(alumnos$nota >= 11, "Aprobado", "Desaprobado")
alumnos[, c("nombre", "nota", "estado")]

for (i in 1:3) {
  print(paste("Vuelta número", i))
}

for (n in alumnos$nombre[1:3]) {
  print(paste("Hola,", n))
}

con_igv <- function(precio, tasa = 0.18) {
  precio * (1 + tasa)
}
con_igv(100)
con_igv(100, 0.10)

calificar <- function(nota) {
  if (nota >= 17) {
    "Excelente"
  } else if (nota >= 11) {
    "Aprobado"
  } else {
    "Desaprobado"
  }
}
calificar(18)
calificar(12)
calificar(7)
sapply(alumnos$nota, calificar)


# -------------------------------------------------------------
# NIVEL 4 - Paquetes y datos simulados de ventas
# -------------------------------------------------------------
# install.packages("dplyr")    # SOLO una vez
# install.packages("ggplot2")  # SOLO una vez
library(dplyr)
library(ggplot2)

set.seed(123)   # "semilla": hace que los números al azar salgan siempre iguales
n <- 120
ventas <- data.frame(
  tienda   = sample(c("Lima", "Arequipa", "Cusco"), n, replace = TRUE),
  producto = sample(c("Arroz", "Aceite", "Leche", "Pan"), n, replace = TRUE),
  promo    = sample(c("Si", "No"), n, replace = TRUE),
  precio   = round(runif(n, min = 2, max = 15), 1)
)
ventas$cantidad <- rpois(n, lambda = ifelse(ventas$promo == "Si", 8, 5))
head(ventas)

# Guardar y volver a leer como CSV (así se importan datos reales)
write.csv(ventas, "ventas.csv", row.names = FALSE)
ventas <- read.csv("ventas.csv")

ventas |>
  filter(tienda == "Lima") |>
  head(3)

ventas |>
  select(producto, precio) |>
  head(3)

ventas <- ventas |>
  mutate(total = precio * cantidad)

ventas |>
  arrange(desc(total)) |>
  head(3)

ventas |>
  group_by(tienda) |>
  summarise(n_ventas = n(),
            ingreso  = sum(total),
            promedio = mean(total))

ventas |>
  filter(promo == "Si") |>
  group_by(producto) |>
  summarise(ingreso = sum(total)) |>
  arrange(desc(ingreso))

ventas |> count(tienda, promo)


# -------------------------------------------------------------
# NIVEL 4 - Gráficos con ggplot2
# -------------------------------------------------------------
resumen <- ventas |>
  group_by(tienda) |>
  summarise(ingreso = sum(total))

g1 <- ggplot(resumen, aes(x = tienda, y = ingreso)) +
  geom_col(fill = "#276dc3") +
  labs(title = "Ingreso total por tienda", x = "Tienda", y = "Soles") +
  theme_minimal()
g1

g2 <- ggplot(ventas, aes(x = total)) +
  geom_histogram(bins = 12, fill = "#276dc3", color = "white") +
  labs(title = "¿Cuánto se vende por ticket?", x = "Total (S/)", y = "Frecuencia") +
  theme_minimal()
g2

g3 <- ggplot(ventas, aes(x = promo, y = cantidad, fill = promo)) +
  geom_boxplot() +
  labs(title = "Unidades vendidas con y sin promoción", x = "¿Hubo promo?", y = "Unidades") +
  theme_minimal() +
  theme(legend.position = "none")
g3

ggsave("grafico_tiendas.png", g1, width = 7, height = 5)


# -------------------------------------------------------------
# NIVEL 4.5 - Estadística básica (Caso: horas de estudio vs nota)
# -------------------------------------------------------------
set.seed(42)
estudio <- data.frame(horas = round(runif(50, 0, 12), 1))
estudio$nota <- round(6 + 1 * estudio$horas + rnorm(50, 0, 1.5))
estudio$nota <- pmin(estudio$nota, 20)   # la nota máxima es 20
head(estudio)

mean(estudio$nota); median(estudio$nota); sd(estudio$nota)
quantile(estudio$nota)
summary(estudio$nota)

# Datos faltantes
v <- c(15, NA, 12, 18)
mean(v)
mean(v, na.rm = TRUE)
is.na(v)
sum(is.na(v))

# Correlación
cor(estudio$horas, estudio$nota)

# Prueba t: ¿la promo cambia las unidades vendidas?
t.test(cantidad ~ promo, data = ventas)

# Regresión lineal simple
modelo <- lm(nota ~ horas, data = estudio)
summary(modelo)
predict(modelo, newdata = data.frame(horas = 8))

g4 <- ggplot(estudio, aes(x = horas, y = nota)) +
  geom_point(color = "#276dc3", size = 2.5) +
  geom_smooth(method = "lm", color = "#e0633a") +
  labs(title = "Más horas de estudio, mejor nota", x = "Horas de estudio", y = "Nota") +
  theme_minimal()
g4
