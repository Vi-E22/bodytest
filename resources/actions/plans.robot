*** Settings ***
Documentation           Ações da feature de gestão de planos

*** Variables ***
${TITLE_FIELD}          id=title
${DURATION_FIELD}       id=duration
${PRICE_FIELD}          css=input[name=price]
${TOTAL_FIELD}          css=input[name=total]

*** Keywords ***
## Forms
Fill Plan Form
    [Arguments]                 ${plan} 

    Fill Text                   ${TITLE_FIELD}         ${plan.title}
    Fill Text                   ${DURATION_FIELD}      ${plan.duration}
    Fill Text                   ${PRICE_FIELD}         ${plan.price}

Search Plan By Title 
    [Arguments]     ${title}

    Fill Text       css=input[placeholder="Buscar plano"]       ${title}

Update A Plan
    [Arguments]                 ${plan} 

    Fill Text                   ${TITLE_FIELD}        ${plan['title']}
    Fill Text                   ${DURATION_FIELD}     ${plan['duration']}
    Fill Text                   ${PRICE_FIELD}        ${plan['price']}
    Submit Form 

## Links & Buttons   
Go To Form Plan
    Set Strict Mode              false
    Click                        css=a[href$="planos/new"]
    Wait For Elements State      css=h1 >> text=Novo Plano     visible     5

Go To Plan Update Form
    [Arguments]         ${title}

    Click                        xpath=//td[contains(text(), "${title}")]/..//a[@class="edit"]  
    Wait For Elements State      css=h1 >> text=Edição de plano     visible     5  

Request Removal By Title
    [Arguments]                 ${title}
    Click                       xpath=//td[contains(text(), "${title}")]/../td//button[@id="trash"]

## Vaidations
Total Plan Should Be
    [Arguments]     ${total}

    Get Attribute        ${TOTAL_FIELD}      value       ==      ${total}

Plan Should Not Visible
    [Arguments]                 ${title}

    Wait For Elements State     xpath=//td[contains(text(), "${title}")]    detached    5

Plan Title Should Be Visible 
    [Arguments]                 ${title}

    Wait For Elements State     css=table tbody tr >> text=${title}      visible     5