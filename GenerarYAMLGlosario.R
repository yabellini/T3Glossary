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
GlosarioT3 <- read_excel("files/GlosarioT3.xlsx", 
                         sheet = "Lexicon")


glosario<-file("glossaryT3.yml",encoding = "UTF-8")

# Creo el ID

GlosarioT3 <- GlosarioT3 %>%
  mutate(slug = str_replace_all(term_en, " ", "_"),
         slug = str_replace_all(slug, "'", "_"),
         slug = str_replace_all(slug, "-", "_"))
  

# Armado del YAML

# Terminos con acrónimos

yamlacronym <- GlosarioT3 %>%
  # tiene acronimos pero no tiene referencias
  filter(!is.na(acronym) & is.na(ref_en_a)) %>%
  str_glue_data('
- slug: {slug}
  en:
    term: "{term_en}"
    acronym: {acronym}
    def: > 
     {def_en}
  es:
    term: "{term_es}"
    acronym: {acronym}
    def: >
     {def_es}
\n')

yamlacronymref <- GlosarioT3 %>%
  # tiene acronimos pero tiene referencias
  filter(!is.na(acronym) & !is.na(ref_en_a)) %>%
  str_glue_data('
- slug: {slug} 
  en:
    term: "{term_en}" 
    acronym: {acronym}    
    def: > 
     {def_en} 
    ref:      
      - {ref_en_a}{ifelse(!is.na(ref_en_b),paste0("\n      - ", {ref_en_b}),"")}
  es:    
    term: "{term_es}" 
    acronym: {acronym}    
    def: > 
     {def_es}
    ref: 
      - {ref_es_a}
      {ifelse(!is.na(ref_es_b),paste0("- ", {ref_es_b}"),"")}\n
')

  
yamlref <- GlosarioT3 %>%
  # tiene referencias y no tiene acrónimos
  filter(!is.na(ref_en_a) & is.na(acronym)) %>%
  str_glue_data('
- slug: {slug}
  en:
    term: "{term_en}"
    def: >
     {def_en}
    ref:
      - {ref_en_a}{ifelse(!is.na(ref_en_b),paste0("\n      - ", {ref_en_b}),"")}  
  es:
    term: "{term_es}"
    def: >
     {def_es}
    ref:
     - {ref_es_a}{ifelse(!is.na(ref_es_b),paste0("\n     - ", {ref_es_b}),"")}\n
')

yamldef <- GlosarioT3 %>%
  filter(is.na(acronym) & is.na(ref_en_a)) %>%
  #Solo tiene definición
  str_glue_data('
- slug: {slug}
  en:
    term: "{term_en}"
    def: >
     {def_en}
  es:
    term: "{term_es}"
    def: >
     {def_es}\n
')

yaml <- c(yamlacronym, yamlacronymref, yamldef, yamlref)

writeLines(yaml,glosario)

close(glosario)
