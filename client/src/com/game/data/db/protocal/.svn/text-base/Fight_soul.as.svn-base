
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Fight_soul extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 精准每级增加值
 */
public function get hit() : int
{
        return _anti["hit"];
}
public function set hit(value:int) : void
{
        _anti["hit"] = value;
}


/**
 * 附体位置名称
 */
public function get name() : String
{
        return _anti["name"];
}
public function set name(value:String) : void
{
        _anti["name"] = value;
}


/**
 * 灵活每级增加值
 */
public function get evasion() : int
{
        return _anti["evasion"];
}
public function set evasion(value:int) : void
{
        _anti["evasion"] = value;
}


/**
 * front->先锋 middle -》 中坚 back-》大将
 */
public function get type() : String
{
        return _anti["type"];
}
public function set type(value:String) : void
{
        _anti["type"] = value;
}


/**
 * 体力每级增加值
 */
public function get hp() : int
{
        return _anti["hp"];
}
public function set hp(value:int) : void
{
        _anti["hp"] = value;
}


/**
 * 外功每级增加值
 */
public function get atk() : int
{
        return _anti["atk"];
}
public function set atk(value:int) : void
{
        _anti["atk"] = value;
}


/**
 * 罡气每级增加值
 */
public function get adf() : int
{
        return _anti["adf"];
}
public function set adf(value:int) : void
{
        _anti["adf"] = value;
}


/**
 * 战魂每级增加消耗
 */
public function get soul_add() : int
{
        return _anti["soul_add"];
}
public function set soul_add(value:int) : void
{
        _anti["soul_add"] = value;
}


/**
 * 内功每级增加值
 */
public function get ats() : int
{
        return _anti["ats"];
}
public function set ats(value:int) : void
{
        _anti["ats"] = value;
}


/**
 * 元气每级增加值
 */
public function get mp() : int
{
        return _anti["mp"];
}
public function set mp(value:int) : void
{
        _anti["mp"] = value;
}


/**
 * 基础战魂消耗
 */
public function get basic_soul() : int
{
        return _anti["basic_soul"];
}
public function set basic_soul(value:int) : void
{
        _anti["basic_soul"] = value;
}


/**
 * 暴击每级增加值
 */
public function get crit() : int
{
        return _anti["crit"];
}
public function set crit(value:int) : void
{
        _anti["crit"] = value;
}


/**
 * 步法每级增加值
 */
public function get spd() : int
{
        return _anti["spd"];
}
public function set spd(value:int) : void
{
        _anti["spd"] = value;
}


/**
 * ID
 */
public var id:int;

/**
 * 防御每级增加值
 */
public function get def() : int
{
        return _anti["def"];
}
public function set def(value:int) : void
{
        _anti["def"] = value;
}


/**
 * 韧性每级增加值
 */
public function get toughness() : int
{
        return _anti["toughness"];
}
public function set toughness(value:int) : void
{
        _anti["toughness"] = value;
}

        
        public function Fight_soul()
        {
            _anti = new Antiwear(new binaryEncrypt());
            
            

    _anti["hit"] = 0;


    _anti["name"] = "";


    _anti["evasion"] = 0;


    _anti["type"] = "";


    _anti["hp"] = 0;


    _anti["atk"] = 0;


    _anti["adf"] = 0;


    _anti["soul_add"] = 0;


    _anti["ats"] = 0;


    _anti["mp"] = 0;


    _anti["basic_soul"] = 0;


    _anti["crit"] = 0;


    _anti["spd"] = 0;


    _anti["def"] = 0;


    _anti["toughness"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    type = data.@type


    hp = data.@hp


    atk = data.@atk


    adf = data.@adf


    soul_add = data.@soul_add


    ats = data.@ats


    mp = data.@mp


    basic_soul = data.@basic_soul


    crit = data.@crit


    spd = data.@spd


    id = data.@id


    def = data.@def


    toughness = data.@toughness

        }
        
        public function copy() : Fight_soul
        {
            var target:Fight_soul = new Fight_soul();
            

    target.hit = this.hit;


    target.name = this.name;


    target.evasion = this.evasion;


    target.type = this.type;


    target.hp = this.hp;


    target.atk = this.atk;


    target.adf = this.adf;


    target.soul_add = this.soul_add;


    target.ats = this.ats;


    target.mp = this.mp;


    target.basic_soul = this.basic_soul;


    target.crit = this.crit;


    target.spd = this.spd;


    target.id = this.id;


    target.def = this.def;


    target.toughness = this.toughness;

            
            return target;
        }
    }
}
