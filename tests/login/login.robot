*** Settings ***
Documentation       Suite de testes de Login do Administrador

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         Start Browser Session
Test Teardown       Take Screenshot

*** Test Case ***
Cenário: Login do Administrador
    [tags]          admin
    Go To Login Page
    Login With                  admin@bodytest.com      pwd123         
    User Should Be Logged In    Administrador

    [Teardown]                  Clear LS And Take Screenshot

Cenário: Senha incorreta
    Go To Login Page
    Login With                  admin@bodytest.com      abc123     
    Toaster Should Be           Usuário e/ou senha inválido

    [Teardown]                  Thinking And Take Screenshot    2

Cenário: Email não cadastrado 
    Go To Login Page
    Login With                  vivi@gmail.com      abc123     
    Toaster Should Be           Usuário e/ou senha inválido

    [Teardown]                  Thinking And Take Screenshot    2

Cenário: Email incorreto
    Go To Login Page
    Login With                  admin&bodytest.com      pwd123     
    Alert Text Should Be        Informe um e-mail válido

Cenário: Senha não informada
    Go To Login Page
    Login With                  admin@bodytest.com      ${EMPTY}     
    Alert Text Should Be        A senha é obrigatória    

Cenário: Email não informado
    Go To Login Page
    Login With                  ${EMPTY}      pwd123
    Alert Text Should Be        O e-mail é obrigatório     

Cenário: Email e Senha não informados
    Go To Login Page
    Login With                  ${EMPTY}      ${EMPTY} 
    Alert Text Should Be        O e-mail é obrigatório     
    Alert Text Should Be        A senha é obrigatória 