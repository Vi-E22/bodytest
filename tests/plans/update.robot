*** Settings ***
Documentation       Atualizar planos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         Start Admin Session
Test Teardown       Take Screenshot

*** Test Case ***
Cenário: Atualizar um plano ja cadastrado

    ${fixture}      Get JSON        plans-update.json

    ${premium1}     Set Variable    ${fixture['before']}
    ${premium2}     Set Variable    ${fixture['after']}

    Remove Plan By Title            ${premium1['title']}  
    Remove Plan By Title            ${premium2['title']}       

    Insert Plan                     ${premium1}
    Go To Plans
    Search Plan By Title            ${premium1['title']} 
    Go To Plan Update Form          ${premium1['title']} 
    Update A Plan                   ${premium2}
    Toaster Should Be               Plano atualizado com sucesso  

    [Teardown]                  Thinking And Take Screenshot    2