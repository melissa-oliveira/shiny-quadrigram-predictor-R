#!/bin/bash

echo "Executando RF_model_generator.R para gerar o modelo..."
Rscript ./RF_model_generator.R

if [ $? -ne 0 ]; then
  echo "Erro ao gerar o modelo. Verifique o script RF_model_generator.R."
  exit 1
fi

echo "Modelo gerado com sucesso!"
