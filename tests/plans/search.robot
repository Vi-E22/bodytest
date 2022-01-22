*** Settings ***
Documentation       Buscar alunos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         Start Admin Session
Test Teardown       Take Screenshot

*** Test Case ***
Cenário: Busca exata

    &{plan}     Create Dictionary       title=Basic      duration=6     price=29     total=R$ 174,00

    Remove Plan By Title                ${plan.title}
    Insert Plan                         ${plan}
    Go To Plans
    Search Plan By Title                ${plan.title}
    Plan Title Should Be Visible        ${plan.title}
    Total Items Should Be               1

Cenário: Registro não encontrado

    ${title}     Set Variable           Meta de Ano Novo

    Remove Plan By Title                ${title}
    Go To Plans
    Search Plan By Title                ${title}
    Register Should Not Be Found
