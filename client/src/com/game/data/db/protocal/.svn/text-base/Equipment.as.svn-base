
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Equipment extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 内功增加值
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
 * 罡气增加值
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
 * 该装备可以卖多少钱
 */
public function get sale_money() : int
{
        return _anti["sale_money"];
}
public function set sale_money(value:int) : void
{
        _anti["sale_money"] = value;
}


/**
 * 精准增加值
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
 * 装备名称
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
 * 灵活增加值
 */
public function get evasion() : String
{
        return _anti["evasion"];
}
public function set evasion(value:String) : void
{
        _anti["evasion"] = value;
}


/**
 * 装备的品级颜色，白，绿，蓝，紫
 */
public var color:String;


/**
 * 体力增加值
 */
public function get hp() : String
{
        return _anti["hp"];
}
public function set hp(value:String) : void
{
        _anti["hp"] = value;
}


/**
 * 专属角色名
 */
public var exclusive_character:String;


/**
 * 外功增加值的区间，竖线前为最低值，竖线后为最高值
 */
public var atk_space:String;

/**
 * 装备每强化一级可以多卖多少钱
 */
public function get money_add() : int
{
        return _anti["money_add"];
}
public function set money_add(value:int) : void
{
        _anti["money_add"] = value;
}


/**
 * 装备等级限制
 */
public var grade_limit:int;


/**
 * 防御增加值的区间，竖线前为最低值，竖线后为最高值
 */
public var def_space:String;


/**
 * 元气增加值
 */
public function get mp() : String
{
        return _anti["mp"];
}
public function set mp(value:String) : void
{
        _anti["mp"] = value;
}


/**
 * 暴击增加值
 */
public function get crit() : String
{
        return _anti["crit"];
}
public function set crit(value:String) : void
{
        _anti["crit"] = value;
}


/**
 * 步法增加值的区间，竖线前为最低值，竖线后为最高值
 */
public var spd_space:String;


/**
 * 装备类别:武器,衣着,饰品
 */
public var type:String;


/**
 * ID
 */
public function get id() : int
{
        return _anti["id"];
}
public function set id(value:int) : void
{
        _anti["id"] = value;
}


/**
 * 韧性增加值
 */
public function get toughness() : int
{
        return _anti["toughness"];
}
public function set toughness(value:int) : void
{
        _anti["toughness"] = value;
}

        
        public function Equipment()
        {
            _anti = new Antiwear(new binaryEncrypt());
            
            

    _anti["ats"] = 0;


    _anti["adf"] = 0;


    _anti["sale_money"] = 0;


    _anti["hit"] = 0;


    _anti["name"] = "";


    _anti["evasion"] = "";


    _anti["hp"] = "";


    _anti["money_add"] = 0;


    _anti["mp"] = "";


    _anti["crit"] = "";


    _anti["id"] = 0;


    _anti["toughness"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    ats = data.@ats


    adf = data.@adf


    sale_money = data.@sale_money


    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    color = data.@color


    hp = data.@hp


    exclusive_character = data.@exclusive_character


    atk_space = data.@atk_space


    money_add = data.@money_add


    grade_limit = data.@grade_limit


    def_space = data.@def_space


    mp = data.@mp


    crit = data.@crit


    spd_space = data.@spd_space


    type = data.@type


    id = data.@id


    toughness = data.@toughness

        }
        
        public function copy() : Equipment
        {
            var target:Equipment = new Equipment();
            

    target.ats = this.ats;


    target.adf = this.adf;


    target.sale_money = this.sale_money;


    target.hit = this.hit;


    target.name = this.name;


    target.evasion = this.evasion;


    target.color = this.color;


    target.hp = this.hp;


    target.exclusive_character = this.exclusive_character;


    target.atk_space = this.atk_space;


    target.money_add = this.money_add;


    target.grade_limit = this.grade_limit;


    target.def_space = this.def_space;


    target.mp = this.mp;


    target.crit = this.crit;


    target.spd_space = this.spd_space;


    target.type = this.type;


    target.id = this.id;


    target.toughness = this.toughness;

            
            return target;
        }
    }
}
