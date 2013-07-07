[BITS 32]
mov ebx, 0x00584148 ; Loads null terminated HAX string
push ebx ; push ebx onto the stack
mov esi, esp ; saves HAX string into esi
xor eax, eax ; zero out eax
push eax ; push uType (4th parameter) to the stack (value 0)
push esi ; push lpCaption (3rd parameter) to the stack (value HAX)
push esi ; push lpText (2nd parameter) to the stack (value HAX)
push eax ; push hWnd (1st parameter) to the stac (value 0)
mov eax, 0x77D8050B ; move the address for MessageBoxA into eax
call eax ; call MessageBoxA
