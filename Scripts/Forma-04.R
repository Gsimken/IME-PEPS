# =========================================================================== #
# =================          PEP 1 Inferencia           ===================== #
# =================  Integrantes: Sebastian Orellana    ===================== #
# =================               Rut: 20.197.746-0     ===================== #
# =================               Gary Simken           ===================== #
# =================               Rut: 19.986.690-7     ===================== #
# =========================================================================== #

# Liberías a utilizar
# ===================
library(ggpubr)
library(ggplot2)


# Se carga el Dataset a utilizar
# ==============================
# Esta dirección se debe cambiar al momento de ejecutar el script por la direccion local
dir <- "C:/Users/Gary/Desktop/GITHUB/Pep1-IME-Grupo-6/Material/"
basename <- "IME-2020-2-PE1-datos.csv"
file <- file.path(dir, basename)

# Se guarda el data-set en una variable
población <- read.csv(file = file, encoding = "UTF-8")


# ============================================================================= #
# Pregunta 1
# ==========
#


#Se define el tamaño de la muestra y la semilla a usar
semilla <- 109
tamaño.muestra <- 25

#Se filtran los pacientes vivos y muertos
pacientes.vivos <- población$age[población$DEATH_EVENT == 0]
pacientes.muertos<-población$age[población$DEATH_EVENT == 1]

#Se calcula el tamaño de los vectores anteriores
tamaño.vivos<-length(pacientes.vivos)
tamaño.muertos<-length(pacientes.muertos)

#se extrae una muestra de pacientes vivos y muertos
muestra.vivos <- pacientes.vivos[sample(1:tamaño.vivos, tamaño.muestra)]
muestra.muertos<-pacientes.muertos[sample(1:tamaño.muertos, tamaño.muestra)]

#H0: La diferencia entre las media de edad de los pacientes que fallecieron entre
#el periodo de control y los que fallecieron es igual a 5 años
#HA:Las diferencia entre las media de edad de los pacientes que fallecieron entre 
#el periodo de control y los que fallecieron es MAYOR a 5 años
#H0: μ==5
#HA: μ>5
#definimos μ:
μ=5

#Para determinar si la estimacion hecha por el estudio es correcta se plantea la
#utilizacion de una prueba de t de student.

#Condiciones para utilización de T-Test
# Condición 1: Dado que la extraccion de muestras fue aleatoria mediante r, no hay sesgo
#y ademas podemos asumir que el tamaño de la muestra es menor al 10% de la población
#de pacientes con fallas coronarias,se puede decir que las muestras son idependientes.
# 
# Condición 2:  Se crean graficos para revisar la condicion de normalidad:


d <- data.frame(muertos = muestra.muertos)

muertos.1 <- gghistogram(
  d, x = "muertos",
  binwidth = 5,
  color = "#6D9EC1",
  fill = "#BFD5E3"
)

muertos.2 <- ggqqplot(
  d, x = "muertos",
  color = "#6D9EC1",
  fill = "#BFD5E3"
)
d <- data.frame(vivos = muestra.vivos)

vivos.1 <- gghistogram(
  d, x = "vivos",
  binwidth = 5,
  color = "#6D9EC1",
  fill = "#BFD5E3"
)

vivos.2 <- ggqqplot(
  d, x = "vivos",
  color = "#6D9EC1",
  fill = "#BFD5E3"
)
muertos.1
muertos.2
vivos.1
vivos.2

# Los datos  parecen seguir una distribución casi normal,
# aunque con una muestra tan pequeña, tampoco es seguro que esto sea
# así. Podemos proceder con el test T de Student, pero siendo un poco mas exigente
# de lo usual con el nivel de significación:
α <- 0.04

#se realiza el t-test
ttest<-t.test(muestra.vivos,muestra.muertos,
             mu=μ,
             alternative="greater",
             conf.level = 1 - α)

ttest

#se calcula unico vector entre ambos con la diferencia de los datos
diff<-muestra.vivos-muestra.muertos
diff.media<-mean(diff)
diff.sd<-sd(diff)

#se calcula el poder
power.t=power.t.test(n=tamaño.muestra,
                     delta=diff.media,
                     sd=diff.sd,
                     sig.level=α,
                     power=NULL,
                     alternative="one.sided")
power.t

#Conclusion:
#Dado que se obtuvo un p-value = 1, no existe evidencia suficiente para rechazar
#la hipostesis nula

#stop()

# Pregunta 2
# ==========
#

#se define de antemano lo pedido en el enunciado
semilla <- 331
tamaño.muestra <- 60
α <- 0.05

#H0: dos tercios de las personas muertas por fallas coronarias reclutadas presentaron
#presion arterial anormalmente altas
#HA: La proporcion de pacientes con fallas coronarias que presentaron presion arterial es diferente de 2/3
#H0: p==2/3
#HA: p<>2/3



#se extraen todos los pacientes muertos de la poblacion
pacientes.muertos<-población$high_blood_pressure[población$DEATH_EVENT == 1]

#se realiza una muestra
tamaño.muertos<-length(pacientes.muertos)
muestra.muertos<-pacientes.muertos[sample(1:tamaño.muertos, tamaño.muestra)]

#se representan las probabilidad esperada dada por el estudio
prop.esp<-2/3

#se calcula la probabilidad obs de la muestra
presion.alta<-length(muestra.muertos[muestra.muertos==1])
prop.obs<-presion.alta/tamaño.muestra

#Se realiza un test de probabilidades
prop.test(prop.obs,tamaño.muestra,p=prop.esp,alternative="two.sided",conf.level=1-α)

#se calcula el poder
power.prop.test(tamaño.muestra,prop.esp,prop.obs,α,power=NULL,alternative="two.sided")

#Conclusiones:
#Dado que el p-value es menor que α rechaza la hipotesis nula, por lo tanto 
#La proporcion de pacientes con fallas coronarias que al momento de morir, presentaron presion arterial es diferente de 2/3

stop()
# Pregunta 3
# ==========
#
#
#
# desarrollo de la pregunta ...
#
#
#


# Pregunta 4
# ==========

#4.a) Aunque las medianas son iguales para ambos grupos, el 50% de las personas de estos presenta una concentración igual o menor a 137 [mEq/L] aproximadamente, se observa que los percentiles
#25 y 75 difieren. Con respecto al primero -P25-, las personas no fumadoras que se encuentran en el 25% más bajo de concentración de sodio, registran 134,5 [mEq/L] aproximadamente, mientras 
#que, en el grupo de fumadores, tal cifra asciende a 136 [mEq/L] aproximadamente. Al mismo tiempo, siguiendo tal tendencia, se observa que el 25% de las personas que concentra mayores niveles 
#de sodio sérico, presenta 137,5 [mEq/L] aproximadamente versus el 139, 5 [mEq/L] que se observa en los fumadores. Estos datos permiten afirmar que los fumadores tienden a presentar mayores 
#concentraciones de sodio sérico, en comparación con los no fumadores. Esto se respalda en las partes inferiores (P25) y superiores (P75) de ambas distribuciones.


