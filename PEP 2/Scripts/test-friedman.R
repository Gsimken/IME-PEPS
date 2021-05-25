library(ggplot2)
library(ggpubr)
library(tidyr)
texto <-("
 Dataset C3 C6 C7
 'credit' 85,07 85,22 83,33
 'eucalyptus' 58,71 59,52 59,40
 'glass' 73,83 75,69 73,33
 'hepatitis' 83,79 82,50 81,25
 'iris' 92,67 92,00 93,33
 'optdigits' 96,90 94,20 91,80
 'page-blocks' 96,95 94,15 96,97
 'pendigits' 97,82 94,81 95,67
 'pima-diabetes' 75,01 74,75 72,67
 'primary-tumor' 47,49 49,55 38,31
 'solar-flare-C' 88,54 87,92 86,05
 'solar-flare-m' 87,92 86,99 85,46
 'solar-flare-X' 97,84 94,41 95,99
 'sonar' 81,26 80,79 78,36
 'waveform' 84,92 83,62 79,68
 'yeast' 56,74 57,48 56,26 ")

datos <- read.table(textConnection(texto), header = TRUE, dec=",")

d1 <- datos$C3
d2 <- datos$C6
d3 <- datos$C7
lista <- list(d1,d2,d3)
lista


datos_wide_2 <- data.frame(lista)
colnames(datos_wide_2) <- c( "c3", "c6", "c7" )
datos_long_2 <- gather(
  data = datos_wide_2,
  key = "Algoritmo",
  value = "Tiempo",
  c( "c3", "c6", "c7" )
)
Problema <- factor(rep(1:nrow(datos_wide_2), ncol(datos_wide_2)))
datos_long_2 <- cbind(Problema, datos_long_2)
datos_long_2[["Algoritmo"]] <- factor(datos_long_2[["Algoritmo"]])
friedman.test(datos_long_2$Tiempo, datos_long_2$Algoritmo, datos_long_2$Problema)