# script projeção PNLD
# Allan Vieira
# allan.quadros@fnde.gov.br
# -----------------------
# extract_and_clean_censo_full v0.0.6
# 2020-06-22
# ------------------------

extract_and_clean_censo_full <- function(tb_censo) {
  
  
  tb_censo_full <- tb_censo %>%
    dplyr::select(NU_ANO_CENSO, 
                  # SG_UF, 
                  CO_MUNICIPIO, 
                  # NO_MUNICIPIO, 
                  CO_ENTIDADE, CO_ETAPA_ENSINO, QTD_ALUNOS) %>%
    dplyr::mutate(NU_ANO_CENSO = to_date(NU_ANO_CENSO, "YYYY")) %>%
    dplyr::collect()
  
  # QUAL O PACOTE DA to_date ????
  
  # obtem ano do ultimo censo
  ano_ult_censo <- tb_censo_full %>% # import magrittr pro namespace
    dplyr::summarise(max(lubridate::year(NU_ANO_CENSO))) %>%
    unlist()
  
  # eliminar quem nao possui ano de 2019 na base original:
  coluna_entidades_com_ult_censo <- tb_censo_full %>%
    dplyr::filter(lubridate::year(NU_ANO_CENSO) == ano_ult_censo) %>%
    # dplyr::filter(NU_ANO_CENSO == ano_ult_censo) %>%
    dplyr::select(CO_ENTIDADE, CO_ETAPA_ENSINO) %>%
    dplyr::distinct() %>%
    dplyr::collect()
  
  
  tb_censo_full <- tb_censo_full %>% dplyr::inner_join(coluna_entidades_com_ult_censo, 
                                                       by=c("CO_ENTIDADE", "CO_ETAPA_ENSINO"))
  
  # # criando unidades de analise por mun/entidade/etapa
  # # vai otimizar o processo de projecao
  # tb_censo_full <- tb_censo_full %>%
  #   # mutate(CO_ENTIDADE = as.integer(CO_ENTIDADE)) %>%
  #   mutate(cod_unico = as.integer(
  #     as.numeric(factor(paste0(CO_MUNICIPIO, CO_ENTIDADE, CO_ETAPA_ENSINO))))
  #     ) # ao transformar em fator, diferenciamos pelos levels
  
  # esse metodo de cima seria bom se o split do proximo passo nao ficasse
  # tao lento com mais de um milhao de grupos
  # mesmo com data.table leva uma eternidade
  
  
  rm(tb_censo)
  
  return(tb_censo_full)
  
  
}
