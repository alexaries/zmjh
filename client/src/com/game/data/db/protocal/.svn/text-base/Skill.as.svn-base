
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Skill extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 伤害的持续回合数，0为无伤，1为当前回合伤害，2以上为持续回合数
 */
public var Damage_time:int;


/**
 * 技能使得，角色罡气值增加或者减少的值
 */
//public var adf_up:int;
public function get adf_up() : int
{
	return _anti["adf_up"];
}
public function set adf_up(value:int) : void
{
	_anti["adf_up"] = value;
}

/**
 * 技能状态在哪方身上存在，0->敌方，1->我方
 */
public var choice_status_obj:int;


/**
 * 该技能是否能造成睡眠状态，0->否，1->是
 */
public var asleep_status:int;


/**
 * 该技能是否能造成晕厥状态，0->否，1->是
 */
public var syncope_status:int;


/**
 * 被技能打到会回复我方多少体力（血量）
 */
public function get hp_up() : Number
{
        return _anti["hp_up"];
}
public function set hp_up(value:Number) : void
{
        _anti["hp_up"] = value;
}


/**
 * 
 */
public var id:int;


/**
 * 伤害比例，技能伤害根据主角外功值乘以比例计算
 */
public function get damage_ratio() : Number
{
        return _anti["damage_ratio"];
}
public function set damage_ratio(value:Number) : void
{
        _anti["damage_ratio"] = value;
}


/**
 * 该技能是否能造成酒醉状态，0->否，1->是
 */
public var drunk_status:int;


/**
 * 技能使得，角色灵活值增加或者减少的值
 */
public function get evasion_up() : int
{
        return _anti["evasion_up"];
}
public function set evasion_up(value:int) : void
{
        _anti["evasion_up"] = value;
}


/**
 * 释放技能消耗的物品名称
 */
public var item_name:String;


/**
 * 技能说明
 */
public var description:String;

/**
 * 技能伤害是否为普通伤害，0->否，1->是
 */
public var common:int;


/**
 * 技能伤害是否为混沌属性伤害，0->否，1->是。混沌属性伤害对有特殊状态的敌人必定造成暴击。
 */
public var chaos:int;

/**
 * 该技能是否能造成石灰状态，0->否，1->是
 */
public var lime_status:int;

/**
 * 技能伤害是否为水属性伤害，0->否，1->是。水属性伤害对有石灰状态的敌人会造成30%附加伤害。
 */
public var water:int;

/**
 * 技能伤害是否为火属性伤害，0->否，1->是。火属性伤害对有酒状态的敌人会造成30%附加伤害。
 */
public var fire:int;

/**
 * 技能伤害是否为毒属性伤害，0->否，1->是 。水属性伤害不会打断对方的睡眠效果。
 */
public var poison:int;

/**
 * 该技能是否能造成中毒状态，0->否，1->是
 */
public var poison_status:int;



/**
 * 技能使得，角色步法值增加或者减少的值
 */
public function get spd_up() : int
{
        return _anti["spd_up"];
}
public function set spd_up(value:int) : void
{
        _anti["spd_up"] = value;
}


/**
 * 技能使得，角色韧性值增加或者减少的值
 */
public function get toughness_up() : int
{
        return _anti["toughness_up"];
}
public function set toughness_up(value:int) : void
{
        _anti["toughness_up"] = value;
}




/**
 * 技能使得，角色精准值增加或者减少的值
 */
public function get hit_up() : int
{
        return _anti["hit_up"];
}
public function set hit_up(value:int) : void
{
        _anti["hit_up"] = value;
}


/**
 * 该技能所消耗的元气（蓝）
 */
public function get skill_mp() : int
{
        return _anti["skill_mp"];
}
public function set skill_mp(value:int) : void
{
        _anti["skill_mp"] = value;
}


/**
 * 技能类型（0为主角技能，1为个性技能，2为敌方技能）
 */
public var type:int;


/**
 * 释放技能消耗的物品个数
 */
public var item_number:int;


/**
 * 被技能打到会减少对方多少元气（蓝），百分比
 */
public function get mp_down() : Number
{
        return _anti["mp_down"];
}
public function set mp_down(value:Number) : void
{
        _anti["mp_down"] = value;
}







/**
 * 技能使得，角色暴击值增加或者减少的值
 */
public function get crit_up() : int
{
        return _anti["crit_up"];
}
public function set crit_up(value:int) : void
{
        _anti["crit_up"] = value;
}


/**
 * 攻击的击中特效
 */
public var effect:String;


/**
 * 技能的对象选择（固定，随机）【固定就是按照排阵的位置打，随机就是随机指定打任意一个角色】
 */
public var choice:String;




/**
 * 技能使得，角色根骨值增加或者减少的值
 */
public function get def_up() : int
{
        return _anti["def_up"];
}
public function set def_up(value:int) : void
{
        _anti["def_up"] = value;
}


/**
 * 状态的持续回合数，0为无，1以上为持续的回合数
 */
public var status_time:int;


/**
 * 技能名称
 */
public function get skill_name() : String
{
        return _anti["skill_name"];
}
public function set skill_name(value:String) : void
{
        _anti["skill_name"] = value;
}


/**
 * 被技能打到会回复我方多元气（蓝）
 */
public function get mp_up() : Number
{
        return _anti["mp_up"];
}
public function set mp_up(value:Number) : void
{
        _anti["mp_up"] = value;
}


/**
 * 技能使得，角色外功值增加或者减少的值
 */
public function get atk_up() : int
{
        return _anti["atk_up"];
}
public function set atk_up(value:int) : void
{
        _anti["atk_up"] = value;
}


/**
 * 技能所释放的阵营（敌方，我方）
 */
public var camp:String;


/**
 * 该技能是否能造成混乱状态，0->否，1->是
 */
public var confusion_status:int;


/**
 * 技能使得，角色内功值增加或者减少的值
 */
public function get ats_up() : int
{
        return _anti["ats_up"];
}
public function set ats_up(value:int) : void
{
        _anti["ats_up"] = value;
}


/**
 * 技能的攻击范围(单体，群体)
 */
public function get range() : String
{
        return _anti["range"];
}
public function set range(value:String) : void
{
        _anti["range"] = value;
}


/**
 * 技能触发值
 */
public function get skill_point() : int
{
        return _anti["skill_point"];
}
public function set skill_point(value:int) : void
{
        _anti["skill_point"] = value;
}




/**
 * 技能拥有者
 * @return 
 * 
 */
public var master:String;
        
        public function Skill()
        {
            _anti = new Antiwear(new binaryEncrypt());
            


    _anti["adf_up"] = 0;
	

    _anti["hp_up"] = 0;
	

    _anti["damage_ratio"] = 0;


    _anti["evasion_up"] = 0;
	

    _anti["spd_up"] = 0;


    _anti["toughness_up"] = 0;


    _anti["hit_up"] = 0;


    _anti["skill_mp"] = 0;


    _anti["mp_down"] = 0;
	

    _anti["crit_up"] = 0;
	

    _anti["def_up"] = 0;


    _anti["skill_name"] = "";


    _anti["mp_up"] = 0;


    _anti["atk_up"] = 0;


    _anti["ats_up"] = 0;


    _anti["range"] = "";


    _anti["skill_point"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    Damage_time = data.@Damage_time


    adf_up = data.@adf_up


    choice_status_obj = data.@choice_status_obj


    asleep_status = data.@asleep_status


    syncope_status = data.@syncope_status


    hp_up = data.@hp_up


    id = data.@id


    damage_ratio = data.@damage_ratio


    drunk_status = data.@drunk_status


    evasion_up = data.@evasion_up


    item_name = data.@item_name


    description = data.@description


    chaos = data.@chaos


    poison = data.@poison


    spd_up = data.@spd_up


    toughness_up = data.@toughness_up


    poison_status = data.@poison_status


    hit_up = data.@hit_up


    skill_mp = data.@skill_mp


    type = data.@type


    item_number = data.@item_number


    mp_down = data.@mp_down


    lime_status = data.@lime_status


    fire = data.@fire


    crit_up = data.@crit_up


    effect = data.@effect


    choice = data.@choice


    water = data.@water


    def_up = data.@def_up


    status_time = data.@status_time


    skill_name = data.@skill_name


    mp_up = data.@mp_up


    atk_up = data.@atk_up


    camp = data.@camp


    confusion_status = data.@confusion_status


    ats_up = data.@ats_up


    range = data.@range


    skill_point = data.@skill_point


    common = data.@common
		
		
	master = data.@master

        }
        
        public function copy() : Skill
        {
            var target:Skill = new Skill();
            

    target.Damage_time = this.Damage_time;


    target.adf_up = this.adf_up;


    target.choice_status_obj = this.choice_status_obj;


    target.asleep_status = this.asleep_status;


    target.syncope_status = this.syncope_status;


    target.hp_up = this.hp_up;


    target.id = this.id;


    target.damage_ratio = this.damage_ratio;


    target.drunk_status = this.drunk_status;


    target.evasion_up = this.evasion_up;


    target.item_name = this.item_name;


    target.description = this.description;


    target.chaos = this.chaos;


    target.poison = this.poison;


    target.spd_up = this.spd_up;


    target.toughness_up = this.toughness_up;


    target.poison_status = this.poison_status;


    target.hit_up = this.hit_up;


    target.skill_mp = this.skill_mp;


    target.type = this.type;


    target.item_number = this.item_number;


    target.mp_down = this.mp_down;


    target.lime_status = this.lime_status;


    target.fire = this.fire;


    target.crit_up = this.crit_up;


    target.effect = this.effect;


    target.choice = this.choice;


    target.water = this.water;


    target.def_up = this.def_up;


    target.status_time = this.status_time;


    target.skill_name = this.skill_name;


    target.mp_up = this.mp_up;


    target.atk_up = this.atk_up;


    target.camp = this.camp;


    target.confusion_status = this.confusion_status;


    target.ats_up = this.ats_up;


    target.range = this.range;


    target.skill_point = this.skill_point;


    target.common = this.common;
	
	
	target.master = this.master;

            
            return target;
        }
    }
}
