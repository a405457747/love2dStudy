
AnimatedSprite=Sprite:extend();

function AnimatedSprite:init(X,Y,W,H,new_sprite_atlas,sprite_pos)
    Sprite.init(self,X,Y,W,H,new_sprite_atlas,sprite_pos)
    self.offset={x=0,y=0}
    table.insert(G.ANIMATIONS,self);
    if getmetatable(self)==AnimatedSprite then
        table.insert(G.I.SPRITE,self);
    end
end

function AnimatedSprite:rescale()
    self.scale_mag=math.min(self.scale.x/self.T.w,self.scale.y/self.T.h);
end