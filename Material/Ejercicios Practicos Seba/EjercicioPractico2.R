#Tomar una muestra de 100 datos desde la poblaci�n con una semilla propia

#Discutir y consensuar qu� medidas estad�sticas (media, mediana, moda, etc.) 
#y qu� forma gr�fica ayudar�a a responder las preguntas asignadas 

#Construir un script en R que produzca los estad�sticos y el gr�fico 
#seleccionado que resuman los datos muestreados para la primera pregunta asignada

#f y a

#a. �Se encuestaron m�s o menos la misma cantidad de gente en cada provincia 
#de la RM?

library(ggplot2)
library(ggpubr)
library(dplyr)

# Indicar directorio
dir <- "~/MisArchivos/Usach/Inferencia"

# Una selecci�n de columnas (hecha por el profesor) de los resultados
# p�blicos de la encuesta Casen 2017 en la Regi�n Metropolitana.
# Las siguientes son las columnas que se eligieron:
#  - id.reg: n� secuencial del registro
#  - folio: identificador del hogar (comp: comuna �rea seg viv hogar)
#  - o: n�mero de orden de la persona dentro del hogar
#  - id.vivienda: identificador de la vivienda (comp: comuna �rea seg viv)
#  - hogar: identificaci�n del hogar en la vivienda
#  - region: regi�n
#  - provincia: provincia
#  - comuna: comuna
#  - ing.comuna: posici�n en el ranking hist�rico del ingreso de la
#                comuna (de menor a mayor ingreso)
#  - zona: �rea geogr�fica (Urbano, Rural)
#  - sexo: sexo de la persona registrada
#  - edad: edad de la persona registrada
#  - ecivil: estado civil de la persona registrada
#  - ch1: situaci�n ocupacional de la persona registrada
#  - ytot: ingreso total

basename <- "Casen 2017.csv"
file <- file.path(dir, basename)

# Esta funci�n lee un CSV en ingl�s: campos separados por comas y
# n�meros con "punto decimal".
# Existen otras funciones para leer otros formatos de texto. Ver help.
# Si se quiere leer una planilla MS Excel, se puede usar las funciones
# del paquete "xlsx".
poblaci�n <- read.csv(file = file, encoding = "UTF-8")

# Se devuelve un "marco de datos" o data.frame
print(class(poblaci�n))
print(str(poblaci�n))

# Podemos obtener el n�mero de filas (o de columnas) que corresponde al n�mero de
# "casos" en la muestra/poblaci�n (o de variables).
tama�o.poblaci�n <- nrow(poblaci�n)

# Primero se elige una muestra de forma aleatoria, pero fijando una
# semilla para el generador de secuencias pseudoaleatorias para poder
# repetir los resultados

semilla <- 113
tama�o.muestra <- 100

set.seed(semilla)
muestra <- poblaci�n[sample(1:tama�o.poblaci�n, tama�o.muestra), ]

q <- quantile(muestra$ytot, seq(.2, 1, .2))

quintil <- ifelse(muestra$ytot <= q[1], 1, 0)
quintil[muestra$ytot > q[1] & muestra$ytot <= q[2]] <- 2
quintil[muestra$ytot > q[2] & muestra$ytot <= q[3]] <- 3
quintil[muestra$ytot > q[3] & muestra$ytot <= q[4]] <- 4
quintil[muestra$ytot > q[4]] <- 5

datos <- muestra
datos$quintil <- quintil
datos$ingreso <- datos$ytot / 1000
p <- ggboxplot(
  datos,
  x = "quintil", y = "ingreso",
  add = "mean", add.params = list(color = "#FC4E07"),
  color = "quintil", fill = "quintil",
  title = "Muestra del ingreso en la Regi�n Metropolitana",
  ylab = "Ingreso total (miles de pesos)"
)

############################################################################
#DESARROLLO EJERCICIO PRACTICO 2

#Se define el valor de la semilla y el tama�o de la muestra a generar
semilla <- 123456
tama�o.muestra <- 100

#Se setea la semilla definida
set.seed(semilla)
#Se obtiene una muestra de tama�o 100 se la poblaci�n
muestra <- poblaci�n[sample(1:tama�o.poblaci�n, tama�o.muestra), ]

#f. �Van los ingresos de los chilenos increment�ndose con la experiencia y de 
#forma similar entre hombres y mujeres?

#Para responder la pregunta se decidi� generar un grafico de dispersi�n
#Mostrando las variables edad en el eje x e ingreso en el eje y. En dicho 
#grafico cada punto representa una persona, por lo tanto para indentificar 
#la diferencia de ingresos entre sexo, se marcaron de un color a los hombres
#y de otro color a las mujeres
scatter_muestra <- ggscatter(datos , 
                  x = 'edad', 
                  y = 'ingreso', 
                  title = "Ingresos de Hombres y Mujeres seg�n su Experiencia (Muestra)" , 
                  color = 'sexo',
                  palette = c("#00AFBB", "#E7B800"))

#Se muestra el grafico de la pregunta f realizado con la muestra de 100 datos
scatter_muestra

#Ahora se crea el mismo grafico pero utilizando los datos de la poblaci�n
poblaci�n$ingreso <- poblaci�n$ytot / 1000
scatter_poblacion <- ggscatter(poblaci�n, 
                             x = 'edad', 
                             y = 'ingreso', 
                             title = "Ingresos de Hombres y Mujeres seg�n su Experiencia (Poblaci�n)" , 
                             color = 'sexo',
                             palette = c("#00AFBB", "#E7B800"))

#Se muestra el grafico de la pregunta f realizado con la poblacion
scatter_poblacion

#a. �Se encuestaron m�s o menos la misma cantidad de gente en cada provincia de la RM?
# Se hace un grafico de la cantidad de gente encuestada por provincia.

#Aqui no se que hizo muy bien el kevin
prov <- group_by(muestra,provincia) %>%
  summarise(
    Encuestados = n()
  )
a <- ggbarplot(prov,x = "provincia",y = "Encuestados")

#Se muestra el grafico de la pregunta a
a

#Conclusiones
#En el gr�fico de dispersi�n generado para la muestra (pregunta f) se puede observar que 
#en el rango de los 25-50 a�os de edad existen algunos casos en los que 
#el ingreso aumenta, mayoritariamente para los hombres, sin embargo se trata
#de muy pocos valores para que la conclusion sea desiciva. En la generalidad
#tanto los ingresos de los hombres y las mujeres se mantienen relativamente
#contantes al aumentar la edad. Por otro lado, al compararlo con el grafico 
#de la poblaci�n...

#En cuanto a la pregunta a, ...
