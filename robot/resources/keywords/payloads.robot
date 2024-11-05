*** Settings ***
Resource          ../../resources/global/settings.robot

*** Variables ***
${robot_dir}=              .${/}robot
${addressService_id}=      3786802
${canceledBooking_id}
${secondBooked_slot}
${start_at}
${end_at}

*** Keywords ***
Generate number and date consts
    ${currentTimePlus1}=      Get Time Plus Hours       1
    ${currentTimePlus2}=      Get Time Plus Hours       2
    ${currentTimePlus3}=      Get Time Plus Hours       3
    ${currentTimePlus4}=      Get Time Plus Hours       4
    Set Suite Variable    ${currentTimePlus1}
    Set Suite Variable    ${currentTimePlus2}
    Set Suite Variable    ${currentTimePlus3}
    Set Suite Variable    ${currentTimePlus4}

Feegow Rest API - Data set
    ${local_id}=           Set Variable   1
    ${patient_id}=         Set Variable   9
    ${profissional_id}=    Set Variable   1      
    ${procedimento_id}=    Set Variable   8
    ${especialidade_id}=   Set Variable   227
    ${valor_id}=           Set Variable   1500
    ${plano_id}=           Set Variable   0
    ${motivo_id}=          Set Variable   1
    ${obs_id}=             Set Variable   Paciente
    ${formatted_time}=    Get Time Plus Hours    1
    ${data}=              Get Substring         ${formatted_time}    0    10
    ${horario}=           Get Substring         ${formatted_time}    11   19
    Set Suite Variable    ${local_id}
    Set Suite Variable    ${patient_id}
    Set Suite Variable    ${profissional_id}
    Set Suite Variable    ${procedimento_id}
    Set Suite Variable    ${especialidade_id}
    Set Suite Variable    ${valor_id}
    Set Suite Variable    ${plano_id}
    Set Suite Variable    ${motivo_id}
    Set Suite Variable    ${data}
    Set Suite Variable    ${horario}
    Set Suite Variable    ${obs_id}

Connector Docplanner Callbacks Token - Generate the bearer token
    ${callbacks_headers}=              Create Dictionary    Authorization=Bearer ${CONNECTORAPI_CALLBACKS_TOKEN}    Content-Type=application/json
    Set Suite Variable       ${callbacks_headers}

Generate connector-api headers
    &{connectorApi_headers}=   Create Dictionary    Authorization=Bearer ${CONNECTOR_API_TOKEN}
    Set Suite Variable       &{connectorApi_headers}

Feegow Rest API - Create Appointment
    ${feegowAPI_booking}=    Load Json From File    file_name=${robot_dir}${/}data${/}feegow_rest_api${/}appointment${/}newAppoint.json 
    Set To Dictionary         ${feegowAPI_booking}    local_id           ${local_id}
    Set To Dictionary         ${feegowAPI_booking}    paciente_id        ${patient_id}
    Set To Dictionary         ${feegowAPI_booking}    profissional_id    ${profissional_id}
    Set To Dictionary         ${feegowAPI_booking}    procedimento_id    ${especialidade_id}
    
    Set To Dictionary         ${feegowAPI_booking}    valor              ${valor_id}
    Set To Dictionary         ${feegowAPI_booking}    plano              ${plano_id}

Docplanner Callbacks Payloads
    ${slotBooking}=           Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}slotBooking.json
    Set To Dictionary         ${slotBooking['data']['visit_booking_request']}    start_at    ${currentTimePlus1}
    Set To Dictionary         ${slotBooking['data']['visit_booking_request']}    end_at      ${currentTimePlus2}
    Set To Dictionary         ${slotBooking['data']['visit_booking_request']}    booking_at       ${currentTimePlus1}
    Set To Dictionary         ${slotBooking}    created_at      ${currentTimePlus1}
    Set Suite Variable        ${slotBooking}

    ${slotBooked}=            Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}slotBooked.json
    Set To Dictionary         ${slotBooked['data']['visit_booking']}    id    ${booked_slot[0]}
    Set To Dictionary         ${slotBooked['data']['visit_booking']}    start_at    ${currentTimePlus1}
    Set To Dictionary         ${slotBooked['data']['visit_booking']}    end_at    ${currentTimePlus2}
    Set To Dictionary         ${slotBooked['data']['visit_booking']}    booking_at    ${currentTimePlus1}
    Set Suite Variable        ${slotBooked}

    ${bookingMoving}=    Load JSON From File    file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}bookingMoving.json
    Set To Dictionary    ${bookingMoving['data']['canceling_booking']}    id    ${booked_slot[0]}
    Set To Dictionary    ${bookingMoving['data']['canceling_booking']}    start_at    ${currentTimePlus1}
    Set To Dictionary    ${bookingMoving['data']['canceling_booking']}    end_at    ${currentTimePlus2}
    Set To Dictionary    ${bookingMoving['data']['creating_booking']}    start_at    ${currentTimePlus3}
    Set To Dictionary    ${bookingMoving['data']['creating_booking']}    end_at    ${currentTimePlus4}
    Set To Dictionary    ${bookingMoving['data']['creating_booking']['address_service']}    id    ${addressService_id}
    Set Suite Variable    ${bookingMoving}
    
    ${bookingMoved}=          Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}bookingMoved.json
    Set To Dictionary         ${bookingMoved['data']['old_visit_booking']}    id       ${booked_slot[0]}
    DocPlanner API - Book Second Slot    ${currentTimePlus3}
    Set To Dictionary         ${bookingMoved['data']['new_visit_booking']}    id       ${secondBooked_slot[0]}
    Set To Dictionary         ${bookingMoved['data']['new_visit_booking']}    start_at       ${currentTimePlus3}
    Set To Dictionary         ${bookingMoved['data']['new_visit_booking']}    end_at       ${currentTimePlus4}
    Set To Dictionary         ${bookingMoved['data']['new_visit_booking']}    booked_at       ${currentTimePlus3}
    Set Suite Variable        ${bookingMoved}

    ${bookingConfirmed}=      Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}bookingConfirmed.json
    Set To Dictionary         ${bookingConfirmed['data']['visit_booking']}    id        ${secondBooked_slot[0]}
    Set Suite Variable        ${bookingConfirmed}
    
    ${bookingCanceled}=       Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}booking${/}bookingCanceled.json
    DocPlanner API - Cancel Booking Slot      ${secondBooked_slot[0]}  
    Set To Dictionary         ${bookingCanceled['data']['visit_booking']}        id       ${secondBooked_slot[0]}  
    Set Suite Variable        ${bookingCanceled}
    
    ${addressAssigned}=       Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}doctor${/}addressAssigned.json
    Set Suite Variable        ${addressAssigned}
    
    ${addressUnassigned}=     Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}doctor${/}addressUnassigned.json
    Set Suite Variable        ${addressUnassigned}
    
    ${addressServiceDeleted}=     Load JSON From File     file_name=${robot_dir}${/}data${/}docplanner_callbacks${/}address_services${/}addressServiceDeleted.json
    Set Suite Variable        ${addressServiceDeleted}

Feegow Callbacks Payloads
    ${feegow_bookingCreated}=        Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_created.json
    Set To Dictionary         ${feegow_bookingCreated}    data           ${data}
    Set To Dictionary         ${feegow_bookingCreated}    horario        ${horario}
    Set To Dictionary         ${feegow_bookingCreated}    valor          ${valor_id}
    Set To Dictionary         ${feegow_bookingCreated}    plano          ${plano_id}
    Set Suite Variable        ${feegow_bookingCreated}

    ${feegow_bookingEdit}=           Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_edit.json
    Set Suite Variable        ${feegow_bookingEdit}

    ${feegow_bookingMoved}=          Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_moved.json
    Set Suite Variable        ${feegow_bookingMoved}

    ${feegow_bookingCanceled}=       Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_canceled.json
    Set Suite Variable        ${feegow_bookingCanceled}

    ${feegow_scheduleDeleted}=       Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}schedule${/}schedule_deleted.json
    Set Suite Variable        ${feegow_scheduleDeleted}

    ${feegow_scheduleReplace}=       Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}schedule${/}schedule_replace.json
    Set Suite Variable        ${feegow_scheduleReplace}

    ${feegow_scheduleReplaced}=      Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}schedule${/}schedule_replaced.json
    Set Suite Variable        ${feegow_scheduleReplaced}

    ${feegow_scheduleExceptionDeleted}=     Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}schedule_exception${/}schedule_deleted.json
    Set Suite Variable        ${feegow_scheduleExceptionDeleted}

    ${feegow_scheduleExceptionReplace}=     Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}schedule_exception${/}schedule_replace.json
    Set Suite Variable        ${feegow_scheduleExceptionReplace}

     ${feegow_calendarBreakDeleted}=  Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}calendar_breaks${/}calendar_break_deleted.json
    Set Suite Variable        ${feegow_calendarBreakDeleted}

    ${feegow_calendarBreakCreated}=  Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}calendar_breaks${/}calendar_break_created.json
    Set Suite Variable        ${feegow_calendarBreakCreated}

    ${feegow_calendarBreakEdit}=     Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}calendar_breaks${/}calendar_break_edit.json
    Set Suite Variable        ${feegow_calendarBreakEdit}

API Payload Setup
    Generate number and date consts
    Connector Docplanner Callbacks Token - Generate the bearer token
    Docplanner API - Generate the bearer token
    Generate connector-api headers
    Connector API - Doctor Full Reset
    Feegow Rest API - Data set
    Docplanner API - Get Facility Id
    Docplanner API - Get Doctor Id
    Docplanner API - Get Address Id
    DocPlanner API - Book Slot        ${currentTimePlus1}
    Docplanner Callbacks Payloads
    Feegow Callbacks Payloads
