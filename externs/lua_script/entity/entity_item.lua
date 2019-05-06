-- =========================================
-- =              ENTITY ITEM              =
-- =========================================

Class "EntityItem" extends "Entity" [{
    function __EntityItem(itemstack)
        check(itemstack, "itemstack", 1)
        super(0, 0)

        this.sprite = lsfml.sprite.create()
        this.sprite:setPosition(0, 0)
        this.sprite:setTexture(itemstack:getItem():getTexture(), false)
        this.sprite:scale(1, 1)
        this.sprite:setOrigin(32, 32)
        this.itemstack = itemstack
        this.anim = 0
        this.status = "up"
    end

    function setPosition(x, y)

        this.sprite:setPosition(x, y)
        super.setPosition(x, y)
    end

    function getItemStack()
        return this.itemstack
    end

    function setItemStack(itemstack)
        check(itemstack, "itemstack", 2)

        this.itemstack = itemstack
        this.sprite:setTexture(itemstack:getItem():getTexture(), false)
    end

    function move(x, y)
        check(x ,"number", 1)
        check(y ,"number", 2)

        local success, nx, ny = super.move(x, y)
        if success then
            this.sprite:move(nx, ny)
        end
    end

    function draw()
        window:draw(this.sprite)
    end

    function compute_push()
        super.update()
        local nx, ny = super.getPosition()
        for i=1, #push_rays do
            local success, point = hitbox.rayhit(nx, ny, push_rays[i][1] * 20, push_rays[i][2] * 20)
            if success then
                return true, -push_rays[i][1] * 20, -push_rays[i][2] * 20
            end
        end
        return false
    end

    function update()
        local success, mvx, mvy = compute_push()
        if success then
            this.move(mvx, mvy)
        end
        if this.status == "up" then
            this.anim = this.anim + math.floor(DeltaTime)
            if this.anim > 40 then
                this.status = "down"
            end
        elseif this.status == "down" then
            this.anim = this.anim - math.floor(DeltaTime)
            if this.anim < 0 then
                this.status = "up"
            end
        end
        local x, y = super.getPosition()
        this.sprite:setPosition(x, y - this.anim)
    end
}]