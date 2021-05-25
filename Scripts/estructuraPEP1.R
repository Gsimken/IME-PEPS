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
#
#
# desarrollo de la pregunta ...
#
#


# Pregunta 2
# ==========
#
#
#
# desarrollo de la pregunta ...
#
#
#



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
#
#
#
# desarrollo de la pregunta ...
#
#
#



###### 
# lo que sigue son Cosas que nos pueden servir y que despues tenemos que 
# ordenar, mover a las preguntas de arriba o borrar

semilla <- 113
tamaño.muestra <- 100

set.seed(semilla)
muestra <- población[sample(1:tamaño.población, tamaño.muestra), ]

edad<-población$age
anemia<-población$anaemia
creatina.quinasa<-población$creatinine_phosphokinase
diabetes<- población$diabetes 
fracción.de.eyeccion<-población$ejection_fraction 
fracción.de.eyeccion2<-población$ejection_fraction_2
hipertensión<-población$high_blood_pressure
plaquetas<-población$platelets
creatina.sérica<-población$serum_creatinine
creatina.sérica2<-población$serum_creatinine_2
sodio.sérico<-población$serum_sodium
sexo<-población$sex
fumador<-población$smoking
tiempo<-población$time
muerte<-población$DEATH_EVENT

cat("\n\n")
cat("Titulo del estudio o pregunta aqu? colocar en nombre de archivo FORMA XX\n")
cat("=========================\n")

# copiar enunciado de la pregunta aqui como comentario

cat("\nHipotesis a contrastar:\n")
cat("  H0: aqui va la hipotesis nula\n")
cat("  HA: aqui va la hipotesis alternativa\n")

cat("\n\nDatos:\n")

cat("\n\nQue prueba se va a utilizar:\n")

cat("\n\nVerificar condiciones para la prueba:\n")

#Aplicar prueba


# ======================================================================================
# ======================================================================================
# también podemos agregar los graficos pa llegar y copiarlos

# Dado que el tamaño de la muestra es grande, deberíamos intentar
# responder esta pregunta con un test Z, siempre y cuando se cumplan
# las condiciones: (OpenIntro Statistics pág. 178)
# 1) The sample observations are independent.
# 2) The sample size is large: n ≥ 30 is a good rule of thumb.
# 3) The population distribution is not strongly skewed. 
#    This condition can be difficult to evaluate, so just use your best
#    judgement. Additionally, the larger the sample size, the more
#    lenient we can be with the sample’s skew.

# Condición 1: No nos dicen mucho de cómo se seleccionaron las 49
# imágenes. Pero como se trata de un artículo científico, publicado en
# un journal serio, podemos suponer que los autores del artículo se
# preocuparon de obtener una muestra de observaciones aleatorias e
# independientes.
# 
# Condición 2: Se cumple, puesto que tenemos 49 > 30 ejemplos.
# 
# Condición 3: Tenemos el problema de que no conocemos la población !!!
# Podemos ver el comportamiento de la muestra usando un histograma y
# un gráfico cuantil-cuantil (QQ plot).:

d <- data.frame(ADL = muestra)

p1.1 <- gghistogram(
  d, x = "ADL",
  binwidth = 0.15,
  color = "#6D9EC1",
  fill = "#BFD5E3"
)


p1.2 <- ggqqplot(
  d, x = "ADL",
  color = "#6D9EC1",
  fill = "#BFD5E3"
)
