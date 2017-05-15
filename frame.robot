*** Settings ***
Library  Telnet
Library  OperatingSystem

*** Test Cases ***
Telnet login78
        [Documentation]         This is telnet login testing...
        [Tags]                  test1
        Open Connection         10.38.18.78
        Login                   root                    password
        Set Prompt              (root>)         prompt_is_regexp=yes
        ${CTRL_C}               Evaluate                chr(int(3))
        Set Timeout             10s
        Sleep                   5s
        Write Bare              ${CTRL_C}
        Read Until Prompt

