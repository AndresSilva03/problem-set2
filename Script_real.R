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


# ======= 1. Importar/Exportar bases de datos =========#


# 1.1)

location <- import("Módulo de identificación.dta")
identification <- import("Módulo de sitio o ubicación.dta")


# 1.2)

#help(export)
export(location,"output/location.rds")
export(identification, "output/identification.rds")


#=========== 2. Generar variables ============#

# 2.1)

location <-  mutate(location, businesstype = case_when(GRUPOS4 == "01" ~ "Agricultura",
                                                       GRUPOS4 == "02" ~ "Industria_Manufaturera",
                                                       GRUPOS4 == "03" ~ "Comercio",
                                                       GRUPOS4 == "04" ~ "Servicios"))
  
  

  
# 2.2) 

#P241 es edad según el diccionario

#Dividí los grupos etarios según la clasificación que da el ministerio de salud
#en su página minsalud.gov.co
location <- mutate(location, grupo_etario = case_when(P241<=26 ~ "Jovenes",
                                                      P241>26 & P241<=59 ~ "Adultos",
                                                      P241>60 ~ "Adulto_Mayor"))  

# 2.3) 

