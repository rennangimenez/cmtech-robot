*** Settings ***
Resource          ../../../resources/global/settings.robot

*** Keywords ***
Docplanner API - Generate the bearer token
    ${oauth}=                 Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_api${/}oauth${/}body.json
    Create Session           alias=docplanner-oauth    url=${DOCPLANNER_API_OAUTH}    verify=true
    ${response}=             POST On Session    docplanner-oauth    /token    json=${oauth}
    ${access_token}=         Get Value From Json     ${response.json()}       access_token
    &{docplannerAPI_headers}=              Create Dictionary    Authorization=Bearer ${access_token[0]}    Content-Type=application/json
    Set Suite Variable       &{docplannerAPI_headers}

Docplanner API - Get Facility Id
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}     verify=true
    ${response}=              GET On Session    docplanner-api    /facilities    headers=&{docplannerAPI_headers}
    ${facility_id}=           Get Value From Json     ${response.json()}    _items[0].id
    Log To Console            facility-${facility_id[0]}
    Set Suite Variable        ${facility_id}

Docplanner API - Get Doctor Id
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}    verify=true
    ${response}=              GET On Session    docplanner-api    /facilities/${facility_id[0]}/doctors    headers=&{docplannerAPI_headers}
    ${doctor_id}=             Get Value From Json     ${response.json()}    _items[0].id
    Log To Console            doctor-${doctor_id[0]} 
    Set Suite Variable        ${doctor_id}

Docplanner API - Get Address Id
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}    verify=true
    ${response}=              GET On Session    docplanner-api    /facilities/${facility_id[0]}/doctors/${doctor_id[0]}/addresses    headers=&{docplannerAPI_headers}
    ${address_id}=            Get Value From Json     ${response.json()}    _items[0].id
    Log To Console            address-${address_id[0]} 
    Set Suite Variable        ${address_id}

Docplanner API - Book Slot
    [Arguments]        ${start_at}
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}     verify=true
    ${bookSlot}=              Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_api${/}slots${/}bookSlot.json                
    ${response}=              POST On Session    docplanner-api    /facilities/${facility_id[0]}/doctors/${doctor_id[0]}/addresses/${address_id[0]}/slots/${start_at}/book     json=${bookSlot}       headers=&{docplannerAPI_headers}
    ${booked_slot}=        Get Value From Json     ${response.json()}    id   
    Set Suite Variable        ${booked_slot}  

Docplanner API - Book Second Slot
    [Arguments]        ${start_at}
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}     verify=true
    ${bookSlot}=              Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_api${/}slots${/}bookSlot.json           
    ${response}=              POST On Session    docplanner-api    /facilities/${facility_id[0]}/doctors/${doctor_id[0]}/addresses/${address_id[0]}/slots/${start_at}/book     json=${bookSlot}       headers=&{docplannerAPI_headers}
    ${secondBooked_slot}=        Get Value From Json     ${response.json()}    id 
    Set Suite Variable        ${secondBooked_slot}

Docplanner API - Cancel Booking Slot
    [Arguments]        ${canceledBooking_id}
    Create Session            alias=docplanner-api    url=${DOCPLANNER_API_OAUTH}     verify=true
    ${response}=              DELETE On Session    docplanner-api    /facilities/${facility_id[0]}/doctors/${doctor_id[0]}/addresses/${address_id[0]}/bookings/${canceledBooking_id}       headers=&{docplannerAPI_headers}
    Set Suite Variable        ${canceledBooking_id}