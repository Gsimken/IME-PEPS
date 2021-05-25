##########################################################
# Fragmento de código proporcionado por Nicolás Gutiérrez


# Seteo de la dirección de Rstudio en la carpeta donde se ha habierto
# main.r
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(dirstudio) 


### Importar funciones o archivos existintes en otro .r
if(!exists("exito", mode="function")) source("archivo.r")


exito()
##########################################################



