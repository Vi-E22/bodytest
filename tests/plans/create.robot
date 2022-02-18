*** Settings ***
Documentation       Cadastro de planos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         Start Admin Session
Test Teardown       Take Screenshot

*** Test Case ***
Cenário: Calcular preço total do plano 

    &{plan}     Create Dictionary       title=Vi Teste      duration=12     price=19,99     total=R$ 239,88

    Go To Plans
    Go To Form Plan
    Fill Plan Form          ${plan}    
    Total Plan Should Be    ${plan.total}  

Cenário: Novo Plano
    
    &{plan}     Create Dictionary       title=Body Builder      duration=12     price=59,99     total=R$ 719,88

    Go To Plans
    Go To Form Plan
    Fill Plan Form          ${plan}    
    Total Plan Should Be    ${plan.total}  
    Submit Form 
    Toaster Should Be       Plano cadastrado com sucesso

    [Teardown]                  Thinking And Take Screenshot    2

Cenário: Todos os campos devem ser obrigatórios
    ## Nesse teste ele falha, pois "O preço é obrigatório só aparece quando você deleta manualmente o campo vazio, ou seja é realmente um bug"

    @{expected_alerts}          Set Variable    Informe o título do plano      Informe a duração do plano em meses      O preço é obrigatório
    @{got_alerts}               Create List       

    Go To Plans
    Go To Form Plan
    Submit Form     

    FOR     ${index}        IN RANGE        1   4   
        ${span}             Get Required Alerts         ${index}
        Append To List      ${got_alerts}               ${span}
    END

    Log     ${expected_alerts}  
    Log     ${got_alerts}

    Lists Should Be Equal       ${expected_alerts}      ${got_alerts}
