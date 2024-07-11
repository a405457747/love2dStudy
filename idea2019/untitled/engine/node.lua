Node =Object.extend();

function Node:init(args)
    args= args or {}
    args.T =args.T or {}

    self.ARGS=self.ARGS or {}
    self.RETS={}

    self.config =self.config or {}

    self.T ={
        x =args.T.x or args.T[1] or 0,
        y=args.T.y or args.T[2] or 0,
        h =args.T.w or args.T[3] or 0,
        r =args.T.r or args.T[4] or 1,
        scale =args.T.scale or args.T[6] or 1,
    }

    self.CT=self.T

    self.click_offset={x=0,y=0}
    self.hover_offset={x=0,y=0}

    self.created_on_pause=G.SETTINGS.paused
    G.ID=G.ID or 1
    self.ID =G.ID
    G.ID=G.ID+1

    self.FRAME={
        DRAW=-1,
        MOVE=-1
    }

end