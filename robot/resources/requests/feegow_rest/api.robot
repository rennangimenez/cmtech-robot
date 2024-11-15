*** Settings ***
Resource       ../../global/settings.robot

*** Keywords ***
Feegow Rest API - New Appoint
    [Documentation]    New appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API_URL}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${FEEGOW_ACCESS_TOKEN}
    Log to console  body=${feegowAPI_newAppoint}
    ${response}=    POST On Session    feegow-rest-api     /appoints/new-appoint    json=${feegowAPI_newAppoint}      headers=${headers}
    
    ${agendamento_id}=    Get Value From Json    ${response.json()}    $..agendamento_id
    Log To Console  appoint-id-json=${agendamento_id}
    
    ${newAppoint_id}=    Convert To String    ${agendamento_id}[0]
    Log to console  appoint-id-string=${newAppoint_id}

    Set Suite Variable    ${newAppoint_id}

Feegow Rest API - Reschedule appoint
    [Documentation]    Reschedule appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API_URL}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${FEEGOW_ACCESS_TOKEN} 
    ${response}=    POST On Session    feegow-rest-api     /appoints/reschedule    json=${feegowAPI_rescheduleAppoint}    headers=${headers}

Feegow Rest API - Delete appoint
    [Documentation]    Delete appointment - Feegow REST API
    Create Session    alias=feegow-rest-api    url=${FEEGOW_REST_API_URL}     verify=true   
    &{headers}=    Create Dictionary    X-Access-Token=${FEEGOW_ACCESS_TOKEN} 
    ${response}=    POST On Session    feegow-rest-api     /appoints/cancel-appoint    json=${feegowAPI_cancelAppoint}    headers=${headers}