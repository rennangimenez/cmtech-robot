*** Settings ***
Resource          ../resources/global/settings.robot
Suite Setup       API Payload Setup

*** Test Cases ***
 
Doctoralia callbacks
    Doctoralia Callbacks - Booking - Slot Booking
    Doctoralia Callbacks - Booking - Slot Booked  
    Doctoralia Callbacks - Booking - Booking Moving
    Doctoralia Callbacks - Booking - Booking Moved
    Doctoralia Callbacks - Booking - Booking Confirmed
    Doctoralia Callbacks - Booking - Booking Canceled
