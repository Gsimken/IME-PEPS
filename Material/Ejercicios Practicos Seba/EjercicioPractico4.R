# Integrantes: Sebastian Orellana
#              Nicol�s Salgado
#              Alex Mellado
#              Flavio Ramos

library(ggpubr)

# PREGUNTA C
# Si el ingeniero piensa rechazar la hip�tesis nula si la muestra presenta una 
# media menor a 168 [kgf mm-2] o mayor a 172 [kgf mm-2], pero la verdadera 
# dureza media de la l�nea de producci�n fuera 173 [kgf mm-2],

# 1. �cu�l ser�a la probabilidad de que el ingeniero, que obviamente no conoce 
# este dato, tome la decisi�n correcta de rechazar la hip�tesis nula en favor
# de la hip�tesis alternativa?

n <- 25              # tama�o muestra
media <- 170         # media de la muestra
sigma <- 10          # desviaci�n estandar
se <- sigma/sqrt(n)  # error estandar

# se obtiene la probabilidad de la cola superior e inferior (distribucion normal)
colaInferior <- pnorm(mean = media, sd = se, q = 168)
colaSuperior <- 1 - pnorm(mean = media, sd = se, q = 172)

alfa <- colaInferior + colaSuperior    #nivel de significaci�n

# se grafica el nivel de significancia en la distribuci�n
x <- rnorm(n, mean = media, sd = sigma)
y <- dnorm(x, mean = media, sd = sigma)
dist <- data.frame(x,y)

g1 <- ggplot(data = dist, aes(x))
g1 <- g1 + stat_function(fun = dnorm,
                         n = 200,
                         args = list(mean = media, sd = sigma),
                         colour = "dark green",
                         size = 1)

g2 <- g1 + geom_area(data = subset(dist, x > 172), 
                     aes(y = y),
                     colour = "darkorange3",
                     fill = "darkorange3",
                     alpha = 0.6)
grafico1 <- g2 + geom_area(data = subset(dist, x < 168), 
                     aes(y = y),
                     colour = "darkorange3",
                     fill = "darkorange3",
                     alpha = 0.6)
grafico1

#Se realiza la prueba para obtener el poder estad�stico
test <- power.t.test(n = n, 
                    delta = 3, 
                    sd = sigma, 
                    sig.level = alfa, 
                    power = NULL,
                    type = "one.sample",
                    alternative = "two.sided")

print(test)

#Respuesta 1
#La probabilidad que tiene el ingeniero de tomar la decision correcta de 
#rechazar la hipoteiss nula en favor de la alternativa es de 0.6859

# ------------------------------------------------------------------------
# �A cu�nto cambiar�a esta probabilidad si se pudiera tomar una muestra de 
# 64 barras?

n2 <- 64                   # nuevo tama�o de la muestra
se <- sigma/sqrt(n2)       # se calcula de nuevo el error estandar

# se obtiene la probabilidad de la cola superior e inferior (distribucion normal)
colaInferior <- pnorm(mean = media, sd = se, q = 168)
colaSuperior <- 1 - pnorm(mean = media, sd = se, q = 172)

alfa <- colaInferior + colaSuperior      # nivel de significaci�n

# se grafica el nivel de significancia en la distribuci�n
x <- rnorm(n2, mean = media, sd = sigma)
y <- dnorm(x, mean = media, sd = sigma)
dist <- data.frame(x,y)

g1 <- ggplot(data = dist, aes(x))
g1 <- g1 + stat_function(fun = dnorm,
                         n = 200,
                         args = list(mean = media, sd = sigma),
                         colour = "dark green",
                         size = 1)

g2 <- g1 + geom_area(data = subset(dist, x > 172), 
                     aes(y = y),
                     colour = "darkorange3",
                     fill = "darkorange3",
                     alpha = 0.6)
grafico2 <- g2 + geom_area(data = subset(dist, x < 168), 
                           aes(y = y),
                           colour = "darkorange3",
                           fill = "darkorange3",
                           alpha = 0.6)
grafico2

# Se realiza el segundo test para conocer el poder estad�stico
test2 <- power.t.test(n = n2, 
                     delta = 3, 
                     sd = sigma, 
                     sig.level = alfa, 
                     power = NULL,
                     type = "one.sample",
                     alternative = "two.sided")

print(test2)

# Respuesta 2
# Al aumentar el tama�o de la muestra aumenta la probabilidad de tomar la
# decision correcta (rechazar la hipotesis nula en favor de la alternativa)

# -----------------------------------------------------------------------------
# �Cu�ntas barras deber�an revisarse para conseguir un poder estad�stico de 0,90 y un nivel de
# significaci�n de 0,05?
  
alfa <- 0.05                          # nuevo nivel de signifcaci�n

# se realiza la prueba para conocer el tama�o de la muestra deseado
test3 <- power.t.test(n = NULL, 
                      delta = 3, 
                      sd = sigma, 
                      sig.level = alfa, 
                      power = 0.9,
                      type = "one.sample",
                      alternative = "two.sided")

print(test3)
# Respuesta 3
# Se deber�a tomar una muestra de 119 barras (observaciones) para conseguir 
# un poder estadistico de 0.9 a un nivel de significaci�n de 0.05

# ---------------------------------------------------------------------------------
# �Y si quisiera ser bien exigente y bajar la probabilidad de cometer un error de tipo 1 a un 1%
# solamente?
alfa <- 0.01                           #nuevo nivel de significancia (mas estricto)

# Se realiza una nueva prueba para conocer el tama�o de la muestra deseada
test4 <- power.t.test(n = NULL, 
                      delta = 3, 
                      sd = sigma, 
                      sig.level = alfa, 
                      power = 0.9,
                      type = "one.sample",
                      alternative = "two.sided")

print(test4)

# Respuesta Pregunta 4
# Si se desea ser muy exigiente y bajar la probabilidad de cometer error
# de tipo 1 a un 1% se deber�a obtener 169 observaciones para tner un 
# poder estad�stico de 0.9

