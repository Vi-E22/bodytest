*** Settings ***
Documentation       Remover Planos

Resource            ${EXECDIR}/resources/base.robot

Test Setup         Start Admin Session
Test Teardown      Take Screenshot

*** Test Case ***
Cenário: Remover plano cadastrado
    
    &{plan}     Create Dictionary       title=Body Builder ll     duration=12     price=99     total=R$ 1.188,00

    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Title            ${plan.title}
    Request Removal By Title        ${plan.title}      
    Confirm Removal
    Toaster Should Be               Plano Removido com sucesso  
    Student Should Not Visible      ${plan.title} 
    
    [Teardown]                  Thinking And Take Screenshot    2 

Cenário: Desistir da exclusão

    &{plan}     Create Dictionary       title=Body Builder l     duration=12     price=79     total=R$ 948,00

    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Title            ${plan.title}
    Request Removal By Title        ${plan.title} 
    Cancel Removal   
    Plan Title Should Be Visible    ${plan.title}