*** Settings ***
Resource          ../resources/global/settings.robot
Suite Setup       API Payload Setup

*** Test Cases ***
Docplanner callbacks
    Docplanner Callbacks - Booking - Slot Booking
    Docplanner Callbacks - Booking - Slot Booked  
    Docplanner Callbacks - Booking - Booking Moving
    Docplanner Callbacks - Booking - Booking Moved
    Docplanner Callbacks - Booking - Booking Confirmed
    Docplanner Callbacks - Booking - Booking Canceled
