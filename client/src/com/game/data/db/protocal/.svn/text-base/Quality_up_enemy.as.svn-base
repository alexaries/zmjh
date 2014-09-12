
package com.game.data.db.protocal
{
    public class Quality_up_enemy extends Object
    {

/**
 * 精准 每次换色的增加值
 */
public var hit:int;

/**
 * 名称
 */
public var name:String;

/**
 * 灵活 每次换色的增加值
 */
public var evasion:int;

/**
 * 敌人每增加一个品级增加的金钱值
 */
public var money_add:int;

/**
 * 罡气 每次换色的增加值
 */
public var adf:int;

/**
 * 敌人每增加一个品级增加的战魂值
 */
public var soul_add:int;

/**
 * 内功 每次换色的增加值
 */
public var ats:int;

/**
 * 敌人每增加一个品级增加的经验
 */
public var exp_add:int;

/**
 * 暴击 每次换色的增加值
 */
public var crit:int;

/**
 * 步法  每次换色的增加值
 */
public var spd:int;

/**
 * ID
 */
public var id:int;

/**
 * 韧性 每次换色的增加值
 */
public var toughness:int;

        
        public function Quality_up_enemy()
        {
			
        }
       
        public function assign(data:XML) : void
        {
            

    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    money_add = data.@money_add


    adf = data.@adf


    soul_add = data.@soul_add


    ats = data.@ats


    exp_add = data.@exp_add


    crit = data.@crit


    spd = data.@spd


    id = data.@id


    toughness = data.@toughness

        }
        
        public function copy() : Quality_up_enemy
        {
            var target:Quality_up_enemy = new Quality_up_enemy();
            

    target.hit = this.hit;


    target.name = this.name;


    target.evasion = this.evasion;


    target.money_add = this.money_add;


    target.adf = this.adf;


    target.soul_add = this.soul_add;


    target.ats = this.ats;


    target.exp_add = this.exp_add;


    target.crit = this.crit;


    target.spd = this.spd;


    target.id = this.id;


    target.toughness = this.toughness;

            
            return target;
        }
    }
}
