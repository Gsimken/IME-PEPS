# FORMA 10

# ==============================================================================
# ================================ Pregunta 1 ==================================

# A continuación se cargan los datos a utilizar para la pregunta 1

texto <- ("
baja media alta placebo
0.5 -0.4 -0.7 -1.0
-0.6 -0.5 -3.1 1.5
-1.4 -0.7 -3.5 0.2
-0.2 -0.6 0.9 1.8
-2.3 -0.8 -0.1 -1.1
-1.8 -1.2 -0.8 0.8
2.0 -1.6 -2.0 -0.5
0.7 -0.4 -0.4 0.0
0.8 -2.3 -2.2 0.4
1.6 -1.1 -2.3 1.7
-0.6 0.0 -0.4 -2.0
0.5 -0.5 0.7 -0.8
-2.3 -2.7 -2.6 -0.7
0.5 -1.4 -2.4 1.4
-0.3 0.7 -1.5 0.6
-1.5 0.1 -1.3 -4.1
-2.6 -1.1 -1.1 0.9
0.2 0.8 -2.7 -1.0
-0.5 -2.0 -2.2 -2.2
-2.6 -0.5 -0.9 1.3
-2.6 -0.5 -0.7 -0.3
-1.0 1.2 -3.2 0.1
-3.5 -0.7 -2.4 0.1
-2.3 0.4 -0.2 2.5
1.3 -1.1 -2.7 -0.1
-1.8 -0.3 0.2 -1.8
-0.1 -1.0 -3.2 -1.1
0.2 -2.3 -0.9 0.9
-3.4 -0.5 -1.8 -2.4
0.7 -1.0 -1.5 -2.0
-0.1 -2.6 -1.1 -0.7
-2.5 -2.8 -2.4 -0.4
-1.3 1.3 -2.9 1.8
-0.6 -0.6 -4.5 2.6
-1.1 -3.0 -0.9 0.7
-1.5 -1.5 0.0 -1.0
-1.7 -0.8 -1.1 -0.2
-2.0 -0.1 -2.3 -2.7
-2.2 -3.0 -2.5 2.1
0.6 -2.6 0.5 -0.4
-2.7 -0.9 -2.3 -0.5
0.7 -1.7 -0.4 -1.1
0.8 0.5 -2.1 2.1
0.3 -2.3 -1.3 1.2
")
datos.p1 <- read.table(file = textConnection(texto),
                    header = TRUE
                    )

names(datos.p1) <- c("baja", "media", "alta", "placebo")

# Primero se deben convertir los datos a tipo long. Para ello se importa
# la librería correspondiente.
library(tidyr)

# Llevamos los datos a formato largo
datos.p1 <- gather(data = datos.p1,
                key = "Infusion",
                value = "Peso"                
               )
datos.p1[["Infusion"]] <- factor(datos.p1[["Infusion"]])


# ==============================================================================
# =========================== Evaluación de Datos ==============================

# Antes de comenzar a definir la prueba a utilizar o definir las posibles 
# hipótesis para contrastar se deben analizar los tipos de muestras entregadas, 
# es decir, verificar si se trata de muestras independientes o correlacionadas.
# Dado que en el enunciado se habla de una muestra de participantes se separó
# aleatoriamente en 4 grupos, nos da un indicio de que los grupos podrian ser
# independientes. Además, basandonos en el contexto de la pregunta, cada grupo
# tomó una infusión de té verde diferente, por lo que los valores de un grupo 
# no afectan y tampoco revelan información sobre los valores de los otros.
# Esto indica que se trata de muestras independientes. 

# Por otra parte, también se deben analizar los datos entregados en el 
# enunciado para decidir si es posible utilizar algún procedimiento 
# parámetrico para el análisis o si existen datos problemáticos que se deben
# corregir. Para esto se tiene el siguiente código:

# Se importa la librería que contiene las funciones para graficar
library(ggpubr)

# Se utiliza la función ggboxplot() para lograr identificar 
# si existen outliers o datos atípicos que estén afectando de sobremanera 
# el comportamiento del grupo.
graficoCaja.p1 <- ggboxplot(datos.p1,
                            x = "Infusion", 
                            y = "Peso",
                            xlab = "Infusion", 
                            ylab = "Variacion de Peso",
                            add = "jitter",
                            add.params = list(color = "Infusion", fill = "Infusion")
)
print(graficoCaja.p1)

# Al observar el grafico de cajas se puede ver que a primera vista existen algunos
# valores candidatos a ser outliers, en el grupo "Alta" y en el grupo "Placebo",
# y que posiblemente podrían estar afectando la normalidad de los datos.

# Por otro lado, se utiliza la función gghistogram() para crear un histograma de los
# datos de cada grupo. Esto se usa como primera aproximación para
# observar si existe algún tipo de asimetría o si los datos se comportan
# de forma normal.
histograma.p1 <- gghistogram(datos.p1,
                  x = "Peso",
                  xlab = "Infusion",
                  color = "Infusion", fill = "Infusion",
                  bins = 10
                 )
histograma.p1 <- histograma.p1 + facet_grid(~ Infusion)

# Se grafican los resultados
print(histograma.p1)

# Al graficar el histograma se puede observar que los grupos de datos parecen
# seguir distribuciones normales, a excepción del grupo placebo, el cual 
# pareciera tener un grado de asimetría negativa, es decir, los datos se 
# concentran a la derecha. Sin embargo, para estar seguros utilizaremos un
# Shapiro-Test, cuyas hipotesis a contrastar son las siguientes:

# H0: La muestra proviene de una población cuya distribución es normal
# HA: La muestra proviene de una población cuya distribución no es normal

# Se realiza el Shapiro-Test
shapiroTest.p1 <- by(data = datos.p1[["Peso"]],
                       INDICES = datos.p1[["Infusion"]],
                       FUN = shapiro.test
                      )

# Se muestran los resultados del Shapiro-Test
print(shapiroTest.p1)

# Conclusión del Shapiro-Test p-valor > alpha::
# Dado que el p-valor es mayor al alfa en cada uno de los grupos,
# (Placebo: 0.68, Baja: 0.17, Media: 0.22 y Alta: 0.69)
# NO se rechaza la hipotesis nula del test Shapiro y por ende, se
# comprueba la normalidad de los datos.

# Por último, dado que los valores de una muestra no afectan y tampoco revelan información 
# sobre los valores de la otra, se puede decir que se trata de muestras
# independientes. Otro indicador que revela que las muestras son independientes
# es el hecho de que son realizadas en conjuntos diferentes de elementos.
# Además, existe un par de datos que podrían ser considerados como atípicos, pero que no 
# afectan a la normalidad de todo el grupo, y dado que se realizo un
# Shapiro Test para comprobarlo, estamos seguros de que los grupos siguen 
# una distibución normal. En base a lo anterior, se decide utilizar una
# prueba paramétrica para efrentar la pregunta de investigación.


# ==============================================================================
# =========================== Prueba Estadística ===============================

# Basandonos en el análisis anterior, la prueba que se propone para
# responder a la pregunta de investigación del estudio es el Test de
# Análisis de la Varianza o Test de ANOVA de una vía o factor. Este es el 
# test adecuado para utilizar en este caso, ya que se tiene una única variable 
# categórica independiente (Dosis de Infusión de Té verde) y el objetivo es investigar si
# entre los diferentes grupos existen variaciones de peso silimares o no.
# Otro indicador de que la prueba ANOVA es la indicada para el caso de estudio,
# es que se tiene una muestra de más de dos grupos, y cada uno tiene, aparentemente,
# observaciones independientes entre sí. 


# ==============================================================================
# ========================= Hipótesis a Contrastar =============================

# Una vez definida la prueba a utilizar se definen las hipótesis 
# a contrastar:

# Hipotesis Nula (H0):
# ===================
# No existen diferencias estadísticamente significativas en las medias
# de variaciones de peso entre las dosis de Infusiones de Té verde. En otras 
# palabras, las dosis probadas de infusiones de té verde muestran variaciones
# de peso similares.

# Hipotesis Alternativa (HA):
# ==========================
# Existen diferencias estadísticamente significativas en las medias
# de variaciones de peso entre las dosis de Infusiones de Té verde. En otras 
# palabras, las dosis probadas de infusiones de té verde muestran variaciones
# de peso distintas.

# H0: μ1 = μ2 = μ3 = μ4
# HA: ∃μi ≠ μj  i,j = 1,2,3,4


# ==============================================================================
# ============================== Condiciones ===================================

# Antes de aplicar la Prueba de Análisis de la Varianza (ANOVA) para muestras 
# independientes se deben verificar que se cumplen las siguientes condiciones:

# 1. La variable dependiente es cuantitativa y la independiente es categórica
# 2. Las muestras son independientes al *interior* de los grupos
# 3. Se puede asumir que las poblaciones son aproximadamente normales
# 4. Las muestras tienen varianzas similares

# A continuación se procede a verificar las codiciones para la prueba

# 1. 
# Al obervar los datos vemos que efectivamente la variable dependiente, 
# que en este caso es el Peso es una variable cuantitativa. Por otro
# lado la variable independiente, las dosis de infusión de té verde, es una 
# variable categórica. Por lo tanto se cumple la primera condición.

# 2. 
# La condición dos también se verifica dado que ninguna instancia depende
# de otra, cada observación es una persona independiente que tomó una infusión
# de té verde distinta, además las personas antes de tomar la dosis, se separaron
# aleatoriamente. Por lo tanto se cumple la segunda condición.

# 3.
# Esta condición fue demostrada al momento de analizar los datos, pero
# para evitar confusiones se vuelven a mostrar los resultados obtenidos:

# Se muestra el grafico de caja de los datos
print(graficoCaja.p1)

# Se muestra el historgama de los datos
print(histograma.p1)

# Se muestra el Shapiro Test
print(shapiroTest.p1)

# Todas las pruebas indican que los grupos de datos son normales, por lo que 
# la condición 3 también se cumple.

# 4. 
# Para la condición cuatro se debe mostrar que las muestras poseen 
# varianzas similares, para esto se utiliza un Levene-Test. Las hipotesis
# a contrastar para dicho test son las siguientes:

# H0: No existen diferencias significativas entre las varianzas,
# en otras palabras, todas las varianzas son iguales.

# HA: Existen diferencias significativas entre las varianzas

# Se importa la librería que contiene la función para realizar el test
library(car)

# Se realiza el test
leveneTest.p1 <- leveneTest(Peso ~ Infusion, datos.p1)

# Se muestra el resultado del test
print(leveneTest.p1)

# Conclusión Levene-Test:
# Dado que p-valor es mayor a alpha, no se rechaza la hipotesis nula, por lo 
# tanto, se puede decir que no hay diferencias significativas entre las
# varianzas y se verifica la condición 4.

# Una vez que se han verificado todas las condiciones se procede a utilizar
# la prueba ANOVA.


# ==============================================================================
# ========================== Procedimiento Omnibus =============================

# Se importa la librería que contiene la funcion para realizar el test ANOVA
require(ez)

# Se utiliza la función aov()
anova.p1 <- aov(datos.p1$Peso ~ datos.p1$Infusion)

# Se muestran los resultados del test
summary(anova.p1)

# Se grafica el resutado
plot(anova.p1)

# Conclusión Test de ANOVA:
# Dado que el p-valor es menor al alfa (0.05) se rechaza la hipótesis nula, 
# lo cual indica que si existen diferencias estadísticamente significativas
# entre las medias de los grupos de dosis de Infusiones. En otras palabras
# las dosis probadas muestran variaciones de peso distintas. Sin embargo, el test anova 
# no entrega información sobre cuales son los grupos entre los cuales existen 
# dichas diferencias, es por esto, que se debe realizar un análisis post-hoc
# para averiguar cuales son dichos grupos.


# ==============================================================================
# ========================= Procedimiento Post-Hoc =============================

# Para encontrar cuales son los grupos que presentan diferencias se utilizará una
# corrección de Tukey, entregada por la función 
# TukeyHSD()

# Se realiza la correción
correccion.tukey <- TukeyHSD(anova.p1)

# Se muestran los resultados del test
print(correccion.tukey)

# Se grafican los resultados del test
plot(correccion.tukey)

# Conclusión Correción de Tukey:
# Al observar los p-valores obtenidos en la correción de Tukey se puede ver
# que los grupos en los que existen diferencias en las variaciones de peso
# registradas tras tomar la dosis son:

# Infusión Media - Infusión Alta (p-valor = 0.15)
# Infusión Media - Infusión Baja (p-valor = 0.95)


# ==============================================================================
# ============================== Conclusiones ==================================

# Finalmente, habiendo realizado el test ANOVA, se obtuvo que si existian diferencias
# en las variaciones de peso entre los grupos que tomaron diferentes dosis de té verde.
# En otras palabras, existen grupos en los que muestran variaciones de peso distintas,
# específicamente entre los grupos Media-Alta, una mayor cantidad de GECC presenta 
# mayores variaciones de peso que una cantidad media. Además, una cantidad media 
# presenta mayores variaciones de peso que una baja cantidad. Finalmente, los
# grupos (diferentes dosis de té) presentan variaciones de peso distintas.



# ==============================================================================
# ================================ Pregunta 2 ==================================

# A continuación se cargan los datos a utilizar para la pregunta 2

texto <- ("
Sem1 Sem4 Sem8 Sem12
 7 7 7 7
 8 7 7 7
 4 5 5 5
 6 6 6 6
 6 6 6 6
 5 5 4 4
 2 3 3 3
 5 5 5 5
 6 6 6 5
 4 4 5 5
 7 6 5 5
 4 4 4 3
 4 3 4 3
 5 5 7 6
 6 5 5 5
 6 6 6 6
 5 5 5 5
 1 1 1 1
 2 2 2 2
 7 7 6 5
 4 4 4 4
 4 4 5 3
 4 5 4 4
 6 6 5 5
 5 5 6 5
 6 6 6 6
 6 6 6 7
 3 2 2 2
 5 5 5 5
 4 4 5 5
 7 7 7 7
 7 7 7 7
 7 6 6 6
 6 5 6 6
 4 4 4 4
 5 4 5 4
 5 6 6 7
 7 7 6 6
 9 10 9 9
 3 4 5 5
 7 7 7 7
 6 7 7 6
 6 6 6 6
 3 3 3 3
 5 6 5 5
 6 7 7 7
 7 8 7 7
 7 8 8 7
 3 3 3 3
")
dw <- read.table(
  file = textConnection(texto),
  header = TRUE)

dl <- gather(
  data = dw,
  key = "Semanas",
  value = "Puntajes",
  Sem1,Sem4,Sem8,Sem12
)
Personas <- factor(rep(1:nrow(dw), ncol(dw)))
datos.long <- cbind(Personas, dl)
datos.long[["Semanas"]] <- factor(datos.long[["Semanas"]])

datos.p2 <- datos.long
# ==============================================================================
# =========================== Evaluación de Datos ==============================
#-------------------------------------------------------------------

# Antes de escoger el tipo de prueba a realizar de debe tener en consideración
# los tipos de muestras con las que se está trabajando, en otras palabras, 
# saber si son correlacionadas o independientes. Dado que
# los valores de una muestra afectan y además revelan información 
# sobre los valores de la otra, se puede decir que se trata de muestras
# Correlacionadas. 

# Por otra parte, también se deben analizar los datos entregados en el 
# enunciado para decidir si es posible utilizar algún procedimiento 
# parámetrico para el análisis o si existen datos problemáticos que se deben
# corregir. Para esto se tiene el siguiente código:

# Se utiliza la función gghistogram() para crear un histograma de los
# datos de cada grupo. Esto se usa como primera aproximación para
# observar si existe algún tipo de asimetría o si los datos se comportan
# de forma normal.

# Aqui se utiliza la libreria ggpubr que fue importada en la pregunta anterior
# Se crea el histograma de datos
histograma.p2 <- gghistogram(datos.p2,
                  x = "Puntajes",
                  xlab = "Semana",
                  color = "Semanas", fill = "Semanas",
                  bins = 5
                 )
histograma.p2 <- histograma.p2 + facet_grid(~ Semanas)

# Se muestra el histograma
print(histograma.p2)
# Al graficar el histograma se puede observar una leve asimetria positiva, 
# que nos hace sospechar sobre la naturaleza 'normal' de los datos.

# Por otro lado, se utiliza la función ggboxplot() para lograr identificar 
# si existen outliers o datos atípicos que estén afectando de sobremanera 
# el comportamiento del grupo.
graficoCajas.p2 <-  ggboxplot(
                    datos.p2,
                    x = "Semanas", y = "Puntajes",
                    xlab = "Semanas", ylab = "Puntaje otorgado",
                    add = "jitter",
                    add.params = list(color = "Semanas", fill = "Semanas")
                    )


# Se grafican los resultados
print(graficoCajas.p2)

#Parecen haber ciertos outliers en la semana 4 y 8, pero no parecen ser muchos

# como se mencionó anteriormente a primera vista el histograma
# parece seguir una distribución normal y no parece haber muchos datos atipicos, 
# pero para estar seguros utilizaremos un Shapiro-Test, cuyas hipotesis 
# a contrastar son las siguientes:

# H0: La muestra proviene de una población cuya distribución es normal
# HA: La muestra proviene de una población cuya distribución no es normal

# Se realiza el Shapiro-Test
shapiro.test.p2 <- by(data = datos.p2[["Puntajes"]],
                       INDICES = datos.p2[["Semanas"]],
                       FUN = shapiro.test
                      )

# Se muestran por consola los resultados del test
print(shapiro.test.p2)

# Tras realizar el shapiro test se puede concluir que en los grupos
# "Sem8" y "Sem12" no existe normalidad en los datos. Además, en el grupo 
# "Sem1" se cumple la normalidad pero el p-valor (0.06) está muy cercano 
# al alfa (0.05). 
# Además, la variable no tiene escala intervalar.

# ==============================================================================
# =========================== Prueba Estadística ===============================


# Basandonos en el análisis anterior, la prueba que se propone para
# responder a la pregunta de investigación del estudio es un Test de
# Friedman.
# Este es el test adecuado para utilizar en este caso, ya que se tienen
# datos problemáticos (que no siguen una distribución normal) y 
# se trata de muestras correlacionadas.

# Una vez definida la prueba a utilizar se definen las hipótesis 
# a contrastar:

# Hipotesis Nula (H0):
# ===================
# H0: las muestras tienen la misma distribución de probabilidad o distribuciones 
# con la misma mediana, en otras palabras, el ranking promedio de las diferentes 
# mediciones son las mismas.

# Hipotesis Alternativa (HA):
# ==========================
# HA: por lo menos la distribución de una de las respuestas difiere de las demás,
# es decir, dos o más medidas tienen ranking promedio distintos.

# ==============================================================================
# ============================== Condiciones ===================================

# 1. El grupo es una muestra aleatoria de la población.
# 2. La variable dependiente debe ser continua u ordinal

# A continuación se procede a verificar las codiciones para la prueba:

# La primera condicion es difícil de corroborar, por lo que se 
# confiará en que el estudio fue hecho con responsabilidad y de forma
# honesta, y se realizó una muestra aleatoria de la población.

# La condición 2 se cumple evidentemente, puesto 5 es mayor
# que 6 y menor a 3. Podemos establer una relación ordinal.

# ==============================================================================
# ========================== Procedimiento Omnibus =============================

estudio <- friedman.test(Puntajes ~ Semanas | Personas, data = datos.p2)
print(estudio)


# ==============================================================================
# ============================== Conclusiones ==================================

# Dado que p-value > alpha α no se rechaza la hipotesis nula, por lo que
# todas las personas poseen una situacion de cansancio similar a
# lo largo del tiempo, dado que la prueba no posee diferencias significativas
# no es necesario realizar posthoc para este caso


# ==============================================================================
# ================================= POST HOC ===================================
# en caso de realizar post-hoc hacer esto:

# Calculemos los rankings, que esta vez se calculan por sujeto...
dw.rank <- t(apply(-dw[, -1], 1, rank))
dw.rank <- data.frame(Personas = dw[, 1], dw.rank)

# Llevamos los datos a formato largo
dl.rank <- gather(
  data = dw.rank,
  key = "Semanas",
  value = "Puntajes",
  -"Personas"
)
dl.rank[["Personas"]] <- factor(dl.rank[["Personas"]])
dl.rank[["Semanas"]] <- factor(dl.rank[["Semanas"]])

# Revisemos los datos con un diagrama de cajas
p2 <- ggboxplot(
  dl.rank,
  x = "Semanas", y = "Puntajes",
  xlab = "Semanas",
  color = "Semanas",
  add = "jitter"
)
print(p2)
# Se aprecia una simetria bastante terrible, por lo que pasaremos a 
# realizar un post-hoc no parametrico
postHoc <- pairwise.wilcox.test(datos.long[["Puntajes"]], datos.long[["Semanas"]],
                            paired = TRUE,
                            p.adjust.method = "BH")


print(postHoc)

# ==============================================================================
# ============================== Conclusiones ==================================

#Tenemos que concluir que existe diversas diferencias significativas entre las semanas
#la semana 1 es significativa con todas las semanas, concluyendo así que la semana 1
#es la que tiene una peor sensación de pérdida de peso y fatiga (siendo similar a un dia lunes laboral),
#al igual que la semana 12, siendo la mejor semana con la mayor cantidad de sensación
#de energía y pérdida de peso. Solo siendo similares la semana 4 con la semana 8.
#Algo que debemos notas es que la diferencia de la semana 1 con la semana 8 
#esta en una condición de borde si la significancia baja a 0.01




# ==============================================================================
# ============================= Ejemplo Novedoso ===============================


