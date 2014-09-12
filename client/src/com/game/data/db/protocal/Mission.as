
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Mission extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 奖励的骰子数
 */
public function get dice() : int
{
        return _anti["dice"];
}
public function set dice(value:int) : void
{
        _anti["dice"] = value;
}


/**
 * 获得金钱
 */
public function get gold() : int
{
        return _anti["gold"];
}
public function set gold(value:int) : void
{
        _anti["gold"] = value;
}


/**
 * 任务条件-敌人名称
 */
public var mission_rules_enemy:String;


/**
 * 获得战魂
 */
public function get soul() : int
{
        return _anti["soul"];
}
public function set soul(value:int) : void
{
        _anti["soul"] = value;
}


/**
 * 任务条件-敌人数量
 */
public var mission_rules_number:String;


/**
 * 获得道具  1代表如意骰子，2代表满汉全席，3代表雪山人参。”|“后面的数字表示获得个数
 */
public var prop:String;


/**
 * 奖励的装备。”|“前的数字表示装备等级，”|“的表示装备的颜色品级
 */
public var equipment:String;


/**
 * 任务名字
 */
public function get mission_name() : String
{
        return _anti["mission_name"];
}
public function set mission_name(value:String) : void
{
        _anti["mission_name"] = value;
}


/**
 * 
 */
public var id:int;


/**
 * 任务描述
 */
public var mission_description:String;

public var order:int;

        
        public function Mission()
        {
            _anti = new Antiwear(new binaryEncrypt());
            
            

    _anti["dice"] = 0;


    _anti["gold"] = 0;


    _anti["soul"] = 0;


    _anti["mission_name"] = "";

        }
       
        public function assign(data:XML) : void
        {
            

    dice = data.@dice


    gold = data.@gold


    mission_rules_enemy = data.@mission_rules_enemy


    soul = data.@soul


    mission_rules_number = data.@mission_rules_number


    prop = data.@prop


    equipment = data.@equipment


    mission_name = data.@mission_name


    id = data.@id


    mission_description = data.@mission_description
		
		
	order = data.@order

        }
        
        public function copy() : Mission
        {
            var target:Mission = new Mission();
            

    target.dice = this.dice;


    target.gold = this.gold;


    target.mission_rules_enemy = this.mission_rules_enemy;


    target.soul = this.soul;


    target.mission_rules_number = this.mission_rules_number;


    target.prop = this.prop;


    target.equipment = this.equipment;


    target.mission_name = this.mission_name;


    target.id = this.id;


    target.mission_description = this.mission_description;
	
	
	target.order = this.order;

            
            return target;
        }
    }
}
