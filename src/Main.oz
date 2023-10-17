functor

import
    StdLib
    System
    Browser
define
    A = {StdLib.newFQ}
    B = {A put(5)}
    C = {B put(6)}
    D = {C put(7)}


    OutA
    E = {D get(OutA)}

    % TRANSFORM INTO ACTIVE Functional Object -> Agent / Port Object
    F = {StdLib.spawnAgent E}
    {F put(8)}
    {F put(9)}

    OutB
    {F get(OutB)}

    OutC
    {F get(OutC)}

    % + 0 -> Trigger the computation !
    {System.show log(
        OutA + 0
        OutB + 0
        OutC + 0)
    }

    % TODO: TRANSFORM ACTIVE OBJECT INTO PASSIVE OBJECT :)
end
