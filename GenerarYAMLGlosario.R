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

glosario<-file("glossaryT3.yml",encoding = "UTF-8")

# Creo el ID

GlosarioT3 <- GlosarioT3 %>%
  mutate(slug = str_replace_all(term_en, " ", "_"),
         slug = str_replace_all(slug, "'", "_"))
  

# Armado del YAML

# Terminos con acrónimos

yamlacronym <- GlosarioT3 %>%
  # tiene acronimos pero no tiene referencias
  filter(!is.na(acronym) & is.na(ref_en_a)) %>%
  str_glue_data('- slug: {slug} \n en:\n    term: "{term_en}" \n    acronym: {acronym}\n    def: > \n {def_en} \n es:\n    term: "{term_es}" \n    acronym: {acronym}\n    def: > \n {def_es}\n')

yamlacronymref <- GlosarioT3 %>%
  # tiene acronimos pero tiene referencias
  filter(!is.na(acronym) & !is.na(ref_en_a)) %>%
  str_glue_data('- slug: {slug} \n en:\n    term: "{term_en}" \n    acronym: {acronym}\n    def: > \n {def_en} \n    ref: \n     - {ref_en_a}\n {ifelse(!is.na(ref_en_b),"    - {ref_en_b}\n","")} es:\n    term: "{term_es}" \n    acronym: {acronym}\n    def: > \n {def_es}\n')

  
yamlref <- GlosarioT3 %>%
  # tiene referencias y not tiene acrónimos
  filter(!is.na(ref_en_a) & is.na(acronym)) %>%
  str_glue_data('- slug: {slug} \n en:\n    term: "{term_en}" \n    def: > \n {def_en} \n    ref: \n     - {ref_en_a}\n {ifelse(!is.na(ref_en_b),paste0("    - ", {ref_en_b}, "\n"),"")} es:\n    term: "{term_es}" \n        def: > \n {def_es}\n    ref: \n     - {ref_es_a}\n {ifelse(!is.na(ref_es_b),paste0("    - ", {ref_es_b}, "\n"),"")}')
  
yamldef <- GlosarioT3 %>%
  filter(is.na(acronym) & is.na(ref_en_a)) %>%
  #Solo tiene definición
  str_glue_data('- slug: {slug} \n en:\n    term: "{term_en}" \n    def: > \n {def_en} \n es:\n    term: "{term_es}" \n    def: > \n {def_es}\n')

writeLines(yamlacronym,glosario)

writeLines(yamlacronymref,glosario)

writeLines(yamldef,glosario)

writeLines(yamlref,glosario)

close(glosario)
