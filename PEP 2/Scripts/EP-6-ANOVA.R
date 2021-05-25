#==========================================================#
#======================= GRUPO 5 ==========================#
#==========================================================#
# Integrantes
# Sebastian Orellana 20.197.746-0
# Nicolas Salgado 19.848.869-0
# Cristobal Medrano 19.083.864-1
# Gary Simken 19.986.690-7

# Se importan las bibliotecas a utilizar.
library(ggpubr)
library(knitr)
library(tidyr)
require(ez)
library(car)

#==========================================================#
#======================Ejercicio 1=========================#
#==========================================================#
# El siguiente código R define los datos que aparecen en una tabla que compara 
# las mejores soluciones encontradas por cuatro algoritmos para instancias del
# problema del vendedor viajero con solución óptima conocida, tomados desde
# una memoria del DIINF. Con estos datos responda la pregunta de investigación:
# ¿Hay algoritmos mejores que otros?

# Del enunciado se extraen los siguientes datos.
p1_texto <- ("
Instancia Optimo R R2 R3 G
'brock400_2' 29 16.6 19.3 20.2 22
'brock400_4' 33 16.8 19.3 20.4 22
'C2000.9' 80 51.2 59.6 62.4 66
'c-fat500-10' 126 125 125 125 126
'hamming10-2' 512 243.2 419.1 422.4 512
'johnson32-2-4' 16 16 16 16 16
'keller6' 59 34.5 43 45.5 48.2
'MANN_a81' 1100 1082.2 1082.2 1082.2 1095.9
'p-hat1500-1' 12 6.9 8.1 8.9 10
'p-hat1500-3' 94 42.8 77.7 84.6 86
'san1000' 15 7.6 7.6 7.7 10
'san400_0.7_1' 40 19.6 20.5 20.5 21
'san400_0.9_1' 100 44.1 54.4 56.4 92
'frb100-40' 100 66.4 76.7 80.5 82
'frb59-26-1' 59 39.2 45.9 48.3 48
'1et.2048' 316 232.4 268.4 280.9 292.4
'1zc.4096' 379 253.8 293.2 307.4 328.5
'2dc.2048' 24 15.6 18.7 19.9 21
")
datos <- read.table(textConnection(p1_texto), header = TRUE)

# Como nos interesa analizar si un algoritmo es mejor que otro, comparamos
# cada instancia con su optimo, es decir, cada algoritmo fue divido por su
# optimo para asi tener una estandarizacion de los datos respecto a lo
# que nos propone el investigador.

# Se guardan los algoritmos a analizar en la variable algoritmos
algoritmos <- c('R', 'R2', 'R3', 'G')
# Se dividide cada algoritmo con respecto a su optimo.
R <- datos$R/datos$Optimo
R2 <- datos$R2/datos$Optimo
R3 <- datos$R3/datos$Optimo
G <- datos$G/datos$Optimo
dx4 <- list(R, R2, R3, G)
# Se crea la tabla de datos a utilizar.
p1_datos_wide <- data.frame(dx4)
colnames(p1_datos_wide) <- algoritmos

# Ya que se espera trabajar con el analisis de varianza, es mejor tener
# los datos en el formato long.
p1_datos_long <- gather(
  data = p1_datos_wide,
  key = "Algoritmo",
  value = "Tiempo_c_Optimo",
  algoritmos
)

# Recordar que estamos trabajando el tiempo del algoritmo con respecto a su
# optimo.
Problema <- factor(rep(1:nrow(p1_datos_wide), ncol(p1_datos_wide)))
p1_datos_long <- cbind(Problema, p1_datos_long)
p1_datos_long[["Algoritmo"]] <- factor(p1_datos_long[["Algoritmo"]])

# Una primera aproximacion es comparar los algoritmos con una grafico
# de cajas.
p1 <- ggboxplot(
  p1_datos_long,
  x = "Algoritmo", y = "Tiempo_c_Optimo",
  xlab = "Algoritmo usado", ylab = "Tiempo empleado respecto al Optimo",
  add = "jitter",
  add.params = list(color = "Algoritmo", fill = "Algoritmo")
)
print(p1)

# Ya con los datos trabajados, es momento de plantear las hipotesis y dar
# respuesta a lo que nos solicita el investigador.

# Las hipotesis planteadas son:
#
# H0: La media del tiempo empleado por cada algoritmo es el mismo en 
#     todas las mediciones aplicadas a los problemas.
# HA: La media del tiempo empleado por cada algoritmo en al menos una 
#     medicion aplicada a los problemas es distinta

# Condiciones para aplicar el test de ANOVA
# Estas se explican en el capitulo 15 de VarssarStats:
# 1. La variable dependiente tiene escala de intervalo
# 2. Las muestras son independientes al *interior* de los grupos
# 3. Se puede asumir que las poblaciones son aproximadamente normales
# 4. Las muestras tienen varianzas similares
# 5. La matriz de varianzas-covarianzas es esferica

# Para la condicion 3, obtenemos el mismo grafico QQ que vimos para el
# caso de muestras independientes (porque usamos los mimos valores).


# La condición 1 se verifica, ya que en 0.5 y 1 segundo hay 0.5 segundos
# de diferencia, lo mismo que entre 0 a 0.5.

# La condición 2 se verifica dado que ningun problema depende de otro (son
# instancias diferentes que se resuelven utilizando variaciones del algortimo
# del vendedor viajero).

# Para poder comprobar la condición 3, se trabajará con los datos 
# correspondientes a cada algoritmo divididos por el valor optimo de cada fila.
# Al realizar este calculo se obtienen los siguientes datos:

# Usando el grafico de QQ:
p1_grafico_qq <- ggqqplot(
  p1_datos_long,
  x = "Tiempo_c_Optimo",
  color = "Algoritmo"
)
p1_grafico_qq <- p1_grafico_qq + facet_wrap(~Algoritmo)

print(p1_grafico_qq)

# A primera vista pareciera ser que los datos siguen una distribución normal
# sin embargo para estar seguros se realiza un Test Shapiro para comprobarlo:

# Se define un alfa
alpha <- 0.01

# Y se realiza el Test para cada algoritmo

p1_shapiro_test <- by(
  data = p1_datos_long[["Tiempo_c_Optimo"]],
  INDICES = p1_datos_long[["Algoritmo"]],
  FUN = shapiro.test
)
p1_shapiro_test

# Dado que el p-valor es menor al alfa en 3 de los algoritmos se comprueba 
# la normalidad de los datos. Para el caso del Algoritmo R2 el p-valor es menor
# que el alfa, sin embargo, dado que esta diferencia es pequeña y que graficamente
# los valores parecen seguir una distribución normal, se asumen normalidad
# y se verifica la condición 3.

#----------------------
# Para la condición 4, se utiliza el test de levene:
p1_datos_long
leveneTest(Tiempo_c_Optimo ~ Algoritmo, p1_datos_long)

# Dado que Pr es mayor a alpha, no hay diferencias significativas entre las
# varianzas. Pr(>F) = 0.7961 > Alpha = 0.01

#----------------------
# Condición 5: Se asume que esta condición es verdadera. Posterior a la aplicacion
# del test de ANOVA, se puede refutar esto.

# Se utiliza la función ezANOVA
p1_ez.aov <- ezANOVA(
  data = p1_datos_long,
  dv = Tiempo_c_Optimo,
  wid = Problema,
  within = Algoritmo,
  type = 3,
  return_aov = TRUE
)
print(p1_ez.aov)
# La función también reporta un p-valor < 0.01 para la prueba de
# esfericidad, por lo que estos datos no estarían cumpliendo esa
# condición.

# Entonces, corresponde hacer un análisis post hoc.

# ----------------------------------------------------
# Análisis post-hoc
# ----------------------------------------------------

# Aquí, todavía podemos hacer pruebas T de Student entre pares de
# tratamientos, pero teniendo cuidado de usar pruebas para datos
# apareados.
mc <- pairwise.t.test(datos.long[["Errores"]], datos.long[["Duración"]],
                      paired = TRUE, p.adjust.method = "BH")
cat("\n\n")
cat("Comparaciones múltiples entre los tratamientos:\n")
cat("-----------------------------------------------\n")
print(mc)


# Visualmente el resultado del test de ANOVA es:
p1_ezp <- ezPlot(
  data = p1_datos_long,
  dv = Tiempo_c_Optimo,
  wid = Problema,
  within = Algoritmo,
  type = 3,
  x = Algoritmo
)
print(p1_ezp)
# En este grafico una media menor, significa, que el tiempo empleado
# es menor, por lo tanto, el algoritmo es mejor.

# Conclusión final
# Como el estadistico F = 23.62124 > 1 se rechaza la hipotesis nula. 
# Esto nos indica que la media del tiempo empleado por cada algoritmo 
# en al menos una medicion aplicada a los problemas es distinta.

# Por lo tanto, la evidencia indica que si existen algoritmos mejores que 
# otros para resolver las diferentes instancias del problema del vendedor
# viajero.


#==========================================================#
#======================Ejercicio 2=========================#
#==========================================================#
# Naming the ink color of color words can be difficult. For example, if asked to 
# name the color of the word "blue" is difficult because the answer (red) 
# conflicts with the word "blue." This interference is called "Stroop 
# Interference" after the researcher who first discovered the phenomenon. This 
# case study is a classroom demonstration. Students in an introductory statistics
# class were each given three tasks. In the "words" task, students read the names
# of 60 color words written in black ink; in the "color" task, students named the
# colors of 60 rectangles; in the "interference" task, students named the ink 
# color of 60 conflicting color words. The times to read the stimuli were 
# recorded. There were 31 female and 16 male students.
# El siguiente código R define los datos que se obtuvieron en este estudio. 
# Con estos datos, responda la siguiente pregunta de investigación: 
# ¿Hay diferencias en los tiempos entre tareas y género?

p2_texto <- ("
gender words colors interfer
1 19 15 31
1 21 20 38
1 9 25 38
1 21 19 32
1 16 15 29
1 16 16 36
1 17 23 34
1 21 19 44
1 9 14 42
1 23 17 37
1 18 19 31
2 26 24 33
2 18 19 44
2 17 21 31
2 12 5 44
2 21 17 35
2 19 21 34
2 16 15 32
2 13 22 47
2 13 24 29
2 15 19 38
2 15 26 42
")
# Por correcciones del enunciado, solo se trabaja con los datos sin el sexo
# del estudiante
p2_datos_con_genero <- read.table(textConnection(p2_texto), header = TRUE)
p2_tareas <-c('words', 'colors', 'interfer')

# Datos sin la columna sexo
p2_datos_wide <- p2_datos_con_genero[p2_tareas]

# Como se planea trabajar con el test de ANOVA, es necesario que los datos
# esten en formato long.
p2_datos_long <- gather(
  data = p2_datos_wide,
  key = "Tarea",
  value = "Tiempo",
  all_of(p2_tareas)
)

Persona <- factor(rep(1:nrow(p2_datos_wide), ncol(p2_datos_wide)))
p2_datos_long <- cbind(Persona, p2_datos_long)
p2_datos_long[["Tarea"]] <- factor(p2_datos_long[["Tarea"]])

# Una primera aproximacion es comparar las tareas con una grafico de cajas.
p2 <- ggboxplot(
  p2_datos_long,
  x = "Tarea", y = "Tiempo",
  xlab = "7 usado", ylab = "Tiempo empleado",
  add = "jitter",
  add.params = list(color = "Tarea", fill = "Tarea")
)
print(p2)

# Se planean las hipotesis para dar respuesta a lo que nos indica el 
# investigador:
#
# H0: La media del tiempo empleado por cada tarea es el mismo en 
#     todas las mediciones aplicadas a los estudiantes
# HA: La media del tiempo empleado por cada tarea en al menos una 
#     medicíón aplicada a los problemas es distinta.
#

# Para aplicar el test de ANOVA es necesario que se cumplan las condiciones
# explicadas en el capitulo 15 de VarssarStats:
# 1. La variable dependiente tiene escala de intervalo
# 2. Las muestras son independientes al *interior* de los grupos
# 3. Se puede asumir que las poblaciones son aproximadamente normales
# 4. Las muestras tienen varianzas similares
# 5. La matriz de varianzas-covarianzas es esferica
# Para la condiciÃ³n 3, obtenemos el mismo grafico QQ que vimos para el
# caso de muestras independientes (porque usamos los mimos valores).

# La condicion 1 se verifica, ya que en 5 y 15 segundo hay 10 segundos
# de diferencia, lo mismo que entre 10 y 20.

# La condicion 2 se verifica dado que son personas distintas.

# Para la condicion 3, obtenemos usamos un grafico QQ, que nos muestra
# la normalidad de los datos
p2_grafico_QQ <- ggqqplot(
  p2_datos_long,
  x = "Tiempo",
  color = "Tarea"
)
p2_grafico_QQ <- p2_grafico_QQ + facet_wrap(~Tarea)

# Se muestra el grafico
print(p2_grafico_QQ)

# A primera vista pareciera ser que los datos siguen una distribución normal
# sin embargo para estar seguros se realiza un Test Shapiro para comprobarlo:

# Se define un alfa
alpha <- 0.01

# Y se realiza el Test para cada algoritmo

p2_shapiro_test <- by(
  data = p2_datos_long[["Tiempo"]],
  INDICES = p2_datos_long[["Tarea"]],
  FUN = shapiro.test
)
p2_shapiro_test

#----------------------
# Para la condición 4, se utiliza el test de levene:
leveneTest(Tiempo ~ Tarea, p2_datos_long)

# Dado que Pr es mayor a alpha (Pr = 0.3144 > Alpha = 0.01), no hay diferencias
# significativas entre las varianzas.

#----------------------
# Condición 5: Se asume que esta condición es verdadera. Posterior a la aplicacion
# del test de ANOVA, se puede refutar esto.

# Se utiliza la función ezANOVA
p2_ez.aov <- ezANOVA(
  data = p2_datos_long,
  dv = Tiempo,
  wid = Persona,
  within = Tarea,
  type = 3,
  return_aov = TRUE
)
print(p2_ez.aov)

# La función también reporta un p-valor = 0.3539676 para la prueba de
# esfericidad, por lo que estos datos sí estarían cumpliendo esa
# condición.

# Entonces, no corresponde hacer un análisis post hoc.

# Graficamente
p2_ezp <- ezPlot(
  data = p2_datos_long,
  dv = Tiempo,
  wid = Persona,
  within = Tarea,
  type = 3,
  x = Tarea
)
print(p2_ezp)
# Conclusiones
# Ya que el valor del estadistico F 98.81415 > 1 la hipotesis nula es falsa,
# por lo tanto, se rechaza y se asume que la media del tiempo empleado por cada
# tarea en al menos una medicion aplicada a los problemas es distinta.

# Por lo tanto, la evidencia indica que si existe diferencia en los tiempos
# entre tareas.
