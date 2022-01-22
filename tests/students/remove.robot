*** Settings ***
Documentation       Remover Alunos

Resource            ${EXECDIR}/resources/base.robot

Test Setup         Start Admin Session
Test Teardown      Take Screenshot

*** Test Case ***
Cenário: Remover aluno cadastrado

    &{student}      Create Dictionary   name=Robert Pattinson      email=batman@dc.com      age=27      weight=70      feet_tall=1.80

    Insert Student                  ${student}
    Go To Students
    Search Student By Name          ${student.name}
    Request Removal By Email        ${student.email}      
    Confirm Removal
    Toaster Should Be               Aluno Removido com sucesso.  
    Student Should Not Visible      ${student.email} 
    
    [Teardown]                  Thinking And Take Screenshot    2 

Cenário: Desistir da exclusão

    &{student}      Create Dictionary   name=Robert Downey Jr      email=ironman@marvel.com      age=56      weight=80      feet_tall=1.74

    Insert Student                  ${student}
    Go To Students
    Search Student By Name          ${student.name}
    Request Removal By Email        ${student.email} 
    Cancel Removal   
    Student Should Be Visible       ${student.email}

