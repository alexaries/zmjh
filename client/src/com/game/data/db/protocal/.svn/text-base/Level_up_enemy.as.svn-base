
package com.game.data.db.protocal
{

    public class Level_up_enemy extends Object
    {

/**
 * 名称
 */
public var name:String;


/**
 * 体力  体力增加的百分比
 */
public var hp:Number;

/**
 * 外功  外功增加的百分比
 */
public var atk:Number;

/**
 * 敌人每增加1级增加的金钱值
 */
public var money_add:int;

/**
 * 元气  元气增加的百分比
 */
public var mp:Number;

/**
 * 敌人每增加1级增加的经验值
 */
public var exp_add:Number;

/**
 * ID
 */
public var id:int;

/**
 * 防御  防御增加的百分比
 */
public var def:Number;

/**
 * 敌人每增加1级增加的战魂值
 */
public var soul_add:int;
        
        public function Level_up_enemy()
        {
			
        }
       
        public function assign(data:XML) : void
        {
            

    name = data.@name


    hp = data.@hp


    atk = data.@atk


    money_add = data.@money_add


    mp = data.@mp


    exp_add = data.@exp_add


    id = data.@id


    def = data.@def


    soul_add = data.@soul_add

        }
        
        public function copy() : Level_up_enemy
        {
            var target:Level_up_enemy = new Level_up_enemy();
            

    target.name = this.name;


    target.hp = this.hp;


    target.atk = this.atk;


    target.money_add = this.money_add;


    target.mp = this.mp;


    target.exp_add = this.exp_add;


    target.id = this.id;


    target.def = this.def;


    target.soul_add = this.soul_add;

            
            return target;
        }
    }
}
