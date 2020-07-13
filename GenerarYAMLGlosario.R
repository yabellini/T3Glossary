# Script para general el YAML para el glosario
# Formato del YAML
# 
# - slug: plus_one
# en:
#   term: "+1"
# def: >
#   A vote in favor of something.
# es:
#   term: "+1"
# def: >
#   Un voto a favor de alguna cosa.

library(tidyverse)
library(readxl)
GlosarioT3 <- read_excel("files/GlosarioT3.xlsx")


file.create("glossaryT3.yml")

glosario<-file("glossaryT3.yml")

# Creo el ID

GlosarioT3 <- GlosarioT3 %>%
  mutate(slug_en = str_replace_all(GlosarioT3$en, " ", "_"),
         slug_es = str_replace_all(GlosarioT3$es, " ", "_"))
  


# Armado del YAML


