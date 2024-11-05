*** Settings ***
Resource       ../../global/settings.robot

*** Keywords ***
Feegow Rest API - New Appoint
    [Documentation]    New appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${CONNECTOR_API_TOKEN} 
    Log To Console    ${feegowAPI_booking}
    ${response}=    POST On Session    feegow-rest-api     /appoints/new-appoint    json=${feegowAPI_booking}      headers=&{headers}
    ${newAppoint_id}=        Get Value From Json     ${response.json()}    content.agendamento_id
    Set Suite Variable    ${newAppoint_id}

Feegow Rest API - Reschedule appoint
    [Documentation]    Reschedule appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${CONNECTOR_API_TOKEN} 
    Log To Console    ${feegowAPI_booking}
    ${response}=    POST On Session    feegow-rest-api     /appoints/reschedule    json=    headers=&{headers}

Feegow Rest API - Delete appoint
    [Documentation]    Delete appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${CONNECTOR_API_TOKEN} 
    Log To Console    ${feegowAPI_booking}
    ${response}=    POST On Session    feegow-rest-api     /appoints/cancel-appoint    json=    headers=&{headers}