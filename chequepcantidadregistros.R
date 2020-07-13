
acronimos <- GlosarioT3 %>%
  # tiene acronimos pero no tiene referencias
  filter(!is.na(acronym) & is.na(ref_en_a))

acronimosref <- GlosarioT3 %>%
  # tiene acronimos pero tiene referencias
  filter(!is.na(acronym) & !is.na(ref_en_a))

referencias <- GlosarioT3 %>%
  # tiene referencias
  filter(!is.na(ref_en_a) & is.na(acronym))

definiciones <- GlosarioT3 %>%
  filter(is.na(acronym) & is.na(ref_en_a))
