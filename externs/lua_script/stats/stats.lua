Class "Stats" [{
    function __Stats()
        this.defense = 1
        this.attack = 1
        this.parade = 1
        this.speed = 1
    end

    function getSpeed()
        return this.speed
    end

    function getDefense()
        return this.defense
    end

    function getParade()
        return this.parade
    end

    function getAttack()
        return this.attack
    end

    function setSpeed(speed)
        check(speed, "number", 1)
        cassert(speed >= 0, "Speed must be positive", 3)

        this.speed = speed
    end

    function setDefense(defense)
        check(defense, "number", 1)
        cassert(defense >= 0, "Defense must be positive", 3)

        this.defense = defense
    end

    function setParade(parade)
        check(parade, "number", 1)
        cassert(parade >= 0, "Parade must be positive", 3)

        this.parade = parade
    end

    function setAttack(attack)
        check(attack, "number", 1)
        cassert(attack >= 0, "Attack must be positive", 3)

        this.attack = attack
    end
}]