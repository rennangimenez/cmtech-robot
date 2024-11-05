*** Settings ***
Resource          ../../../../resources/global/settings.robot

*** Keywords ***
Docplanner Callbacks - Booking - Slot Booking
    [Documentation]    Book a visit slot through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true   
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${slotBooking}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Slot Booking - Succesful

Docplanner Callbacks - Booking - Slot Booked
    [Documentation]    Confirm that a slot has been booked through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${slotBooked}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Slot Booked - Succesful

Docplanner Callbacks - Booking - Booking Moving
    [Documentation]    Move a booked slot to a new time through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true      
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${bookingMoving}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Moving - Succesful

Docplanner Callbacks - Booking - Booking Moved
    [Documentation]    Confirm that a booked slot has been moved through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${bookingMoved}    headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Moved - Succesful

Docplanner Callbacks - Booking - Booking Canceled
    [Documentation]    Confirm that a booking has been canceled through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${bookingCanceled}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Canceled - Succesful

Docplanner Callbacks - Booking - Booking Confirmed
    [Documentation]    Confirm that a booking has been confirmed through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${bookingConfirmed}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 
    Log to Console    Booking - Booking Confirmed - Succesful

Docplanner Callbacks - Doctor - Address Assigned
    [Documentation]    Confirm that an address has been assigned to a doctor through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${addressAssigned}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Docplanner Callbacks - Doctor - Address Unassigned
    [Documentation]    Confirm that an address has been unassigned from a doctor through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${addressUnassigned}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200 

Docplanner Callbacks - Address Services - Address Service Deleted
    [Documentation]    Confirm that an address service has been deleted through a webhook request.
    Create Session    alias=docplanner-callbacks    url=${DOCPLANNER_CALLBACKS_BASE_URL}    verify=true    
    ${response}=    POST On Session    docplanner-callbacks    /webhook    json=${addressServiceDeleted}      headers=${callbacks_headers}
    Should Be Equal As Numbers    ${response.status_code}    200