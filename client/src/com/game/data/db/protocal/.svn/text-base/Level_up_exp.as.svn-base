
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Level_up_exp extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 该等级学到的技能
 */
public var skill_id:int;


/**
 * 该等级角色任务获得经验
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
 * 该等级角色任务获得战魂
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
 * 该等级获得的道具
 */
public var prop:String;


/**
 * 角色等级
 */
public var lv:int;


/**
 * 该等级骰子卖多少钱
 */
public function get Dice_value() : int
{
        return _anti["Dice_value"];
}
public function set Dice_value(value:int) : void
{
        _anti["Dice_value"] = value;
}


/**
 * 角色升级所需经验
 */
public function get exp() : int
{
        return _anti["exp"];
}
public function set exp(value:int) : void
{
        _anti["exp"] = value;
}

public function get exp_3hours() : int
{
	return _anti["exp_3hours"];
}
public function set exp_3hours(value:int) : void
{
	_anti["exp_3hours"] = value;
}

public function get exp_12hours() : int
{
	return _anti["exp_12hours"];
}
public function set exp_12hours(value:int) : void
{
	_anti["exp_12hours"] = value;
}

        
        public function Level_up_exp()
        {
            _anti = new Antiwear(new binaryEncrypt());
            


    _anti["gold"] = 0;


    _anti["soul"] = 0;


    _anti["Dice_value"] = 0;


    _anti["exp"] = 0;
	
	
	_anti["exp_3hours"] = 0;
	
	
	_anti["exp_12hours"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    skill_id = data.@skill_id


    gold = data.@gold


    soul = data.@soul


    prop = data.@prop


    lv = data.@lv


    Dice_value = data.@Dice_value


    exp = data.@exp
		
		
	exp_3hours = data.@exp_3hours
		
		
	exp_12hours = data.@exp_12hours

        }
        
        public function copy() : Level_up_exp
        {
            var target:Level_up_exp = new Level_up_exp();
            

    target.skill_id = this.skill_id;


    target.gold = this.gold;


    target.soul = this.soul;


    target.prop = this.prop;


    target.lv = this.lv;


    target.Dice_value = this.Dice_value;


    target.exp = this.exp;
	
	
	target.exp_3hours = this.exp_3hours;
	
	
	target.exp_12hours = this.exp_12hours;

            
            return target;
        }
    }
}
