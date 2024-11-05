*** Settings ***
Resource          ../../../../resources/global/settings.robot

*** Keywords ***
Doctoralia Callbacks - Booking - Slot Booking
    [Documentation]    Book a visit slot through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true   
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${slotBooking}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Slot Booking - Succesful

Doctoralia Callbacks - Booking - Slot Booked
    [Documentation]    Confirm that a slot has been booked through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${slotBooked}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Slot Booked - Succesful

Doctoralia Callbacks - Booking - Booking Moving
    [Documentation]    Move a booked slot to a new time through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true      
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${bookingMoving}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Moving - Succesful

Doctoralia Callbacks - Booking - Booking Moved
    [Documentation]    Confirm that a booked slot has been moved through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${bookingMoved}    headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Moved - Succesful

Doctoralia Callbacks - Booking - Booking Canceled
    [Documentation]    Confirm that a booking has been canceled through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${bookingCanceled}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Canceled - Succesful

Doctoralia Callbacks - Booking - Booking Confirmed
    [Documentation]    Confirm that a booking has been confirmed through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${bookingConfirmed}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Confirmed - Succesful

Doctoralia Callbacks - Doctor - Address Assigned
    [Documentation]    Confirm that an address has been assigned to a doctor through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${addressAssigned}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Doctoralia Callbacks - Doctor - Address Unassigned
    [Documentation]    Confirm that an address has been unassigned from a doctor through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${addressUnassigned}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Doctoralia Callbacks - Address Services - Address Service Deleted
    [Documentation]    Confirm that an address service has been deleted through a webhook request.
    Create Session    alias=doctoralia-callbacks    url=${DOCTORALIA_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    doctoralia-callbacks    /webhook    json=${addressServiceDeleted}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200