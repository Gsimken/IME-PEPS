# Antes de escoger el tipo de prueba a realizar de debe tener en consideración
# los tipos de muestras con las que se está trabajando, en otras palabras, 
# saber si son correlacionadas o independientes.

# Muestras Independientes:
    # Dado que los valores de una muestra no afectan y tampoco revelan información 
    # sobre los valores de la otra, se puede decir que se trata de muestras
    # independientes. Otro indicador que revela que las muestras son independientes
    # es el hecho de que son realizadas en conjuntos diferentes de elementos.
#

# Muestras Correlacionadas:
    # Dado que los valores de una muestra afectan y además revelan información 
    # sobre los valores de la otra, se puede decir que se trata de muestras
    # Correlacionadas. 

#

# Por otra parte, también se deben analizar los datos entregados en el 
# enunciado para decidir si es posible utilizar algún procedimiento 
# parámetrico para el análisis o si existen datos problemáticos que se deben
# corregir. Para esto se tiene el siguiente código:

# Se utiliza la función gghistogram() para crear un histograma de los
# datos de cada grupo. Esto se usa como primera aproximación para
# observar si existe algún tipo de asimetría o si los datos se comportan
# de forma normal.
histograma <- gghistogram(data = datos,
                           x = "variable",
                           y = "..density..",
                           title = "Histograma de Datos")

# Se grafican los resultados
print(histograma)

# Al graficar el histograma se puede observar ...

# A primera vista algunos de los gráficos parecen seguir una
# distribución normal, pero para estar seguros utilizaremos un
# Shapiro-Test, cuyas hipotesis a contrastar son las siguientes:

# H0: La muestra proviene de una población cuya distribución es normal
# HA: La muestra proviene de una población cuya distribución no es normal

# Se define un alfa antes de realizar la prueba
α <- 0.05

# Se realiza el Shapiro-Test
shapiroTest <- shapiro.test(datos)
#También se puede realizar así
shapiro.test.p1 <- by(data = datos[["weight"]],
                       INDICES = datos[["feed"]],
                       FUN = shapiro.test
                      )

# Conclusión del Shapiro-Test p-valor > alpha::
    # Dado que el p-valor es mayor al alfa en cada uno de los grupos,
    # NO se rechaza la hipotesis nula del test Shapiro y por ende, se
    # comprueba la normalidad de los datos y se verifica la condición 3.
#
# Conclusión del Shapiro-Test p-valor < alpha:
    # Dado que el p-valor es menor al alfa en cada uno de los grupos,
    # Se rechaza la hipotesis nula del test Shapiro y por ende, no se
    # comprueba la normalidad de los datos.
#

# Por otro lado, se utiliza la función ggboxplot() para lograr identificar 
# si existen outliers o datos atípicos que estén afectando de sobremanera 
# el comportamiento del grupo.
boxplot <- ggboxplot(data = datos,
                      x = "variable x",
                      y = "variable y",
                      title = "Gráfico de Caja de Datos")

# Se grafican los resultados
print(bloxplot)

# Al graficar el diagrama de cajas se puede observar ...

# (En caso de que se pueda usar anova copiar lo siguiente)
# Tras haber analizado el comportamiento de los datos, y dado que
# no existen datos atípicos dentro de las muestras que se están utilizando
# y además observando que cada uno de los grupos sigue una distribución 
# relativamente normal es posible aplicar una prueba paramétrica.

# Basandonos en el análisis anterior, la prueba que se propone para
# responder a la pregunta de investigación del estudio es el Test de
# Análisis de la Varianza o Test de ANOVA de una vía o factor. Este es el 
# test adecuado para utilizar en este caso, ya que se tiene una única variable 
# o factor independiente y el objetivo es investigar si las variaciones
# o diferentes niveles de ese factor tienen un efecto medible sobre 
# otra variable dependiente. 
# La prueba ANOVA parece ser la indicada para el caso de estudio, dado que se
# tienen muestras de más de dos grupos, y cada uno tiene, aparentemente,
# observaciones independientes entre sí. 
# Riesgos de la prueba 
# En este caso, ...

# Una vez definida la prueba a utilizar se definen las hipótesis 
# a contrastar:

# ==============================================================================
# ========================= Hipótesis a Contrastar =============================

# Hipotesis Nula (H0):
# ===================
# No existen diferencias estadísticamente significativas en las medias
# de los grupos de suplementos para aves. En otras palabras, los suplementos
# aportan de igual forma en el peso de las aves.

# Hipotesis Alternativa (HA):
# ==========================
# Existen diferencias estadísticamente significativas entre las medias 
# de los grupos de suplementos para aves. En otras palabras, los suplementos
# aportan de forma diferente en el peso de las aves.

# La prueba ANOVA parece ser la indicada para el caso de estudio, dado que se
# tienen muestras de más de dos grupos, y cada uno tiene, aparentemente,
# observaciones independientes entre sí. Sin embargo, antes de aplicarla 
# se deben verificar que se cumplen las siguientes condiciones:

# 1. La variable dependiente es cuatitativa y la independiente es categórica
# 2. Las muestras son independientes al *interior* de los grupos
# 3. Se puede asumir que las poblaciones son aproximadamente normales
# 4. Las muestras tienen varianzas similares
# 5. La matriz de varianzas-covarianzas es esferica

# A continuación se procede a verificar las codiciones para la prueba

# 1. 
# Al obervar los datos vemos que efectivamente la variable dependiente, 
# que en este caso es el peso (weight) es una variable cuantitativa. Por otro
# lado la variables independiente, el suplemento (feed), es una variable
# categórica. Por lo tanto se cumple la primera condición.

# 2. 
# La condición dos también se verifica dado que ninguna instancia depende
# de otra, cada observación es un ave independiente alimentada con un 
# suplemento específico.

# 3. 
# Para comprobar la condición de normalidad de cada grupo se realiza un
# qqplot para visualizar el comportamiento de los datos.

# Se crea el gráfico
qqplot.p1 <- ggqqplot(datos,
                      x = "weight",
                      color = "feed"
                      )
# Se separan los gráficos por tipo de suplemento
qqplot.p1 <- qqplot.p1 + facet_wrap(~feed)

# Se muestra el gráfico
print(qqplot.p1)

# Otra forma de ver la normalidad de los datos es utilizando un
# histograma

# Se crea el gráfico
histogram.p1 <- gghistogram(datos,
                            x = "weight",
                            color = "feed")

# Se separan los gráficos por tipo de suplemento
histogram.p1 <- histogram.p1 + facet_wrap(~feed)

# Se muestra el gráfico
print(histogram.p1)

# A primera vista algunos de los gráficos parecen seguir una
# distribución normal, pero para estar seguros utilizaremos un
# Shapiro-Test, cuyas hipotesis a contrastar son las siguientes:

# H0: La muestra proviene de una población cuya distribución es normal
# HA: La muestra proviene de una población cuya distribución no es normal

# Se define un alfa antes de realizar la prueba
α <- 0.05

# Se realiza el Shapiro-Test
shapirto.test.p1 <- by(data = datos[["weight"]],
                       INDICES = datos[["feed"]],
                       FUN = shapiro.test
                      )

# Se muestran por consola los resultados del test
print(shapirto.test.p1)

# Conclusión del Shapiro-Test:
# Dado que el p-valor es mayor al alfa en cada uno de los grupos,
# NO se rechaza la hipotesis nula del test Shapiro y por ende, se
# comprueba la normalidad de los datos y se verifica la condición 3.

# Anova de una via se considera una prueba robusta contra la suposición
# de normalidad. Esto significa que tolera las violaciones a su 
# suposición de normalidad bastante bien. En cuanto a la normalidad 
# de los datos de grupo, el Test puede tolerar datos que no son 
# normales (distribuciones asimétricas) con un pequeño efecto en 
# la tasa de error de tipo I.

# 4. 
# Para la condición cuatro se debe mostrar que las muestras poseen 
# varianzas similares, para esto se utiliza un Levene-Test. Las hipotesis
# a contrastar para dicho test son las siguientes:

# H0: No existen diferencias significativas entre las varianzas
# HA: Existen diferencias significativas entre las varianzas

# Se importa la librería que contiene la función para realizar el test
library(car)

# Se define un alfa antes de realiza la prueba
α <- 0.05

# Se realiza el test
levene.test.p1 <- leveneTest(weight ~ feed, datos)

# Se muestra el resultado del test
print(levene.test.p1)

# Conclusión Levene-Test p-valor > alpha:
    # Dado que p-valor es mayor a alpha, no se rechaza la hipotesis nula, por lo 
    # tanto, se puede decir que no hay diferencias significativas entre las
    # varianzas y se verifica la condición 4.
    
    #Se puede usar anova
#
# Conclusión Levene-Test p-valor < alpha:
    # Dado que p-valor es menor a alpha, se rechaza la hipotesis nula, por lo 
    # tanto, no se puede decir que no hay diferencias significativas entre las
    # varianzas, en otras palabras, las varianzas de los grupos tienen diferencias
    # estadísticamente significativas y por lo tanto no se verifica la condición 4.

    # En este contexto, hay dos pruebas que puede ejecutar que son aplicables 
    # cuando se ha violado la suposición de homogeneidad de las varianzas: 
    # (1) Welch o (2) Brown y Forsythe test. Alternativamente, podría ejecutar
    # una prueba Kruskal-Wallis H.
    #https://vivaelsoftwarelibre.com/test-de-welch-en-r/
#
# Se utiliza un Test Welch
welchTest <- oneway.test(datos)

#


# Una vez que se han comprobado todas las condiciones se procede a 
# realizar el test de ANOVA.

# Primero se deben convertir los datos a tipo long. Para ello se importa
# la librería correspondiente.
library(tidyr)

# Ya que se espera trabajar con el analisis de varianza, es mejor tener
# los datos en el formato long.
datos.long <- gather(data = datos,
                     key = "feed",
                     value = "weight"
)

# Se importa la librería que contiene la funcion para realizar el test ANOVA
require(ez)

# Se define un alfa antes de realiza la prueba
α <- 0.05

# Se utiliza la función aov()
anova.p1 <- aov(datos.long$weight ~ datos$feed)

# Se muestran los resultados del test
summary(anova.p1)

# Se grafica el resutado
plot(anova.p1)

# Conclusión Test de ANOVA:
# Dado que el p-valor es menor al alfa (0.05) se rechaza la hipotesis nula, 
# lo cual indica que si existen diferencias estadísticamente significativas
# entre las medias de los grupos de suplementos. Sin embargo, el test anova 
# no entrega información sobre cuales son los grupos entre los cuales existen 
# dichas diferencias, es por esto, que se debe realizar un análisis post-hoc
# para averiguar cuales son dichos grupos.