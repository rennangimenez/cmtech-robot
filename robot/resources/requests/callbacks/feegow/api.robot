*** Settings ***
Resource          ../../../../resources/global/settings.robot

*** Keywords ***
Feegow Callbacks - Booking - Booking Canceled
    [Documentation]    Cancel a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingCanceled}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Booking - Booking Created
    [Documentation]    Create a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingCreated}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Booking - Booking Moved
    [Documentation]    Move a booking to a different slot through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingMoved}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Booking - Booking Edit
    [Documentation]    Edit a booking through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_bookingEdit}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Calendar Breaks - Calendar Break Deleted
    [Documentation]    Delete a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakDeleted}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Calendar Breaks - Calendar Break Created
    [Documentation]    Create a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakCreated}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Calendar Breaks - Calendar Break Edit
    [Documentation]    Edit a calendar break through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_calendarBreakEdit}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Replaced
    [Documentation]    Replace a schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleReplaced}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Replace
    [Documentation]    Replace an existing schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleReplace}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule - Schedule Deleted
    [Documentation]    Delete a schedule through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleDeleted}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule Exception - Schedule Deleted
    [Documentation]    Delete a schedule exception through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleExceptionDeleted}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Feegow Callbacks - Schedule Exception - Schedule Replace
    [Documentation]    Replace a schedule exception through a webhook request.
    Create Session    alias=feegow-callbacks    url=${FEEGOW_CALLBACKS_URL}     verify=true    
    ${response}=    POST On Session    feegow-callbacks     /webhook    json=${feegow_scheduleExceptionReplace}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 