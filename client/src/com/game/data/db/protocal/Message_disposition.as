
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

    public class Message_disposition extends Object
    {
		private var _anti:Antiwear;

/**
 * 装备获得的概率
 */
public var eq_rate:Number;

/**
 * 开启关卡条件，需要通过那些关卡，"|"线为分割线
 */
public var level_condition_pass:String;


/**
 * 开启关卡条件，需要队伍中的人拥有那些装备，"|"线为分割线
 */
public var level_condition_equipment:String;


/**
 * 开启关卡条件，需要队伍中角色的相应等级，"|"线为分割线
 */
public var level_condition_characters_lv:String;


/**
 * 过关后获得的装备
 */
//public var level_equipment:String;
public function get level_equipment() : String
{
	return _anti["level_equipment"];
}
public function set level_equipment(value:String) : void
{
	_anti["level_equipment"] = value;
}


/**
 * 开启关卡条件，需要身上分别的道具个数，"|"线为分割线
 */
public var level_condition_prop_number:String;


/**
 * 关卡的难度
 */
public var difficulty:int;


/**
 * 开启关卡条件，需要身上有什么道具，"|"线为分割线
 */
public var level_condition_prop:String;


/**
 * 开启关卡条件，需要队伍中有哪些角色，"|"线为分割线
 */
public var level_condition_characters:String;


/**
 * 关卡名
 */
public var level_name:String;


/**
 * 关卡的剧情信息
 */
public var level_message:String;


/**
 * 
 */
public var id:int;

        
        public function Message_disposition()
        {
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["level_equipment"] = "";
        }
       
        public function assign(data:XML) : void
        {
            

    eq_rate = data.@eq_rate


    level_condition_pass = data.@level_condition_pass


    level_condition_equipment = data.@level_condition_equipment


    level_condition_characters_lv = data.@level_condition_characters_lv


    level_equipment = data.@level_equipment


    level_condition_prop_number = data.@level_condition_prop_number


    difficulty = data.@difficulty


    level_condition_prop = data.@level_condition_prop


    level_condition_characters = data.@level_condition_characters


    level_name = data.@level_name


    level_message = data.@level_message


    id = data.@id

        }
        
        public function copy() : Message_disposition
        {
            var target:Message_disposition = new Message_disposition();
            

    target.eq_rate = this.eq_rate;


    target.level_condition_pass = this.level_condition_pass;


    target.level_condition_equipment = this.level_condition_equipment;


    target.level_condition_characters_lv = this.level_condition_characters_lv;


    target.level_equipment = this.level_equipment;


    target.level_condition_prop_number = this.level_condition_prop_number;


    target.difficulty = this.difficulty;


    target.level_condition_prop = this.level_condition_prop;


    target.level_condition_characters = this.level_condition_characters;


    target.level_name = this.level_name;


    target.level_message = this.level_message;


    target.id = this.id;

            
            return target;
        }
    }
}
