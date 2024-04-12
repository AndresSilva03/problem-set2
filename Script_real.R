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

identification <- import("Módulo de identificación.dta")
location <- import("Módulo de sitio o ubicación.dta")


# 1.2)

#help(export)
export(identification,"output/identification.rds")
export(location, "output/location.rds")


#=========== 2. Generar variables ============#

# 2.1)

identification <-  mutate(identification, businesstype = case_when(GRUPOS4 == "01" ~ "Agricultura",
                                                          GRUPOS4 == "02" ~ "Industria Manufaturera",
                                                          GRUPOS4 == "03" ~ "Comercio",
                                                          GRUPOS4 == "04" ~ "Servicios"))
  
  

  
# 2.2) 

#P241 es edad según el diccionario

#Dividí los grupos etarios según la clasificacion que da el ministerio de salud
#en su página minsalud.gov.co, todos los grupos etarios menores de 18 años
#los agrupe en uno único para quedar con el requisito de 4 grup. etarios.

identification <- mutate(identification, grupo_etario = case_when(P241<18 ~ "Menores_de_edad",
                                                                  P241>=18 & P241<=26  ~ "Jovenes",
                                                                  P241>26 & P241<=59 ~ "Adultos",
                                                                  P241>60 ~ "Adulto_Mayor"))  

# 2.3) 

location <- mutate(location, ambulante = case_when( P3053 == 3 |
                                                    P3053 == 4 |
                                                    P3053 == 5 ~ 1)) #el enunciado no dice que 
# hacer con el resto de valores que toma P3053

#help(mutate)


#=========== 3. Eliminar filas/columnas de un conjunto de datos ============#


# 3.1)


identification$ambulante <- location$ambulante #Como ambulante se encuentra en location
#creamos la variabel en identification para poder usarla en el select.


vars_id <- c("DIRECTORIO","SECUENCIA_P", "SECUENCIA_ENCUESTA",
         "grupo_etario","ambulante","COD_DEPTO","F_EXP")
#help(c)

identification_sub <- select(.data = identification, 
                             all_of(vars_id))


# 3.2) 

vars_loc <- c("DIRECTORIO","SECUENCIA_P", "SECUENCIA_ENCUESTA",
              "ambulante","P3054","COD_DEPTO", "F_EXP")

location_sub <- select(.data = location, all_of(vars_loc))


#============== 4. Combinar bases de datos ===========#


# 4.1 Use las variables DIRECTORIO, SECUENCIA_P y SECUENCIA_ENCUESTA para unir en una única base
#de datos, los objetos location_sub y identification_sub.

base_unica <- left_join(location_sub, 
                        identification_sub, 
                        by = c( "DIRECTORIO", "SECUENCIA_P",
                                "SECUENCIA_ENCUESTA" ))


#================ 5. Descriptivas ====================#



#5.1) 



skim(data = base_unica)
help(skim)

summary(base_unica)



#5.2






