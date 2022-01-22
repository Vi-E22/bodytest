*** Settings ***
Documentation       Cadastro de alunos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         Start Admin Session
Test Teardown       Take Screenshot

*** Test Case ***
Cenário: Novo aluno

    &{student}      Create Dictionary   name=Victória Ester      email=victoria@gmail.com      age=19      weight=55      feet_tall=1.66        

    Remove Student              ${student.email}
    Go To Students
    Go To Form Student
    New Student                 ${student}
    Toaster Should Be           Aluno cadastrado com sucesso.

    [Teardown]                  Thinking And Take Screenshot    2

Cenário: Não deve permitir email duplicado


    &{student}      Create Dictionary   name=Gunther Mignon      email=gunther@gmail.com      age=22      weight=82      feet_tall=1.90        

    Insert Student              ${student}
    Go To Students
    Go To Form Student
    New Student                 ${student}
    Toaster Should Be           Email já existe no sistema.

    [Teardown]                  Thinking And Take Screenshot    2

Cenário: Todos os campos devem ser obrigatórios
    @{expected_alerts}          Set Variable    Nome é obrigatório      O e-mail é obrigatório      idade é obrigatória     o peso é obrigatório    a Altura é obrigatória
    @{got_alerts}               Create List       

    Go To Students
    Go To Form Student
    Submit Form      

    FOR     ${index}        IN RANGE    1   6
        ${span}             Get Required Alerts         ${index}
        Append To List      ${got_alerts}               ${span}
    END

    Log     ${expected_alerts}  
    Log     ${got_alerts}

    Lists Should Be Equal       ${expected_alerts}      ${got_alerts}

Cenário: Validação dos campos numéricos 

    [Template]      Check Type Field On Student Form 
    ${AGE_FIELD}             number
    ${WEIGHT_FIELD}          number
    ${FEET_TALL_FIELD}       number

Cenário: Validar campo do tipo email 

    [Template]      Check Type Field On Student Form 
    ${EMAIL_FIELD}           email

Cenário: Menor de 14 anos não pode fazer cadastro 

    &{student}      Create Dictionary   name=Aurora      email=aurora@gmail.com      age=13      weight=50      feet_tall=1.60        

    Go To Students
    Go To Form Student
    New Student     ${student}
    Alert Text Should Be            A idade deve ser maior ou igual 14 anos

