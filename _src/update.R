library(rmarkdown)

estados.para.atualizar <- c('SP', 'RJ')

source('prepara_dados.R')
source('ajuste_projecao_exponencial.R')
source('plots.R')


ncasos.completa.d <- data.frame(ncasos.completa)
ncasos.completa.d <- rownames_to_column(ncasos.completa.d, var = "data")
## Como transformar o nome da linha em uma coluna a mais com regex???
## dar append na data
colnames(ncasos.completa.d) = c("Data", "casos", "predito", "ic.low", "ic.upp")
## Escreve o csv
write.csv(ncasos.completa.D, file = "/path/teste.csv", sep = ";", row.names = FALSE)

sigla.estado <- c(AC="Acre", AL="Alagoas", AP="Amapá", AM="Amazonas",
                  BA="Bahia", CE="Ceará", DF="Distrito Federal", ES="Espírito Santo",
                  GO="Goiás", MA="Maranhão", MT="Mato Grosso",
                  MS="Mato Grosso do Sul", MG="Minas Gerais", PA="Pará", PB="Paraíba",
                  PR="Paraná", PE="Pernambuco", PI="Piauí", RJ="Rio de Janeiro",
                  RN="Rio Grande do Norte", RS="Rio Grande do Sul",
                  RO="Rondônia", RR="Roraima", SC="Santa Catarina",
                  SP="São Paulo", SE="Sergipe", TO="Tocantins")

static_pages <- c('sobre.md', 'fontes.md', 'midia.md')
dynamic_pages <- c('index.Rmd', 'informacoes.Rmd', 'projecao.Rmd', 'pais.Rmd',
                   'dinamica.Rmd')
# 'propagacao.Rmd', 'transmissao.Rmd'
# 'casos.Rmd', 
all_pages <- c(static_pages, dynamic_pages)

for (f in dynamic_pages){
    rmarkdown::render(f, output_dir='../')
}

for (st in estados.para.atualizar){
    rmarkdown::render('estado.Rmd', output_dir='../',
                      output_file=paste0('../', st, '.html'))
}
