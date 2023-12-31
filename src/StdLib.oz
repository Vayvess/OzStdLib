functor

export
    % DATA STRUCTURES
    'newFQ': NewFuncQueue
    'newFS': NewFuncStack

    % HELPERS
    'spawnAgent': SpawnAgent
    'newActiveObject': NewActiveObject
define

    % FUNCTIONAL STACK
    fun {FuncStack State}
        fun {Push push(X)}
            {FuncStack X | State}
        end

        fun {Pop pop(Out)}
            H | T = State
        in
            Out = H
            {FuncStack T}
        end

        fun {IsEmpty Out}
            Out = State == 'nil'
            {FuncStack State}
        end
    in
        fun {$ Msg}
            Interface = fs(
                'push': Push
                'pop': Pop
                'isEmpty': IsEmpty
            )
        in
            {Interface.{Label Msg} Msg}
        end
    end

    fun {NewFuncStack}
        {FuncStack 'nil'}
    end

    % FUNCTIONAL QUEUE
    % params([1 2 3] [4 5 6]) returns -> [1 2 3 4 5 6]
    fun {Append X Y}
        case X of XH | XT then
            XH | {Append XT Y}
        else Y end
    end

    % params([1 2 3 4 5]) returns -> [5 4 3 2 1]
    fun {Reverse X Acc}
        case X of XH | XT then
            {Reverse XT XH | Acc}
        else Acc end
    end

    % params([1 2 3] [6 5 4] 'nil') returns -> [1 2 3 4 5 6] 
    fun lazy {LAppRev X Y Acc}
        case X of XH | XT then
            case Y of YH | YT then
                XH | {LAppRev XT YT YH | Acc}
            else
                {Append X Acc}
            end
        else {Reverse Y Acc} end
    end

    fun {FuncQueue State}
        fun {Check NewState}
            fq(M X N Y) = NewState
        in
            if M < N then
                {FuncQueue fq(M + N {LAppRev X Y 'nil'} 0 'nil')}
            else {FuncQueue NewState} end
        end

        fun {Put put(Item)}
            fq(M X N Y) = State
        in
            {Check fq(M X N + 1 Item | Y)}
        end

        fun {Get get(Output)}
            fq(M X N Y) = State
            XH | XT = X
        in
            Output = XH
            {Check fq(M - 1 XT N Y)}
        end
    in
        fun {$ Msg}
            Interface = fq('put': Put 'get': Get)
        in
            {Interface.{Label Msg} Msg}
        end
    end

    fun {NewFuncQueue}
        {FuncQueue fq(0 'nil' 0 'nil')}
    end
    
    % HELPERS
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
            case Msg of join(Output) then
                Output = Agent
            else {Handler Upcoming {Agent Msg}} end
        end
    in
        thread {Handler Stream Agent} end
        proc {$ Msg} {Send Port Msg} end
    end
end
