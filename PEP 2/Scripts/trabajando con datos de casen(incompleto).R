library("readxl")
# Indicar directorio
dir <- "~/MisArchivos/Usach/Inferencia"

basename <- "Datos-Casen-v2.xls"
absolute_path <- "~/MisArchivos/Usach/Inferencia/Datos-Casen-v2.xls"
#file <- file.path(dir, basename)
poblacion <- read_excel(absolute_path)

# Se devuelve un "marco de datos" o data.frame
#print(class(poblacion))
#print(str(poblacion))

# Podemos obtener el n?mero de filas (o de columnas) que corresponde al n?mero de
# "casos" en la muestra/poblaci?n (o de variables).
tamano.poblacion <- nrow(poblacion)
tamano.poblacion

regionAraucania <- poblacion$r1a[poblacion$region == "Región de La Araucanía"]

regionTarapacá <- poblacion$r1a[poblacion$region == "Región de Tarapacá"]

print(regionTarapacá)

tamano.araucania <- length(regionAraucania)
tamano.tarapaca <- length(regionTarapacá)

semilla <- 113
tamano.muestra1 <- 100
tamano.muestra2 <- 100

set.seed(semilla)
muestra1 <- regionAraucania[sample(1:tamano.araucania, tamano.muestra1), ]
muestra2 <- regionTarapacá[sample(1:tamano.tarapaca, tamano.muestra2), ]

muestra1
muestra2