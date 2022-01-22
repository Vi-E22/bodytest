*** Settings ***
Documentation       Ações de autorização


*** Keywords ***
Go To Login Page
    Go to           https://bodytest-web-victoria.herokuapp.com/

Login With  
    [Arguments]     ${email}    ${pass}

    Fill Text       css=input[name=email]            ${email}
    Fill Text       css=input[name=password]    ${pass}
    Click           text=Entrar

