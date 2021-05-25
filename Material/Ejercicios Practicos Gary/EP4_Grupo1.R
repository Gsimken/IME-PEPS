# Ejercicio practico N? 4
# Integrantes:
#              Kevin Arevalo
#              Cristobal Medrano
#              Felipe Morales
#              Gary Simken

# Importacion de librerias
library(TeachingDemos)
library(ggplot2)
library(ggpubr)
require(gridExtra)

# Se sabe que el proceso de fabricacion de barras de acero para concreto reforzado 
# producen barras conmedidas   de   dureza   que   siguen   una   distribucion 
# normal   con   desviacion   estandar   de   10   kilogramos   defuerza por milimetro 
# cuadrado. Usando una muestra aleatoria de tamanio 25, un ingeniero quiere averiguar si 
# una linea de produccion esta generando barras con dureza media de 170 [kgf mm-2].

# HO: La dureza media es 170 [kgf mm-2] (mu_dureza = 170)
# H1: La dureza media es mayor a 170 [kgf mm-2] (mu_dureza > 170)

# Definiciones de variables de acuerdo al enunciado
muestra.tamanio <- 25
muestra.sigma <- 10
muestra.media <- 170
muestra.errorEstandar <- muestra.sigma / sqrt (muestra.tamanio)

# Se busca realizar un t test, para ello se verifican las condiciones:
# Independencia y aleatoriedad de los datos: Se indica en el contexto.
# Tamaño de la muestra: 25, menor a 30.

# 1) Si el ingeniero  está seguro  que la verdadera dureza media  no  puede ser menor
# a los 170 [kgfmm-2] y piensa rechazar la hipotesis nula si la muestra presenta una 
# media mayor a 172 [kgf mm-2], ?cual es la probabilidad de que cometa un error de tipo 1?

# Calculo de la region de rechazo 
# Primero se calcula el percentil 172
muestra.colaDerecha <- pnorm(mean = muestra.media, sd = muestra.errorEstandar, q = 172)
# La region critica es el complemento del percentil 172
alpha <- 1 - muestra.colaDerecha

# Por lo tanto, la probabilidad de que se cometa un error tipo 1 es 0.1587 (15.9%).


# 2) Si   la   verdadera   dureza media   de   la   linea   de   produccion   fuera
# 173   [kgf   mm-2],   ?cual   sera la probabilidad de que el ingeniero, que obviamente 
# no conoce este dato, cometa un error de tipo 2?

# Segun los datos, se tiene que:
mediaVerdadera <- 173
mediaEstadistica <- 170

# Se realiza el calculo del t test (las condiciones ya fueron verificadas en el enunciado)
muestra.t_test <- power.t.test(n = 25,
                      sd = muestra.sigma,
                      sig.level = alpha,
                      power = NULL,
                      delta = mediaVerdadera - mediaEstadistica,
                      type = "one.sample",
                      alternative = "one.sided")

# Valor del poder obtenido
muestra.t_test$power

# El poder obtenido es de 0.6859 (68.6%), la probabilidad de cometer un error tipo 2 
# es 1 - poder.
probabilidadErrorTipo2 <- 1 - muestra.t_test$power

# Por lo tanto, la probabilidad de cometer un error tipo 2 es de 0.3141 (31.4 %).

# Descripcion grafica preguntas 1 y 2.

# Se generan los valores que tomara la dureza (eje x)
dureza <- seq(muestra.media - muestra.sigma + muestra.errorEstandar,
              muestra.media + muestra.sigma + muestra.errorEstandar,
              0.25)

# Se generan los valores que tomara la densidad (eje y)
# Para el caso de una media de 170 se tiene:
densidad_170 <- dnorm(dureza,
                      mean = muestra.media,
                      sd = muestra.errorEstandar)

# Para el caso de una media de 173 se tiene:
densidad_173 <- dnorm(dureza, 
                      mean = mediaVerdadera, 
                      sd = muestra.errorEstandar)

# Se entrelazan los datos generados en sus respectivas data frame
d_170 <- data.frame(dureza, densidad_170)
d_173 <- data.frame(dureza, densidad_173)


# Procedemos a generar el primer grafico (pregunta 1)
pA <- ggplot(data = d_170, mapping = aes(x = dureza))

# Se dibuja la linea que muestra la densidad
pA <- pA + stat_function(fun = dnorm, 
                         n = 100, 
                         args = list(mean = muestra.media, 
                                     sd = muestra.errorEstandar),
                         colour = "black", 
                         size = 1)

# Se pinta el area que corresponde al error tipo 1
pA <- pA + geom_area(data = subset(d_170, dureza >= 172),
                     aes(y = densidad_170, 
                         colour = "P(Error tipo 1)",
                         fill="P(Error tipo 1)"), 
                     alpha = 0.5)

# Se le agregan detalles esteticos, tales como titulo, leyenda y colores.
plot.error_tipo_1 <- pA + 
  theme(legend.position="right") + 
  labs(title = "Region critica (Error tipo 1)",
       x = "Dureza (kgf mm^-2)",
       y = "Densidad") +
  scale_color_manual(" ", values = c('P(Error tipo 1)' = "red"), 
                     aesthetics = c("colour", "fill"))


# De manera analoga al grafico 1, se genera el grafico 2 (pregunta 2)
pB <- ggplot(data = d_170, mapping = aes(x = dureza))

# Se dibuja la linea que muestra la densidad (media centrada en 170)
pB <- pB + stat_function(fun = dnorm, 
                         n = 100, 
                         args = list(mean = muestra.media, 
                                     sd = muestra.errorEstandar),
                         colour = "black", 
                         size = 1)

# Se dibuja la linea que muestra la densidad de la otra media ( media centrada en 173)
pB <- pB + stat_function(fun = dnorm,
                         n = 100, 
                         args = list(mean = mediaVerdadera,
                                     sd = muestra.errorEstandar), 
                         colour = "black", 
                         size = 1)

# Se pinta el area bajo la curva que corresponde al error tipo 2 (B)
pB <- pB + geom_area(data = subset(d_173, dureza <= 172),
                     aes(y = densidad_173, 
                         colour = "P(Error tipo 2)",
                         fill = "P(Error tipo 2)"),
                     alpha = 0.5)

# Se pinta el area bajo la curva que corresponde al poder (1-B)
pB <- pB + geom_area(data = subset(d_173, dureza >= 172),
                     aes(y = densidad_173, 
                         colour = "Poder",
                         fill = "Poder"),
                     alpha = 0.5)

# De manera analoga, se agregan los detalles esteticos pertinentes
plot.error_tipo_2_poder <- pB + 
  theme(legend.position="right") + 
  labs(title = "Poder y error tipo 2",
       x = "Dureza (kgf mm^-2)",
       y = "Densidad") +
  scale_color_manual(" ", values=c('P(Error tipo 2)' = "blue", 
                                   Poder = "green"),
                     aesthetics = c("colour", "fill"))

# OBS: Los graficos resultantes seran mostrados en conjunto al final del ejercicio.

# 3) Como no se conoce la verdadera dureza media, genere un grafico del poder estadistico 
# con las condiciones anteriores, pero suponiendo que las verdaderas durezas medias podrian
# variar de 171 a 178 [kgf mm-2].

# Funcion que calcula el poder en base a una media verdadera.
obtenerPoder <- function(x){
  return (1 - pnorm(172, mean = x, sd = muestra.errorEstandar))
}

# Se calcula el poder para medias verdaderas en un rango de (171, 178) [kgf mm-2]
media <- seq(171, 178, 1)
poder <- obtenerPoder(media)

# Se pasan los datos a un data frame para una mejor manipulacion.
poderes <- data.frame(media, poder)

# Se genera el grafico que correspone a la variacion del poder dependiendo de la 
# dureza media verdadera.
plot.poderes <- ggplot(poderes, 
                         aes(x=media, y=poder, color=media, fill=media)) + 
                         geom_point(size = 3) + 
                         geom_line()+
                         labs(title = "Poder vs Dureza media verdadera",
                              x = "Dureza media verdadera (kgf mm^-2)", 
                              y = "Poder")

# Se muestran los graficos obtenidos en el desarrollo del ejercicio.      
grid.arrange(plot.error_tipo_1, plot.error_tipo_2_poder, plot.poderes)

# Resumen de conclusiones respecto a las preguntas:
# Pregunta 1: La probabilidad de que el ingeniero cometa el error de rechazar
# H0, cuando esta es verdadera (que desconocemos si es asi) es de aproximadamente
# un 15.6%, lo cual es un valor alto poco fiable.
#
# Pregunta 2: La probabilidad de que el ingeniero cometa el error de tipo 2 es
# de un 31.4% (lamentablemente, el ingeniero no lo sabe) y este error sigue siendo alto.
# Otra conclusion observable es que existe un poder estadistico del 68.6% lo cual 
# significa que el ingeniero tiene un 68.6% de rechazar la hipotesis nula cuando
# esta es realmente falsa.
#
# Pregunta 3:
# Se aprecia que el poder crece, tendiendo a 1 (100%), a medida que se aumenta la media verdadera.
# A medida que la media verdadera aumenta, su distribucion se desplaza hacia la derecha,
# ocasionando que disminuya el Area del error tipo 2 (cola izquierda) y aumente el tamanio
# del efecto. Es importante resaltar, que con un poder de aproximadamente un 80% se puede llegar 
# a una buena conclusion, en nuestro caso, bastaria con una dureza media verdadera de 174 (kgf mm^-2).

