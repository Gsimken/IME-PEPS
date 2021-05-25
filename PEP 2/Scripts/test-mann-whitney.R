texto <-("
 Dataset C2 Dataset C4
 'anneal' 98,00 'cmc' 51,05
 'contact-lenses' 68,33 'credit' 86,23
 'ecoli' 80,04 'grub-damage' 47,79
 'kr-s-kp' 92,46 'monks' 62,24
 'monks1' 100,00 'mushroom' 95,83
 'nursery' 94,28 'page-blocks' 93,51
 'pasture-production' 85,83 'postoperatie' 66,67
 'primary-tumor' 48,08 'segment' 91,30
 'solar-flare-C' 88,24 'soybean' 92,08
 'squash-stored' 58,00 'squash-unstored' 61,67
 'tae' 44,38 'waveform' 79,86
 'white-clover' 79,29")
datos <- read.table(textConnection(texto), header = TRUE, dec=",", fill = TRUE)
datos

muestraX <- datos[ ,2]

muestraY <- datos[ ,4]

print(muestraX)
print(muestraY)

#Hipotesis nula ??
#Hipotesis Alternativa ??


#Se verifican las condiciones
#1. Los datos son independientes
#2. Los datos tienen que ser ordinales
#o bien se tienen que poder ordenar de menor a mayor.
#3. Igualdad de varianza entre grupos (homocedasticidad).

#Para verificar la condición 3:
fligner.test(x = list(muestraX,muestraY))

#No hay evidencias en contra de la igualdad de varianzas.

#Se realiza el test
wilcox.test(x = muestraX, 
            y = muestraY, 
            alternative = "two.sided", 
            mu = 0,
            paired = FALSE, 
            conf.int = 0.95)
