# FORMA 13
library(tidyr)
library(car)
library(caret)
library(vcd)
library(pROC)
library(ggpubr)
# ==============================================================================
# ================================ Pregunta 1 ==================================

RNGkind(sample.kind = "Rounding")
# A continuación se cargan los datos a utilizar para la pregunta 1
texto <-("
    Genero,Edad,Estatura,Peso,Historia,ComRapida,Vegetales,NumComidas,Bocadillos,Fuma,Agua,Calorias,Ejercicio,Aparatos,Alcohol,Transporte,Categoria
    0,21,1.52,56,1,0,2,3,3,1,2,1,3,0,1,2,1
    1,29,1.77,83,0,1,0,4,1,0,2,0,0,1,0,3,2
    1,22,1.65,62,0,1,1,4,1,0,1,0,2,0,1,2,1
    0,21,1.67,75,1,1,1,3,3,0,1,0,1,0,1,2,2
    1,22,1.68,55,1,1,1,3,3,0,1,0,0,2,1,4,1
    1,55,1.78,84,1,0,2,4,1,0,2,1,3,0,2,0,2
    1,22,1.7,66,1,0,1,3,1,0,1,0,0,0,0,2,1
    1,22,1.75,95,1,0,1,3,3,0,2,0,3,2,0,0,4
    0,19,1.61,62,1,1,2,1,1,0,1,0,1,0,2,2,1
    1,23,1.62,53,1,1,1,3,3,0,1,0,1,1,1,2,1
    0,23,1.67,75,1,1,1,3,1,1,1,0,0,2,0,0,2
    1,23,1.87,95,1,1,0,3,1,0,1,0,0,2,2,2,3
    1,24,1.66,67,1,1,2,1,3,0,1,0,1,0,0,2,1
    1,30,1.77,109,1,1,2,3,3,0,0,0,2,0,1,4,4
    1,23,1.89,65,1,1,2,3,1,0,2,0,1,1,1,2,0
    1,21,1.62,70,0,1,1,1,2,0,2,0,1,0,1,2,2
    0,27,1.6,61,0,1,2,3,0,0,1,0,0,0,1,4,1
    1,25,1.78,78,1,1,1,1,3,0,1,0,2,1,1,2,1
    0,40,1.55,62,1,0,2,3,3,0,2,0,0,0,1,4,2
    1,55,1.65,80,0,1,1,3,3,0,1,0,1,0,0,4,3
    1,25,1.89,75,0,0,2,3,1,0,1,1,3,0,0,2,1
    1,29,1.69,90,1,0,1,3,3,0,2,0,1,0,1,4,4
    1,27,1.83,71,1,1,1,3,3,0,1,0,3,2,0,4,1
    1,21,1.8,62,1,1,2,3,3,0,1,0,1,0,0,2,1
    0,21,1.72,66,1,1,2,4,0,0,2,0,0,2,0,2,1
    0,23,1.63,82,1,1,1,1,3,0,1,0,0,0,0,2,4
    1,25,1.83,121,1,0,2,3,3,0,2,0,2,0,1,0,5
    0,24,1.62,58,0,1,2,3,3,0,1,0,1,1,1,2,1
    0,21,1.63,66,1,1,2,1,3,1,2,0,0,0,1,2,1
    0,19,1.64,53,1,1,2,3,3,0,0,0,1,1,0,2,1
    0,20,1.65,75,1,1,2,1,3,0,1,0,1,1,0,2,3
    0,18,1.5,50,1,1,2,3,1,0,1,0,0,1,1,2,1
    1,18,1.79,52,0,0,2,3,3,0,1,0,1,1,1,2,0
    0,16,1.57,49,0,1,1,4,0,0,1,0,0,1,1,2,1
    1,38,1.75,75,1,0,2,3,1,0,0,0,3,1,0,4,1
    0,23,1.75,56,0,0,2,3,1,0,1,0,2,0,1,2,0
    1,21,1.8,72,0,1,2,3,3,0,1,0,1,1,0,2,1
    1,17,1.8,97,1,1,1,3,3,0,2,0,1,1,1,0,3
    0,29,1.6,56,1,0,1,3,1,0,0,0,0,1,1,2,1
    1,18,1.7,78,0,1,0,3,3,0,1,0,0,1,1,2,3
    1,19,1.8,70,0,1,2,3,1,0,0,0,2,0,0,2,1
    0,18,1.55,56,0,1,1,3,3,0,0,0,0,0,0,4,1
    1,19,1.8,87,1,1,1,4,3,0,1,0,2,1,1,2,2
    1,23,1.75,69,0,0,2,3,2,0,1,0,2,1,1,4,1
    1,18,1.85,66,0,1,1,3,1,0,0,0,1,1,1,2,1
    1,19,1.69,60,0,1,1,3,0,0,0,0,1,1,1,2,1
    1,19,1.76,79,1,1,1,3,1,0,2,0,1,2,2,2,2
    0,18,1.6,51,1,1,1,3,1,0,0,0,1,1,1,2,1
    1,22,1.74,75,1,1,2,3,1,0,0,0,1,0,0,4,1
    0,19,1.54,42,0,1,2,1,3,0,1,0,0,1,0,2,0
    1,19,1.78,64,0,1,1,3,3,0,0,0,1,0,0,2,1
    1,21,1.8,73,1,1,0,3,0,0,1,0,3,1,1,2,1
    0,19,1.56,50,0,1,1,1,3,0,0,0,0,2,0,2,1
    0,26,1.63,104,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,21,1.52,42,0,1,2,1,1,0,0,0,0,0,1,2,0
    0,21,1.73,50,0,0,2,3,1,0,0,0,0,0,1,2,0
    1,21,1.71,51,1,1,2,3,1,0,0,0,0,0,0,2,0
    0,19,1.67,49,0,0,1,3,1,0,0,0,2,1,1,2,0
    1,18,1.76,52,0,1,1,3,3,0,1,0,0,1,1,2,0
    1,17,1.82,59,1,1,1,3,3,0,1,0,2,1,0,4,0
    0,22,1.72,50,1,1,1,3,1,0,0,0,0,0,0,2,0
    1,17,1.88,60,1,1,2,3,3,0,1,0,2,0,0,4,0
    0,23,1.71,50,1,1,1,3,1,0,1,0,0,2,0,2,0
    0,18,1.7,50,0,1,1,3,3,0,1,0,0,1,1,2,0
    1,17,1.83,59,1,1,1,4,3,0,1,0,2,0,0,4,0
    1,19,1.76,54,1,1,1,3,3,0,1,0,1,1,0,2,0
    0,21,1.59,44,0,0,2,1,1,0,1,0,1,0,0,2,0
    0,23,1.6,42,0,0,1,2,1,0,1,0,1,0,0,2,0
    0,18,1.73,50,0,1,0,3,3,0,0,0,1,0,1,2,0
    0,18,1.54,41,0,1,1,1,3,0,0,0,0,1,1,2,0
    0,16,1.74,50,0,1,1,3,3,0,0,0,1,0,1,2,0
    1,19,1.79,58,1,1,1,3,3,0,1,0,2,1,0,4,0
    0,16,1.78,44,0,1,1,3,3,0,1,0,2,1,1,2,0
    1,20,1.76,55,1,1,1,3,3,0,1,0,2,1,0,2,0
    0,19,1.52,42,0,1,1,1,1,0,0,0,0,0,1,2,0
    1,21,1.61,67,1,1,1,3,2,0,2,0,1,0,1,2,2
    0,29,1.67,71,1,1,1,3,3,0,0,0,1,0,1,4,2
    0,24,1.6,64,0,1,1,3,3,0,0,0,0,0,1,2,2
    0,35,1.67,73,1,0,2,2,3,0,0,0,0,0,1,4,2
    0,16,1.62,67,1,1,0,1,3,0,1,1,0,1,0,2,2
    0,42,1.77,75,1,1,2,2,3,0,1,0,0,0,1,4,2
    1,22,1.87,89,1,1,1,2,3,0,0,0,0,1,1,2,2
    1,21,1.86,89,1,1,1,3,3,0,0,0,0,0,1,2,2
    0,21,1.76,78,1,1,2,1,3,0,1,0,2,0,1,2,2
    0,18,1.5,55,0,1,1,3,3,0,0,1,0,0,1,2,2
    0,16,1.6,65,1,1,1,1,3,0,1,1,0,1,0,2,2
    0,21,1.56,63,0,1,1,1,3,0,0,0,1,0,1,2,2
    0,27,1.55,62,0,1,1,1,3,0,0,0,0,0,1,2,2
    0,18,1.76,79,1,1,1,2,3,0,1,0,1,1,2,2,2
    1,26,1.8,85,1,1,1,3,3,0,1,0,0,0,1,4,2
    0,21,1.61,67,1,1,1,3,2,0,2,0,1,0,1,2,2
    0,21,1.61,67,1,1,0,3,2,0,1,0,1,0,1,2,2
    0,21,1.74,78,1,1,1,1,3,0,0,0,1,0,1,2,2
    0,22,1.6,65,0,1,1,3,3,0,0,0,0,0,1,2,2
    0,17,1.6,65,1,1,2,2,3,0,1,1,0,1,1,2,2
    1,29,1.77,87,0,1,0,3,3,0,0,0,1,0,0,4,2
    1,19,1.82,87,1,1,1,3,3,0,1,0,2,0,1,2,2
    1,22,1.79,89,1,1,0,1,3,0,1,0,0,1,1,2,3
    0,23,1.67,80,1,1,1,2,3,0,0,0,0,1,0,2,3
    1,23,1.71,83,1,1,1,2,3,0,0,0,0,1,1,2,3
    1,24,1.7,80,1,1,1,3,3,0,1,0,0,0,1,2,3
    0,18,1.62,72,1,0,2,3,3,0,1,0,1,1,1,2,3
    1,17,1.72,85,1,1,1,3,3,0,1,0,1,0,1,2,3
    0,34,1.69,77,1,1,2,1,3,0,1,0,0,0,0,4,3
    1,22,1.79,89,1,1,0,1,3,0,1,0,0,0,1,2,3
    1,31,1.71,82,1,1,1,3,3,0,0,0,0,0,0,4,3
    1,22,1.72,81,1,1,1,1,3,0,0,0,1,1,1,2,3
    0,25,1.5,64,1,0,1,1,3,0,0,0,0,0,0,2,3
    1,37,1.84,92,1,1,1,1,3,0,1,0,1,0,1,4,3
    1,18,1.74,86,1,1,2,3,3,0,1,0,2,0,1,2,3
    1,23,1.72,83,1,1,1,2,3,0,0,0,0,0,1,2,3
    1,31,1.8,91,1,1,1,3,3,0,0,0,0,0,1,2,3
    0,20,1.51,64,1,0,1,3,3,0,1,0,1,1,0,2,3
    0,37,1.68,79,1,1,1,3,3,0,0,0,0,0,0,4,3
    0,33,1.68,77,1,1,2,2,3,0,0,0,1,0,0,4,3
    1,19,1.71,78,1,0,0,2,3,0,1,0,1,0,1,2,3
    1,30,1.84,93,1,1,1,2,3,0,0,0,1,0,1,2,3
    1,24,1.79,89,1,1,0,2,3,0,1,0,0,0,1,2,3
    1,24,1.72,85,1,1,1,2,3,0,1,0,0,0,1,2,3
    0,19,1.55,69,1,0,1,3,3,0,0,0,0,1,0,2,3
    1,39,1.79,101,1,1,1,2,3,0,1,0,2,1,1,4,4
    0,43,1.57,81,1,1,1,1,3,0,1,0,1,0,0,4,4
    1,22,1.73,95,1,1,1,3,3,0,1,0,2,1,0,2,4
    0,40,1.55,77,1,1,1,3,3,0,0,0,0,0,1,4,4
    1,26,1.66,90,1,1,1,3,3,0,2,0,0,0,1,4,4
    1,20,1.78,102,1,1,1,3,3,0,0,0,1,0,0,2,4
    1,29,1.83,108,1,1,1,2,3,0,1,0,0,1,1,4,4
    0,18,1.67,86,1,1,1,3,3,0,0,0,1,0,0,2,4
    0,22,1.6,82,1,1,0,1,3,0,1,0,0,0,1,2,4
    1,22,1.75,95,1,1,1,3,3,0,2,0,3,2,0,2,4
    1,29,1.76,108,1,1,2,3,3,0,0,0,1,0,1,4,4
    1,22,1.7,93,1,1,1,3,3,0,0,0,0,0,0,2,4
    1,21,1.72,94,1,1,1,2,3,0,1,0,0,1,0,2,4
    1,30,1.69,90,1,1,1,2,3,0,1,0,1,0,1,4,4
    0,18,1.68,90,1,1,0,3,3,0,0,0,0,1,1,2,4
    0,19,1.63,82,1,1,1,2,3,0,0,0,0,1,0,2,4
    0,38,1.53,75,1,1,1,3,3,0,0,0,0,0,1,4,4
    1,29,1.81,109,1,1,1,2,3,0,0,0,1,0,1,4,4
    0,18,1.7,91,1,1,0,3,3,0,0,0,0,0,1,2,4
    0,24,1.62,81,1,1,1,1,3,0,0,0,0,0,0,2,4
    0,42,1.57,81,1,1,1,1,3,0,0,0,1,0,0,4,4
    1,31,1.67,90,1,1,1,1,3,0,1,0,1,0,1,4,4
    0,23,1.58,78,1,1,1,1,3,0,1,0,0,0,0,2,4
    1,20,1.86,115,1,1,1,3,3,0,2,0,0,1,1,2,4
    1,29,1.8,108,1,1,1,2,3,0,1,0,1,1,1,4,4
    1,20,1.7,98,1,1,1,2,3,0,1,0,0,1,0,2,4
    0,19,1.61,82,1,1,0,2,3,0,0,0,0,0,0,2,4
    1,24,1.76,112,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,24,1.76,117,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,24,1.61,98,1,1,2,2,3,0,0,0,1,0,0,2,5
    1,29,1.9,124,1,1,1,3,3,0,1,0,1,0,1,2,5
    1,21,1.77,116,1,1,1,3,3,0,1,0,1,1,1,2,5
    1,24,1.83,120,1,1,1,3,3,0,1,0,2,0,1,2,5
    1,21,1.85,122,1,1,2,2,3,0,0,0,0,0,1,2,5
    1,28,1.82,120,1,1,1,3,3,0,1,0,1,0,1,4,5
    1,31,1.77,120,1,1,1,3,3,0,1,0,1,0,1,4,5
    1,25,1.77,114,1,1,1,3,3,0,1,0,1,0,1,2,5
    1,40,1.75,109,1,1,1,2,3,0,0,0,0,0,0,4,5
    1,25,1.79,115,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,25,1.77,115,1,1,1,3,3,0,1,0,1,1,1,2,5
    1,27,1.79,112,1,1,1,3,3,0,1,0,0,1,1,4,5
    1,30,1.76,118,1,1,1,3,3,0,1,0,1,1,1,4,5
    1,25,1.76,112,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,25,1.76,113,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,20,1.62,104,1,1,1,1,3,0,0,0,0,1,0,2,5
    1,25,1.77,112,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,31,1.68,102,1,1,1,2,3,0,0,0,1,0,0,2,5
    1,27,1.69,99,1,1,1,2,3,0,0,0,0,0,0,2,5
    1,31,1.87,123,1,1,1,3,3,0,1,0,0,0,1,2,5
    1,25,1.79,115,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,23,1.77,116,1,1,0,3,3,0,1,0,0,0,1,2,5
    1,36,1.74,106,1,1,1,2,3,0,0,0,1,0,0,4,5
    1,24,1.61,100,1,1,1,1,3,0,0,0,1,1,0,2,5
    1,24,1.76,112,1,1,0,3,3,0,1,0,0,0,1,4,5
    1,30,1.76,111,1,1,0,3,3,0,0,0,0,0,1,4,5
    1,26,1.89,121,1,1,1,3,3,0,1,0,1,0,1,2,5
    1,25,1.76,113,1,1,0,3,3,0,1,0,1,0,1,2,5
    1,38,1.75,119,1,1,1,2,3,0,0,0,0,0,1,4,5
    1,23,1.85,121,1,1,2,2,3,0,1,0,0,0,1,2,5
    1,24,1.61,100,1,1,1,1,3,0,0,0,0,1,0,2,5
    0,20,1.74,130,1,1,2,3,3,0,0,0,1,0,1,2,6
    0,26,1.64,111,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,20,1.81,138,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,18,1.75,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,26,1.62,105,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,26,1.64,111,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,25,1.64,105,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,26,1.63,110,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,19,1.75,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,26,1.62,104,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,18,1.8,138,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,21,1.73,131,1,1,2,3,3,0,0,0,1,0,1,2,6
    0,23,1.64,113,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,18,1.74,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,20,1.7,126,1,1,2,3,3,0,0,0,0,0,1,2,6
    0,21,1.75,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,21,1.75,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,18,1.76,133,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,21,1.76,137,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,25,1.62,110,1,1,2,3,3,0,0,0,0,0,1,2,6
    0,26,1.64,110,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,26,1.62,111,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,25,1.59,110,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,20,1.72,132,1,1,2,3,3,0,0,0,1,0,1,2,6
    0,24,1.65,113,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,18,1.75,128,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,18,1.74,126,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,19,1.81,150,1,1,2,3,3,0,1,0,1,0,1,2,6
    0,25,1.67,112,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,26,1.64,111,1,1,2,3,3,0,1,0,0,0,1,2,6
    0,23,1.74,133,1,1,2,3,3,0,1,0,1,0,1,2,6
")

# Obtenemos los datos en formato ancho
datos.wide <- read.csv(
  file = textConnection(texto),
  header = TRUE,
)

# Se toma una muestra de la población para crear el modelo
set.seed(123456789)
tamaño.poblacion <- nrow(datos.wide)
tamaño.muestra <- 150
datos <- datos.wide[sample(1:tamaño.poblacion, tamaño.muestra), ]

#preparacion para aplicarles factor (normal, anormal)
IMC <- datos$Categoria
categoria <- rep("Normal", length(IMC))
categoria[IMC != 1] <- "Anormal"


datos <- subset( datos, select = -Categoria )
datos.long <- gather(datos, key = "Medida", value = "Valor")
datos.long[["Medida"]] <- factor(datos.long[["Medida"]])


#aplicacion del factor
datos.long[["Clasificación"]] <- factor(rep(categoria, ncol(datos)))
datos[["Clasificación"]] <- factor(categoria)

# A continuación, se creara un modelo y se entrenara de 2 formas diferentes:
# 1. La primera será de forma manual en donde se separan los datos
# en dos datasets, uno para entrenamiento y un segundo para realizar pruebas
# de la calidad del modelo generado.
#
# 2-La segunda forma corresponde a realizar estre entrenamiento de forma 
# automatica mediante train()


# Método 1:
# Se separan los datos: un 70% se usan para entrenar al modelo
# y el otro 30% se usan para testear el modelo.
i.para.entrenar <- createDataPartition(
  y = datos[["Clasificación"]],
  times = 1,
  p = .7, 
  list = FALSE
)

set.seed(20139)
i.para.entrenar1 <- c(i.para.entrenar)
i.para.probar1 <- (1:nrow(datos))[-i.para.entrenar]

datos.train <- datos[i.para.entrenar1, ]
datos.test  <- datos[i.para.probar1, ]

# Una vez que se tienen los datos separados se utiliza
# la función step() para crear el modelo

# Para esto primero se crea el modelo nulo
nulo <- glm(Clasificación ~ 1,
            family = binomial(link = "logit"),
            data = datos.train)

# Luego, se crea el modelo completo, con todas las posibles variables.
completo <- glm(Clasificación ~ . ,
                family = binomial(link = "logit"),
                data = datos.train)

# Después se crea el modelo de forma automatica mediante
# regresión escalonada en ambas direcciones con la función step()
modelo <- step(
  nulo,
  scope = list(lower = nulo, upper = completo),
  direction = "both"
)

cat("Modelo obtenido automáticamente con regresión escalonada\n")
print(modelo)
cat("Fórmula del Modelo\n")
print(modelo$formula)


# Una vez obtenido el modelo a partir de la función step() vemos que
# se han escogido 11 variables, sin embargo en el enunciado se solicita
# un modelo de 3 a 8 variables por lo que se deben seleccionar algunas
# variables para su eliminación.

# Para esto se usa la función drop1() la cual nos indica cuales son las
# posibles candidatas para eliminarse.
print(drop1(modelo,test="F"))

# Al analizar el output de drop1() se puede ver que al eliminar cualquier
# variables el p-valor es el mismo, por lo tanto se usa como criterio el AIC.
# En este sentido, se obtendría un AIC más bajo eliminando la variable 
# Historia.
modelo <-update(modelo, . ~ . - Peso)

# Se vuelve a analizar que variable se debe eliminar
print(drop1(modelo,test="F"))

# Se decide eliminar la variable Edad, ya que es la que tiene el p-valor
# más alto y con la que se obtendría un AIC más bajo.
modelo <-update(modelo, . ~ . - Edad)

# Se vuelve a analizar que variable se debe eliminar
print(drop1(modelo,test="F"))

# Por último, se decide eliminar la variable Agua con el mismo criterio
# utilizado anteriormente.
modelo <-update(modelo, . ~ . - Agua)

cat("Modelo de 8 variables\n")
print(modelo)
cat("Fórmula del Modelo\n")
print(modelo$formula)


# Una vez creado el modelo comienza a testear el modelo
prediccion <- predict(modelo, datos.test, type = "response")
clases.pred <- rep("Normal", length(prediccion))
clases.pred[prediccion < 0.5] <- "Anormal"
clases.pred <- factor(clases.pred, levels = c("Anormal", "Normal"))

# Se crea la matriz de confusión para analizar cuantos datos
# se predijeron de forma correcta según la variable Clasiicación.
matriz.confusion <- confusionMatrix(
  data = clases.pred,
  reference = datos.test[["Clasificación"]],
  positive = "Normal"
)

# Se muestra la matríz de confusión por consola y de forma gráfica
cat("Comparación de clasificación predicha y observaciones\n")
print(matriz.confusion)
mosaic(matriz.confusion$table, shade = T, colorize = T,
       main="Modelo 1",gp = gpar(fill = matrix(c("green3", "red2", "red2", "green3"), 2, 2)))


# Se puede observar que la predicción del modelo es bastante acertada,
# con una exactitud de aproximadamente el 90%, sin embargo, la sensibilidad
# no es tan alta.

# Se calcula el ROC para luego ser comparado con el modelo 
# entregado con el método 2.
modelo.roc <- roc(datos.test[["Clasificación"]],
                  prediccion,
                  percent = TRUE,
                  print.auc = TRUE)

# Para tener un modelo con el cual comparar se procede a entrenar el mismo
# con el método 2.

# Método 2: La segunda forma corresponde a realizar estre entrenamiento
# de forma automatica mediante train(), utilizando la misma fórmula
# entregada por la función step()
control <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = TRUE
)

# Se entrena el modelo con la función train()
modelo2 <- train(
  modelo$formula,
  data = datos,
  method = "glm",
  trControl = control
)

# Se utiliza la función predict() para predecir los datos
# del segundo modelo 
clases.pred2 <- predict(modelo2, newdata = datos)
matriz.confusion2 <- confusionMatrix(
  data = clases.pred2,
  reference = datos[["Clasificación"]],
  positive = "Normal"
)

# Se muestra la matríz de confusión por consola y de forma gráfica
cat("Comparación de clasificación predicha y observaciones\n")
print(matriz.confusion2)
mosaic(matriz.confusion2$table, shade = T, colorize = T,
       main="Modelo 2", gp = gpar(fill = matrix(c("green3", "red2", "red2", "green3"), 2, 2)))

# Se calcula el ROC (Area bajo la Curva o AUC) para el segundo modelo
prob.pred2 <- predict(modelo2, newdata = datos, type = "prob")
modelo2.roc <- roc(datos[["Clasificación"]],
                   prob.pred2[["Normal"]],
                   percent = TRUE,
                   print.auc = TRUE)

# Se compararan la sensibilidad y escificidad del modelo obtenido 
# con el método 1 y 2
ggroc1 <- ggroc(modelo.roc) + ggtitle("Modelo 1")
ggroc2 <- ggroc(modelo2.roc) + ggtitle("Modelo 2")
rocs <- ggarrange(ggroc1, ggroc2,
                  nrow = 1, ncol = 2)
matrices <- ggarrange(mosaic)

cat("Gráfico Sensitivity vs Specificity del Modelo 1 y 2\n")
print(rocs)

# Se puede observar que el modelo 2 es mucho mejor que el primer
# ya que se tiene una sensibilidad mucho mayor. En el primer modelo
# se obtiene una linea recta lo cual indica una sensibilidad muy baja.

# Por otra parte, al analizar la matriz de confusión de ambos modelos
print(matriz.confusion)
print(matriz.confusion2)

# Se puede ver que si bien la exactitud es mayor en el modelo 1 (0,91)
# Situaciones problemáticas: Multicolinealidad
# --------------------------------------------
#a continuacion se revisara el VIF y VIF medio y tolerancia
# que como se puso mas arriba correspondia a rangos que se deben tener cuidado

vifs <- vif(modelo2$finalModel)
cat("\n")
cat("Factores de inflación de la varianza\n")
cat("------------------------------------\n")
print(round(vifs, 1))

cat("\n")
cat("Factor de inflación de la varianza medio\n")
cat("----------------------------------------\n")
print(round(mean(vifs), 1))

tols <- 1/vifs
cat("\n")
cat("Tolerancia\n")
cat("----------\n")
print(round(tols, 2))

# Se puede observar que los valores del vif en todos los casos
# son menores a 10 por lo que no debería ser preocupante. En cuanto
# al vif promedio es 1.7, por lo que podría existir sesgo en el modelo.
# Por último, la tolerancia obtenida en casi todos los casos es mayor
# a 0.4 excepto en la variable Género y estatura (0.31 y 0.36), pero
# de igual forma no es un valor tan bajo.
# Se puede decir entonces que existe una multicolinealidad muy baja
# en el modelo obtenido, de acuerdo a lo observado en el vif y la tolerancia,
# por lo que se cumple la condición entregada en el enunciado.

# Finalmente, se tiene el siguiente modelo:
#      formula: Peso + Genero + Vegetales + Aparatos + Agua + Fuma + NumComidas + Estatura  

# El cual cumple con una exactitud en la predicción de un 90% (mayor al 
# 85% solicitado en el enunciado) y con una espcificidad de un 96% lo cual
# es bastante alto y una sensibilidad de 56% lo que no es tan alto en relación
# a la especificidad pero es mucho más alto que el primer modelo generado. 
# Además, al analizar el vif y la toleracia en la última parte se verifica
# que el modelo posee una multicolinealidad baja y casi nula.

# etica ...



