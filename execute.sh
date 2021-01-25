#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`


echo "${green}Verificando pacotes docker${reset}"
docker-compose up -d  --build || { echo "${red}O Docker falhou. Confira se você executou como sudo e está na mesma pasta do docker-compose.yml" ; exit 1; }
echo "${green}AGUARDANDO INICIALIZAÇÂO DO BANCO${reset}"
sleep 5

file="transacoes.sql" 
echo "${yellow} Executando query de transações: uantidade total de transações realizadas e total de valor transacionado em 2019 (mês a mês), por estado, tipo de cliente (pj e pf) e modelo de POS;${reset}"
echo "file: $file"
echo "${yellow}"
docker exec testpb_database_1 mysql -uroot -psenhateste -e "use pagbank; $(cat ./$file)"
echo "${reset}"

echo "===================================================================================================================================================================="
sleep 2


file="clientes.sql" 
echo "${yellow} Executando query de mudanças de endereço de cliente: Lista de clientes PJ que mudaram de endereço em Dez/19 por estado.${reset}"
echo "file: $file"
echo "${yellow}"
docker exec testpb_database_1 mysql -uroot -psenhateste -e "use pagbank; $(cat ./$file)"

echo "${reset}"
docker-compose down || { echo "${red}O Docker falhou, confira se você está na mesma pasta do docker-compose.yml" ; exit 1; }
echo ":)"
