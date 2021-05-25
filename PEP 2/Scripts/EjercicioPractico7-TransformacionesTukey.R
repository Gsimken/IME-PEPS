#==========================================================#
#======================= GRUPO 5 ==========================#
#==========================================================#
# Integrantes
# Sebastian Orellana 20.197.746-0
# Nicolas Salgado 19.848.869-0
# Cristobal Medrano 19.083.864-1
# Gary Simken 19.986.690-7

library(ggplot2)
library(ggpubr)

# Se instala y carga la biblioteca que nos permite usar el Tukey's Ladder of 
# Powers de ser necesario
if(!require(rcompanion)){install.packages("rcompanion")}
library(rcompanion)

# Se cargan los datos del enunciado
datos <- c(7.05, 1.16, 2.3, 0.52, 2.16, 5.47, 6.31, 0.07, 10.2, 5.84, 7.57, 
           4.64, 6.96, 12.51, 1.82, 3.97, 3.22, 2.53, 5.89, 1.52, 1.27, 0.03,
           2.68, 5.72, 2.54, 3.88, 8.16, 2.16, 1.45, 2.66, 1.32, 5.29, 0.02, 
           2.9, 4.83)

# Se grafican los datos en un histograma, para poder ver su comportamiento
datos_hist <- gghistogram(datos, fill = "cyan",
                          title = "Histograma de datos sin corrección (Asimetría positiva)",
                          bins = 10) +
  geom_density(aes(y=1.5*..count..), colour="blue", adjust=1.4, size=1)
print(datos_hist)
# En el histograma se observa una asimetria a la derecha

# Se verifica la normalidad utilizando el test de Shapiro Wilk
datos_shap <- shapiro.test(datos)
datos_shap

# De acá se concluye que como el p-valor es muy pequeño, esti no nos asegura 
# normalidad

# En conclusión, observando el gráfico y los resultados del shapiro test,
# los datos no tienen un comportamiento normal.

# Es debido a lo anterior, que se requiere hacer un ajuste en los datos
# para poder aplicar el t-student.

# Por otra parte, al momento de escoger la mejor transformación para los datos 
# se debe revisar la evidencia provista al inicio, lo cual indica que los datos
# tienen una fuerte asiemtría hacia la derecha. Es por esto que se decide
# utilizar una prueba de Tukey's Ladder of Powers con un lambda = 0.5.

datos_corregidos <- sqrt(datos)

# Graficando la corrección
datos_corregidos_hist <- gghistogram(datos_corregidos, fill = "red", bins = 10,
                                     title = "Histograma con datos corregidos (lambda = 0.5)") +
  geom_density(aes(y=0.4*..count..), colour="blue", adjust=1.4, size=1)
print(datos_corregidos_hist)

# Usando el test de Shapiro Wilk a los datos corregidos se obtiene
datos_corregidos_shap <- shapiro.test(datos_corregidos)
datos_corregidos_shap

# Al graficar los datos corregidos se puede observar que la transformación
# escogida funciona correctamente para normalizar los datos iniciales. Esto 
# se puede confirmar realizando una prueba de Shapiro Wilk, en donde el 
# p-valor es 0.7444

# Otra aproximación sobre la transformación de datos, es utilizar directamente
# el Tukey's Ladder or Powers que nos provee la biblioteca de rcompanion.

datos_tukey <- transformTukey(datos, plotit = FALSE)

# Esta función itera sobre los datos realizando modificaciones en el parámetro
# lambda, hasta que maximiza el valor W que se obtiene con el shapiro test.
# Segun la aproximación a lambda entregada por la función, esta tiene un valor
# de 0.575

# lambda = 0.575

# Graficando los datos obtenido con la función transformTukey
datos_tukey_hist <-  gghistogram(datos_tukey, fill = "darkgray", bins = 10,
                                 title = "Histograma con datos corregidos (lambda = 0.575)")+
  geom_density(aes(y=0.5*..count..), colour="blue", adjust=1.4, size=1)
print(datos_tukey_hist)

# Concluyendo respecto a los datos obtenidos, se pudo observar que nuestra
# primera aproximación fue bastante buena:
# 
# Primera observación: Lambda = 0.5
# Segunda observación: Lambda = 0.575 (Obtenida con la función transformTukey)
