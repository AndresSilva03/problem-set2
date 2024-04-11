#===========================================#
# author: Andrés Felipe Silva Galvis
# update: 11/04/2024
#===========================================#

## initial configuration
rm(list=ls()) # limpiar entorno

## load packages
require(pacman)

## usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(tidyverse, # funciones para manipular/limpiar conjuntos de datos.
       rio, # función import/export: permite leer/escribir archivos desde diferentes formatos. 
       skimr, # función skim: describe un conjunto de datos
       janitor, # función tabyl: frecuencias relativas
       data.table
)


#1. Importar/Exportar bases de datos:


setwd("C:/Users/silva/OneDrive/Escritorio/Penúltimo Semestre/Taller de R/problemset2")

location <- import("Módulo de identificación.dta")

identification <- import("Módulo de sitio o ubicación.dta")

write_rds(location,file = )

help(export)