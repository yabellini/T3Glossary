# Código original
# yamlacronymref <- GlosarioT3 %>%
#   # tiene acronimos pero tiene referencias
#   filter(!is.na(acronym) & !is.na(ref_en_a)) %>%
#   str_glue_data('- slug: {slug} \n  en:\n    term: "{term_en}" \n    acronym: {acronym}\n    def: > \n      {def_en} \n    ref: \n     - {ref_en_a}\n {ifelse(!is.na(ref_en_b),paste0("    - ", {ref_en_b}, "\n"),"")}  es:\n    term: "{term_es}" \n    acronym: {acronym}\n    def: > \n      {def_es}\n    ref: \n     - {ref_es_a}\n {ifelse(!is.na(ref_es_b),paste0("    - ", {ref_es_b}, "\n"),"")}\n')


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

# Código original
# yamlacronym <- GlosarioT3 %>%
#   # tiene acronimos pero no tiene referencias
#   filter(!is.na(acronym) & is.na(ref_en_a)) %>%
#   str_glue_data('- slug: {slug} \n  en:\n    term: "{term_en}" \n    acronym: {acronym}\n    def: > \n      {def_en} \n  es:\n    term: "{term_es}" \n    acronym: {acronym}\n    def: >       \n      {def_es}\n\n')

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


#Codigo original
# yamlref <- GlosarioT3 %>%
#   # tiene referencias y no tiene acrónimos
#   filter(!is.na(ref_en_a) & is.na(acronym)) %>%
#   str_glue_data('- slug: {slug} \n  en:\n    term: "{term_en}" \n    def: > \n      {def_en} \n    ref: \n     - {ref_en_a}\n {ifelse(!is.na(ref_en_b),paste0("    - ", {ref_en_b}, "\n"),"")}  es:\n    term: "{term_es}" \n        def: > \n      {def_es}\n    ref: \n     - {ref_es_a}\n {ifelse(!is.na(ref_es_b),paste0("    - ", {ref_es_b}, "\n"),"")}\n')

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

#Codigo original
# yamldef <- GlosarioT3 %>%
#   filter(is.na(acronym) & is.na(ref_en_a)) %>%
#   #Solo tiene definición
#   str_glue_data('- slug: {slug} \n  en:\n    term: "{term_en}" \n    def: > \n      {def_en} \n  es:\n    term: "{term_es}" \n    def: > \n     {def_es}\n\n')


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

