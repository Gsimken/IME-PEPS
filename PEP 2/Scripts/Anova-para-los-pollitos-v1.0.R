
require(ez)
library(ggpubr)
library(knitr)
library(tidyr)


# Vamos a usar los datos en 'chickwts'.
# Los datos vienen en formalo largo (long), como se necesitan para la
# mayoría de las rutinas para hacer procedimientos ANOVA y graficar.
# Pero les falta el identificador de los casos, lo que agregamos ahora.
# También cambiamos el nombre de las variables para mayor facilidad.
Pollito <- factor(1:nrow(chickwts))
datos.long <- data.frame(
  Pollito,
  Alimento = factor(chickwts[["feed"]]),
  Peso = chickwts[["weight"]]
)


# Una primera aproximación es comparar los grupos con una gráfico de
# cajas.
p1 <- ggboxplot(
  datos.long,
  x = "Alimento", y = "Peso",
  fill = "Alimento"
)
print(p1)

# En general, parece haber alimentos que otorgan mayor peso que otros


# ----------------------------------------------------
# Hipótesis
# ----------------------------------------------------

# ¿Cuáles serían las hipótesis en este caso? 
# Usemos las definiciones en la sección 5.5 de OpenIntro Statistics:
# H0: The mean outcome is the same across all groups.
# HA: At least one mean is different.
# 
# Luego, en este caso:
# H0: El peso medio conseguido por cada tipo de alimento es el mismo
#     (μ_casein = μ_horsebean = μ_linseed = μ_meatmeal = μ_soybean = μ_sunflower)
# HA: Al menos un alimento genera un peso medio diferente
# 


# ----------------------------------------------------
# Verificaciones
# ----------------------------------------------------

# Estas se explican en el capítulo 14 de VarssarStats:
# 1. La variable dependiente tiene escala de intervalo
# 2. Las muestras son independientes y obtenidas aleatoriamente
# 3. Se puede asumir que las poblaciones son aproximadamente normales
# 4. Las muestras tienen varianzas similares

# La condición 1 se verifica, puesto que 100 g, por ejemplo, es el doble
# de 50 g y la mitad de 200 g.

# La condición 2 se verifica en la descripción del conjunto de datos:
#      "Newly hatched chicks were randomly allocated into six groups,
#       and each group was given a different feed supplement.
#       Their weights in grams after six weeks are given along with
#       feed types."

# Para la condición 3, podemos usar un gráfico QQ
p2 <- ggqqplot(
  datos.long,
  x = "Peso",
  color = "Alimento"
)
p2 <- p2 + facet_wrap(~ Alimento)
print(p2)

# Podemos ver que este gráfico confirma lo detectado por el gráfico de
# caja: hay un comportamiento aproximadamente normal en 5 de los 6 grupos,
# pero se observan valores atípicos en los pesos registrados por pollitos
# alimentados con girasol. 

# Ante la duda, y porque las muestras son pequeñas, podríamos confirmar
# aplicando alguna prueba de normalidad apropiada para este tamaño, como
# la prueba de Shapiro-Wilk.
# [A Ghasemi, S Zahediasl (2012). Normality tests for statistical
# analysis: a guide for non-statisticians. International journal of
# endocrinology and metabolism, 10(2), 486-9].

spl <- by(
  data = datos.long[["Peso"]],
  INDICES = datos.long[["Alimento"]],
  FUN = shapiro.test
)
cat("\n\n")
cat("Pruebas de normalidad en cada grupo\n")
cat("-----------------------------------\n")
cat("\n")
print(spl)

# Como sospechamos, con muestras tan pequeñas, los valores atípicos
# observados no acumulan suficiente evidencia para descartar que los
# datos no vienen de poblaciones normales.

# Falta entonces la condición 4.
# El diagrama de cajas sugiere que hay alimentos que hay un par de alimentos
# que parecen concentrar más los pesos de los pollitos.
vars <- by(
  data = datos.long[["Peso"]],
  INDICES = datos.long[["Alimento"]],
  FUN = var
)
cat("\n\n")
cat("Varianza en cada grupo\n")
cat("----------------------\n")
print(vars)
cat("\n")


# Parece haber diferencias considerables.
# Podemos confirmar aplicando una prueba de homocedasticidad
# (o homogeneidad de varianzas). En general, se recomienda la prueba de
# Levene.
# [Ver por ejemplo, www.johndcook.com/blog/2018/05/16/f-bartlett-levene/]

library(car)

lts <- leveneTest(Peso ~ Alimento, datos.long)
cat("\n\n")
cat("Pruebas de homocedasticidad\n")
cat("---------------------------\n")
cat("\n")
print(lts)


# Vemos que no hay razones para creer que hay problemas con la varianza.
# Probablemente el reducido tamaño de las muestras no permiten acumular
# evidencia suficiente.
# Luego, podemos continuar con al análisis.


# ----------------------------------------------------
# Usando las funciones del paquete ez
# ----------------------------------------------------

# Recordar que la función ezANOVA() no acepta nombres de las columnas
# en variables de texto. Lo escribimos "en duro".
ez.aov <- ezANOVA(
  data = datos.long, 
  dv = Peso,
  wid = Pollito,
  between = Alimento,
  type = 3,
  return_aov = TRUE
)

# Damos formato a la tabla ANOVA de acuerdo a los estándares para
# reportar estadísticas (basado en APA). También agregamos tamaño del
# efecto.
tabla.aov <- summary(ez.aov[["aov"]])[[1]]
tabla.aov[1, "Pr(>F)"] <- sub(
  pattern = "0.",
  replacement = ".",
  x = sprintf("%1.3f", tabla.aov[1, "Pr(>F)"])
)
tabla.aov <- cbind(tabla.aov, GES = c(ez.aov[["ANOVA"]][["ges"]], NA))
options(knitr.kable.NA = '')
kt <- kable(
  tabla.aov,
  format = "pandoc"
  # format.args = list(zero.print = FALSE)
)

cat("\n\n")
cat("Tabla ANOVA \n")
cat("------------")
print(kt)
cat("\n\n")


# Podemos el el resultado gráficamente.
ezp <- ezPlot(
  data = datos.long,
  dv = Peso,
  wid = Pollito,
  between = Alimento,
  type = 3,
  x = Alimento
)
print(ezp)


# ----------------------------------------------------
# Análisis post-hoc
# ----------------------------------------------------

# Usemos la implementación disponible para el método de Tukey.
# Dejemos el nivel de confianza por defecto, 95%.
mt <- TukeyHSD(ez.aov[["aov"]])
cat("\n\n")
cat("Comparaciones múltiples entre los grupos:\n")
cat("-----------------------------------------\n")
print(mt)

# Y veamos gráficamente esta comparación
plot(mt, las = 1)

# Podemos usar cambios en el gráfico para verlo mejor
# (¡muchas comparaciones múltiples!)
psig <- as.numeric(apply(mt[["Alimento"]][, 2:3], 1 , prod) >= 0 ) + 1
op <- par(mar = c(4.2, 9, 3.8, 2))
plot(mt, col = psig, yaxt = "n")
for(j in 1:length(psig)){
  axis(2, at=j, labels = rownames(mt[["Alimento"]])[length(psig) - j + 1],
       las = 1, cex.axis = .8, col.axis = psig[length(psig) - j + 1])
}
par(op)

# Nota: código copiado de foros de R. Por eso ¡aparece un ciclo!
# Este es el modo antiguo de cambiar gráficos, antes de ggplot2 y ggpubr.
# ¿Habría que buscar una forma de hacer eso con estos nuevos paquetes?

# ----------------------------------------------------
# ¿Qué interpretamos?
# ----------------------------------------------------

# Vemos que los pollitos alimentados con caseína consiguen un peso medio
# significativamente mayor que con habas, linaza, soya.
# Exactamente lo mismo ocurre con el girasol.
# Por último, los pollitos alimentados con habas obtienen un peso medio
# significativamente más bajo, además, que con harina de carne y soya.

