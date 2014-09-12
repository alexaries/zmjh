
package com.game.data.db.protocal
{

    public class Exclusive_equipment extends Object
    {    

/**
 * 内功增加值
 */
public var ats:int;

/**
 * 精准增加值
 */
public var hit:int;

/**
 * 装备名称
 */
public var name:String;

/**
 * 灵活增加值
 */
public var evasion:int;

/**
 * 步法增加值
 */
public var spd:int;

/**
 * 体力增加值
 */
public var hp:int;

/**
 * 外功增加值
 */
public var atk:int;

/**
 * 罡气增加值
 */
public var adf:int;

/**
 * 专属角色名
 */
public var exclusive_character:String;

/**
 * 元气增加值
 */
public var mp:int;

/**
 * 暴击增加值
 */
public var crit:int;

/**
 * 装备类别：0->武器 1->衣着 2->饰品
 */
public var type:int;

/**
 * ID
 */
public var id:int;

/**
 * 防御增加值
 */
public var def:int;

/**
 * 韧性增加值
 */
public var toughness:int;

        
        public function Exclusive_equipment()
        {
			
        }
       
        public function assign(data:XML) : void
        {
            

    ats = data.@ats


    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    spd = data.@spd


    hp = data.@hp


    atk = data.@atk


    adf = data.@adf


    exclusive_character = data.@exclusive_character


    mp = data.@mp


    crit = data.@crit


    type = data.@type


    id = data.@id


    def = data.@def


    toughness = data.@toughness

        }
        
        public function copy() : Exclusive_equipment
        {
            var target:Exclusive_equipment = new Exclusive_equipment();
            

    target.ats = this.ats;


    target.hit = this.hit;


    target.name = this.name;


    target.evasion = this.evasion;


    target.spd = this.spd;


    target.hp = this.hp;


    target.atk = this.atk;


    target.adf = this.adf;


    target.exclusive_character = this.exclusive_character;


    target.mp = this.mp;


    target.crit = this.crit;


    target.type = this.type;


    target.id = this.id;


    target.def = this.def;


    target.toughness = this.toughness;

            
            return target;
        }
    }
}
