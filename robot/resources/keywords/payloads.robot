*** Settings ***
Resource          ../../resources/global/settings.robot

*** Variables ***
${robot_dir}=              .${/}robot
${addressService_id}=      3786802

*** Keywords ***
Generate random data to avoid schedule conflict
    ${current_date}=    Get Current Date      result_format=datetime    exclude_millis=yes
    ${date_start}=      Add Time To Date      ${current_date}             time=7 days      result_format=datetime
    ${date_end}=        Add Time To Date      ${current_date}             time=60 weeks    result_format=datetime
    ${random_date}=     Date Between Dates    date_start=${date_start}    date_end=${date_end}
    ${random_date}=     Convert Date          ${random_date}              result_format=%Y-%m-%d
    ${random_hour}=     Time                  pattern=%H:%M:%S            end_datetime=None   

    Set Suite Variable    ${random_date}
    Set Suite Variable    ${random_hour}

Generate random patient and professional ids
    ${random_patient_id}=          Random Int    min=1    max=9 
    ${random_professional_id}=     Random Int    min=1    max=9 

    Set Suite Variable    ${random_patient_id}
    Set Suite Variable    ${random_professional_id}

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
    ${local_id}=            Set Variable   1  
    ${procedimento_id}=     Set Variable   8
    ${especialidade_id}=    Set Variable   227
    ${valor_id}=            Set Variable   1500
    ${plano_id}=            Set Variable   0
    ${motivo_id}=           Set Variable   1
    ${obs_id}=              Set Variable   Paciente
    ${formatted_time}=      Get Time Plus Hours    1
    ${data}=                Get Substring         ${formatted_time}    0    10
    ${horario}=             Get Substring         ${formatted_time}    11   19
    Set Suite Variable    ${local_id}
    Set Suite Variable    ${procedimento_id}
    Set Suite Variable    ${especialidade_id}
    Set Suite Variable    ${valor_id}
    Set Suite Variable    ${plano_id}
    Set Suite Variable    ${motivo_id}
    Set Suite Variable    ${data}
    Set Suite Variable    ${horario}
    Set Suite Variable    ${obs_id}

Connector Docplanner Callbacks Token - Generate the bearer token
    &{connectorApi_callbacks_headers}=    Create Dictionary    Authorization=Bearer ${CONNECTOR_API_TOKEN}    Content-Type=application/json
    Set Suite Variable       &{connectorApi_callbacks_headers}

Generate connector-api headers
    &{connectorApi_headers}=   Create Dictionary    Authorization=Bearer ${CONNECTOR_API_TOKEN}
    Set Suite Variable       &{connectorApi_headers}

Feegow Rest API - Create Appointment
    Generate random data to avoid schedule conflict
    Generate random patient and professional ids

    ${feegowAPI_newAppoint}=    Load Json From File    file_name=${robot_dir}${/}data${/}feegow_rest_api${/}appointment${/}newAppoint.json 

    Set To Dictionary        ${feegowAPI_newAppoint}    local_id            ${local_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    paciente_id         ${random_patient_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    profissional_id     ${random_professional_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    procedimento_id     ${procedimento_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    especialidade_id    ${especialidade_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    data                ${random_date}
    Set To Dictionary        ${feegowAPI_newAppoint}    horario             ${random_hour}
    Set To Dictionary        ${feegowAPI_newAppoint}    valor               ${valor_id}
    Set To Dictionary        ${feegowAPI_newAppoint}    plano               ${plano_id}

    Set Suite Variable       ${feegowAPI_newAppoint}

Feegow Rest API - Change Appointment
    Generate random data to avoid schedule conflict

    ${feegowAPI_rescheduleAppoint}=    Load Json From File    file_name=${robot_dir}${/}data${/}feegow_rest_api${/}appointment${/}rescheduleAppoint.json 
    
    Set To Dictionary        ${feegowAPI_rescheduleAppoint}    agendamento_id    ${newAppoint_id}
    Set To Dictionary        ${feegowAPI_rescheduleAppoint}    data              ${random_date}
    Set To Dictionary        ${feegowAPI_rescheduleAppoint}    horario           ${random_hour}
    
    Set Suite Variable       ${feegowAPI_rescheduleAppoint}

Feegow Rest API - Cancel Appointment
    ${feegowAPI_cancelAppoint}=    Load Json From File    file_name=${robot_dir}${/}data${/}feegow_rest_api${/}appointment${/}cancelAppoint.json 

    Set To Dictionary        ${feegowAPI_cancelAppoint}    agendamento_id    ${newAppoint_id}
    Set Suite Variable       ${feegowAPI_cancelAppoint}

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
    Feegow Rest API - New Appoint
    ${feegow_bookingCreated}=        Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_created.json
    Set To Dictionary         ${feegow_bookingCreated['payload']}    PacienteID        ${random_patient_id}
    Set To Dictionary         ${feegow_bookingCreated['payload']}    ProfissionalID    ${random_professional_id}
    Set To Dictionary         ${feegow_bookingCreated['payload']}    Data              ${random_date}
    Set To Dictionary         ${feegow_bookingCreated['payload']}    Hora              ${random_hour}
    Set To Dictionary         ${feegow_bookingCreated['payload']}    id                ${newAppoint_id}

    Set Suite Variable        ${feegow_bookingCreated}

    Feegow Rest API - Change Appointment
    Feegow Rest API - Reschedule appoint
    ${feegow_bookingEdit}=           Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_edit.json
    Set To Dictionary         ${feegow_bookingEdit['payload']}    PacienteID        ${random_patient_id}
    Set To Dictionary         ${feegow_bookingEdit['payload']}    ProfissionalID    ${random_date}
    Set To Dictionary         ${feegow_bookingEdit['payload']}    Data              ${random_date}
    Set To Dictionary         ${feegow_bookingEdit['payload']}    Hora              ${random_hour}
    Set To Dictionary         ${feegow_bookingEdit['payload']}    id                ${newAppoint_id}
    Set Suite Variable        ${feegow_bookingEdit}

    Feegow Rest API - Change Appointment
    Feegow Rest API - Reschedule appoint
    ${feegow_bookingMoved}=          Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_moved.json
    Set To Dictionary         ${feegow_bookingMoved['payload']}    PacienteID        ${random_patient_id}
    Set To Dictionary         ${feegow_bookingMoved['payload']}    ProfissionalID    ${random_date}
    Set To Dictionary         ${feegow_bookingMoved['payload']}    Data              ${data}
    Set To Dictionary         ${feegow_bookingMoved['payload']}    Hora              ${horario}
    Set To Dictionary         ${feegow_bookingMoved['payload']}    id                ${newAppoint_id}
    Set Suite Variable        ${feegow_bookingMoved}

    Feegow Rest API - Cancel Appointment
    Feegow Rest API - Delete appoint
    ${feegow_bookingCanceled}=       Load JSON From File     file_name=${robot_dir}${/}data${/}feegow_callbacks${/}booking${/}booking_canceled.json
    Set To Dictionary         ${feegow_bookingCanceled['payload']}    id    ${newAppoint_id}
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
    Feegow Rest API - Create Appointment
    Feegow Callbacks Payloads