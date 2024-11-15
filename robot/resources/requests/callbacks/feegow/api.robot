*** Settings ***
Resource          ../../../../resources/global/settings.robot

*** Keywords ***
Feegow Callbacks - Booking - Booking Canceled
    [Documentation]    Cancel a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingCanceled}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log to Console    Feegow - Booking - Booking Canceled - Succesful

Feegow Callbacks - Booking - Booking Created
    [Documentation]    Create a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingCreated}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log to Console    Feegow - Booking - Booking Created - Succesful


Feegow Callbacks - Booking - Booking Moved
    [Documentation]    Move a booking to a different slot through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingMoved}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Feegow - Booking - Booking Moved - Succesful

Feegow Callbacks - Booking - Booking Edit
    [Documentation]    Edit a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingEdit}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log to Console    Feegow - Booking - Booking Edit - Succesful

Feegow Callbacks - Calendar Breaks - Calendar Break Deleted
    [Documentation]    Delete a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakDeleted}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Calendar Breaks - Calendar Break Created
    [Documentation]    Create a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakCreated}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Calendar Breaks - Calendar Break Edit
    [Documentation]    Edit a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakEdit}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Replaced
    [Documentation]    Replace a schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleReplaced}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Replace
    [Documentation]    Replace an existing schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleReplace}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Deleted
    [Documentation]    Delete a schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleDeleted}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule Exception - Schedule Deleted
    [Documentation]    Delete a schedule exception through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleExceptionDeleted}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule Exception - Schedule Replace
    [Documentation]    Replace a schedule exception through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleExceptionReplace}      headers=${connectorApi_callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 