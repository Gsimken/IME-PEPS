# FORMA 13

# ==============================================================================
# ================================ Pregunta 1 ==================================

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
datos.todos <- read.csv(
  file = textConnection(texto),
  header = TRUE,
)

# Para definir las variables predictoras que nos ayudarán a predecir
# la variable peso se realizó una pequeña investigación en distintos 
# sitios web, buscando cuales eran los factores que influyen
# mayoritariamente en el sobrepeso de las personas. Según la Organización
# Mundial de la Salud (OMS) menos del 30% de la ingesta calórica
# debe ser procedente de grasas y menos del 10% de la ingesta calórica
# total debe ser libre de azúcares. Además, indica que es muy importante
# consumir frutas, verduras y legumbres (https://www.who.int/es/news-room/fact-sheets/detail/healthy-diet#:~:text=Frutas%2C%20verduras%2C%20legumbres%20(tales,mandioca%20y%20otros%20tub%C3%A9rculos%20feculentos.)

# según la Organización Panamericana de Salud (OPS) el alcohol y el cigarro
# son factores que podrían afectar la salud de las personas e incidir en el
# sobrepeso de las mismas (https://www.paho.org/chi/index.php?option=com_content&view=article&id=1125:ops-oms-gobierno-y-academia-dialogan-sobre-los-efectos-a-la-salud-publica-de-la-obesidad-el-consumo-de-tabaco-y-alcohol&Itemid=1005)

# Lo anterior ya nos da un indicio para identificar las posibles 
# variables que podrían ser parte del modelo de regresión, tales como:
# Vegetales, Bocadillos, Fuma, Alcohol.

# Sin embargo, para tener una mirada más amplia de como se comportan dichas variables
# se procederá a analizar graficamente los datos.

# Primero, una muestra de tamaño 30 con igual número de varones y mujeres
i <- which(datos.todos[["Genero"]] == 0)
j <- which(datos.todos[["Genero"]] == 1)
set.seed(11)
N <- 15
i <- sample(i, N)
j <- sample(j, N)
datos.wide <- datos.todos[c(i, j), ]

# Luego, creamos una variable dicotómica llamada Clasificación
# para identificar personas con "peso normal" o "sobrepeso".
# Esta variable corresponderá a la variable que se pretende
# predecir con el modelo.
BMI <- round(datos.wide[["Peso"]] / (datos.wide[["Estatura"]] )^2, 1)
clasificación <- rep("Normal", length(BMI))
clasificación[BMI >= 25] <- "Sobrepeso"

# Se importa la biblioteca tidyr
library(tidyr)

# De la biblioteca se utiliza la función gather() para convertir los
# datos a long.
datos.long <- gather(datos.wide, key = "Medida", value = "Valor")
datos.long[["Medida"]] <- factor(datos.long[["Medida"]])

# Se agrega la clase Normal o Sobrepeso.
datos.long[["clasificación"]] <- factor(rep(clasificación, ncol(datos.wide)))
datos.wide[["clasificación"]] <- factor(clasificación)

# Se importa la biblioteca ggpubr para utilizar las funciones que permiten
# graficar datos.
library(ggpubr)

# Se grafican los datos
pb <- ggboxplot(
  data = datos.long,
  x = "clasificación", y = "Valor",
  color = "Medida", legend = "none"
)
pbf <- facet(pb, facet.by = "Medida", scales = "free")

# Se muestran los resultados
print(pbf)

# Dado que se desea predecir la variable Clasificación, la cual depende de
# la variable Peso y Estatura, no se deben considerar en los graficos provistos.
# Al observar los graficos de caja, se puede observar que la variable Ejercicio
# podría ser una candidata para agregar al modelo, ya que podría aportar información.
# Otra variable que puede ser candidata es Edad y Transporte, ya que los datos
# están relativamente separadon en el gráfico.

# Según lo anterior se decide crear un modelo de regresión logística con
# las siguientes variables:
# Vegetales, Edad, Transporte, Ejercicio, Fuma, Alcohol
modelo1 <- glm(
  clasificación ~ Vegetales + Edad + Transporte + Ejercicio + Fuma + Alcohol,
  family = binomial(link = "logit"),
  data = datos.wide
)

# Una vez creado el modelo se muestran los resultador
print(summary(modelo1))

# Para tener una referencia de cuanto debería dar el estadístico AIC
# se decide crear un modelo nulo para comparar
datos <- subset(datos.wide, select = -c(Peso,Estatura,Categoria))
nulo <- glm(
  clasificación ~ 1,
  family = binomial(link = "logit"),
  data = datos
)

# Para comparar los modelos se decide utilizar un Likelihood Ratio 
# Test (LRT), que compara qué tanto más "probable" son los datos 
# con un modelo que con el otro.
cat("\n\n")
cat("Likelihood Ratio Test para los modelos\n")
cat("--------------------------------------\n")
print(anova(nulo, modelo1, test = "LRT"))

# Podemos ver que la desviación de los residuos del modelo nulo (41.589)
# es mucho mayor al del modelo con las variables escogidas. Lo cual indica
# que el modelo ha mejorado con respecto al nulo. Sin embargo, no sabemos
# si es el mejor. Para ello se decide utilizar la función step() para dejar 
# que R encuentre el mejor modelo y así compararlo con el ya existente.

# Para dejar que R se encargue de generar el modelo se debe crear el 
# modelo completo, el decir el modelo con todas las variables.
total <- glm(
  clasificación ~ .,
  family = binomial(link = "logit"),
  data = datos
)

# Luego se realiza una búsqueda hacia adelante, es decir, ir agregando
# variables una a una para maximizar el AIC.
cat("\n\n")
cat("=============================================================\n")
cat("Agregando variables al modelo con selección hacia adelante...\n")
cat("=============================================================\n")
cat("\n\n")
modelo.automático <- step(nulo, scope = list(lower = nulo, upper = total),
              direction = "forward", test = "LRT", trace = 1)

# Se muestran los resultados
cat("\n\n")
cat("=============================================================\n")
cat("\n\n")
cat("Modelo obtenido automáticamente con selección hacia adelante\n")
cat("------------------------------------------------------------\n")
print(modelo.automático)

# Luego se vuelve a realizar una prueba de  Likelihood Ratio 
# Test (LRT), que compara qué tanto más "probable" son los datos 
# con un modelo que con el otro.
cat("\n\n")
cat("Likelihood Ratio Test para los modelos\n")
cat("--------------------------------------\n")
print(anova(modelo1, modelo.automático, test = "LRT"))

# Al analizar la desviación de los residuos se puede observar que el 
# modelo que ha encontrado R es considerablemente mejor, ya que este
# tiene una desviación de 9.618 y el modelo que se había encontrado
# 32.082.

# Otro aspecto que se puede analizar es el AIC de ambos:
print(extractAIC(modelo1))
print(extractAIC(modelo.automático))

# Al observar los AIC de ambos modelos, nuevamente se puede notar
# una disminución del AIC del modelo generado automáticamente (21.6178)
# en comparación al del modelo creado en un inicio (46.081). Es por esta
# razón que se decide continuar trabajando con el modelo generado
# automaticamente.

# Una vez encontrado un modelo que pareciera cumplir ciertas espectativas
# (el AIC más bajo encontrado), se deben buscar datos atípicos que
# podrían estar afectando las predicciones del modelo, lo cual podría
# ser perjudicial al momento de trabajar con otros conjuntos de datos.
modelo <- modelo.automático
variables <- names(coef(modelo))[-1]

# Para analizar los posibles datos atípicos se obtienen siguientes
# residuales y estadísticas, que mas adelante se analizarán para
# decidir.
output <- data.frame(predicted.probabilities = fitted(modelo))
output[["standardized.residuals"]] <- rstandard(modelo)
output[["studentized.residuals"]] <- rstudent(modelo)
output[["cooks.distance"]] <- cooks.distance(modelo)
output[["dfbeta"]] <- dfbeta(modelo)
output[["dffit"]] <- dffits(modelo)
output[["leverage"]] <- hatvalues(modelo)

subdatos <- datos[, c(variables, "clasificación")]
sospechosos1 <- which(abs(output[["standardized.residuals"]]) > 1.96)
sospechosos1 <- sort(sospechosos1)
cat("\n\n")
cat("Residuales estandarizados fuera del 95% esperado\n")
cat("------------------------------------------------\n")
print(rownames(subdatos[sospechosos1, ]))

# Recomendaciones dicen deberíamos preocuparnos por los casos en que la
# distancia de Cook es mayor a uno.
sospechosos2 <- which(output[["cooks.distance"]] > 1)
sospechosos2 <- sort(sospechosos2)
cat("\n\n")
cat("Residuales con una distancia de Cook alta\n")
cat("-----------------------------------------\n")
print(rownames(subdatos[sospechosos2, ]))

# También se recomienda revisar casos cuyo "leverage" sea más del doble
# o triple del leverage promedio: (k + 1)/n
leverage.promedio <- ncol(subdatos) / nrow(datos)
sospechosos3 <- which(output[["leverage"]] > leverage.promedio)
sospechosos3 <- sort(sospechosos3)
cat("\n\n")
cat("Residuales con levarage fuera de rango (> ")
cat(round(leverage.promedio, 3), ")", "\n", sep = "")
cat("--------------------------------------\n")
print(rownames(subdatos[sospechosos3, ]))

# También podríamos revisar DFBeta, que debería ser < 1.
sospechosos4 <- which(apply(output[["dfbeta"]] >= 1, 1, any))
sospechosos4 <- sort(sospechosos4)
names(sospechosos4) <- NULL
cat("\n\n")
cat("Residuales con DFBeta sobre 1\n")
cat("-----------------------------\n")
print(rownames(subdatos[sospechosos4, ]))

# Puede verse que los casos sospechosos más o menos se repiten con cada
# estadística. Revisemos estos casos.

sospechosos <- c(sospechosos1, sospechosos2, sospechosos3, sospechosos4)
sospechosos <- sort(unique(sospechosos))
cat("\n\n")
cat("Casos sospechosos\n")
cat("-----------------\n")
print(subdatos[sospechosos, ])
cat("\n\n")
print(summary(subdatos[sospechosos, ]))
cat("\n\n")
print(output[sospechosos, ])

# Ahora bien, debemos notar que la distancia de cook de los primeros sospechosos es mucho 
# mayor a 1, por lo que hay que vigilaros y considerar eliminarlos.

# Luego de comprobar datos atipicos se deben verificar ciertas condiciones 
# que el modelo debe cumplir.

# 1. Independencia del error
library(car)
cat("\n\n")
cat("Prueba de Durbin–Watson para autocorrelaciones entre errores\n")
cat("------------------------------------------------------------\n")
print(durbinWatsonTest(modelo, max.lag = 5))
# La mayoría de los valores parecen estar dentro de la región de aceptación, sin embargo,
# existe uno que puede preocuparnos uno que es menor a 1.18, por lo que podría
# significar que hay autocorrelación


# no multicolinialidad
vifs <- vif(modelo)
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

# A partir del calculo del VIF podemos darnos cuenta que ambos valores estan
# por debajo del umbral de 10, Sin embargo el promedio de 1.7 podría sugerir
# un posible sesgo en el modelo. Además ambos valores de tolerancia son mayores
# a 0.2, por lo que no debería existir muchos problema con estos datos.

# Finalmente, a partir de los estadisticos calculados, se puede decir que
# existe una multicolinealidad muy baja en el modelo, sin embargo se encontraron
# datos que parecieran ser problematicos, por lo que es necesario
# evaluar quitarlos del modelo

# Por ultimo el modelo encontrado y al que se le han aplicado todas las pruebas 
# es el siguiente:
print(modelo)

# Se puede ver que  el Deviance ha disminuido considerablemente en consideración
# con el modelo nulo, también el AIC es mucho mas bajo que el inicial, lo cual
# nos da un claro indicio de que el modelo ha ido mejorando, además se buscaron 
# posibles datos atipicos que pudieran estar afectando el modelo, y parecieran
# haberse encontrado 3 que deben ser tratados.

# Otro indicio de que el modelo encontrado cumple con precedir la variable en
# en estudio es el cumplimiento de todas las suposiciones, como por ejemplo:
# la no multicolinealidad, no autocorrelación de los residuos, etc  .

# Si bien se intento encontrar el mejor modelo a partir de los procedimientos
# estudiados en clase, cabe mencionar que es existe la posibilidad de que el
# modelo encontrado no funcione para todos aquellos conjuntos de datos
# relacionados con el tema de estudio, por lo que corresponde a un modelo 
# relativamente confiable, pero no definitivo, es por esto que se debe
# seguir perfeccionando.

# Es importante mencionar, que la busqueda de un modelo con los procedimientos
# utilizados no resulta ética cuando se esta intentando probar una teoría, o
# se quiere obtener beneficio propio a partir de los resultados, sin embargo,
# en nuestro caso solo se esta explorando los datos, con motivo de estudio y
# aprendizaje.




# Pregunta 2

# A raíz de la pandemia nacida tras la propagación mundial del Covid-19, 
# se gestaron diferentes medidas para poder mitigar los efectos económicos 
# en Chile. Una de estas medidas corresponde al retiro de hasta un 10% en 
# los fondos acumulados en la cuenta de cada afiliado al sistema de AFP 
# (Administradora de Fondos de Pensiones). A partir de este contexto, se
# quiere estudiar la correlación existente entre el impacto de retiro de 
# fondos (caída de la pensión medida en porcentaje) y la edad de retiro a 
# partir del imponible promedio ($819.729) en mujeres.

#Edad (años)	Impacto (%)
#20	7,1%
#22	7,3%
#25	7,5%
#27	7,6%
#30	7,4%
#32	7,1%
#35	6,9%
#37	6,5%
#40	5,3%
#42	7,0%
#45	7,7%
#47	8,2%
#50	8,1%
#52	7,7%
#55	7,8%
#57	8,8%
#60	9,1%
#62	9,8%
#65	9,6%


