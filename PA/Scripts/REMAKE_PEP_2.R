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

# Se obtienen los datos en formato ancho
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


# Dado que los valores de una muestra no afectan y tampoco revelan información 
# sobre los valores de la otra, se puede decir que se trata de muestras
# independientes. Otro indicador que revela que las muestras son independientes
# es el hecho de que son realizadas en conjuntos diferentes de elementos.

# Por otra parte, también se deben analizar los datos entregados en el 
# enunciado para decidir si es posible utilizar algún procedimiento 
# parámetrico para el análisis o si existen datos problemáticos que se deben
# corregir. Para esto se tiene el siguiente código:

# Se utiliza la función gghistogram() para crear un histograma de los
# datos de cada grupo. Esto se usa como primera aproximación para
# observar si existe algún tipo de asimetría o si los datos se comportan
# de forma normal.
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
