
package com.game.data.db.protocal
{

    public class Level_up extends Object
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
 * 元气  元气增加的百分比
 */
public var mp:Number;

/**
 * 角色接下来每次升级所需要叠加的经验
 */
public var exp_add:int;

/**
 * ID
 */
public var id:int;

/**
 * 防御  防御增加的百分比
 */
public var def:Number;

/**
 * 角色1级升2级所需的经验
 */
public var basic_exp:int;
        
        public function Level_up()
        {

        }
       
        public function assign(data:XML) : void
        {
            

    name = data.@name


    hp = data.@hp


    atk = data.@atk


    mp = data.@mp


    exp_add = data.@exp_add


    id = data.@id


    def = data.@def


    basic_exp = data.@basic_exp

        }
        
        public function copy() : Level_up
        {
            var target:Level_up = new Level_up();
            

    target.name = this.name;


    target.hp = this.hp;


    target.atk = this.atk;


    target.mp = this.mp;


    target.exp_add = this.exp_add;


    target.id = this.id;


    target.def = this.def;


    target.basic_exp = this.basic_exp;

            
            return target;
        }
    }
}
