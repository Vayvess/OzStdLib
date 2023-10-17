functor

export
    'spawnAgent': SpawnAgent
    'newActiveObject': NewActiveObject
define

    /*
    fun lazy {LAppRev F R B}
        case pair(F R)
        of pair(X|F2 Y|R2) then
           X|{LAppRev F2 R2 Y|B}
        [] pair(nil [Y]) then Y|B
        end
     end
     */

    fun {FuncQueue State}

        fun {Check Q}
        
        end

        fun {Put put(Item)}
            case State of state(N X M Y) then
                {Check q(N X M + 1 )}
            end
        end

        fun {Get get(Out)}

        end
    in
        fq(
            'put': Put
            'get': Get
        )
    end

    fun {NewFuncQueue}
        {FuncQueue state(0 'nil' 0 'nil')}
    end

    fun {NewActiveObject Class Init}
        Stream
        Port = {NewPort Stream}
        Instance = {New Class Init}
    in
        thread
            for Msg in Stream do {Instance Msg} end
        end

        proc {$ Msg} {Send Port Msg} end
    end

    fun {SpawnAgent Agent}
        Stream
        Port = {NewPort Stream}

        proc {Handler Msg | Upcoming Agent}
            {Handler Upcoming {Agent.{Label Msg} Msg}}
        end
    in
        thread {Handler Stream Agent} end
        proc {$ Msg} {Send Port Msg} end
    end
end