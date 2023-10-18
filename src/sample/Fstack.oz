functor

import
    System
    StdLib
define
    A = {StdLib.newFS}
    B = {A push(1)}
    C = {B push(2)}
    D = {C push(3)}

    OutA
    E = {D pop(OutA)}

    % TRANSFORM INTO ACTIVE Functional Object -> Agent / Port Object
    F = {StdLib.spawnAgent E}
    {F push(4)}
    {F push(5)}
    OutB = {F pop($)}

    % PRINTS -> log(3 5)
    {System.show log(OutA OutB + 0)}
end