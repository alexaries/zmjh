
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

    public class Battle_disposition extends Object
    {
        

/**
 * 精英怪物等级
 */
public var elite_grade:String;

/**
 * BOSS出场名单
 */
public var boss_name:String;

/**
 * BOSS等级
 */
public var boss_grade:String;


/**
 * 敌人中坚位置的出场概率
 */
public var second_in:Number;


/**
 * 敌人先锋位置的出场概率
 */
public var first_in:Number;


/**
 * 敌人在该关卡最低等级
 */
public var lowest_grade:int;


/**
 * 敌人大将位置的出场概率
 */
public var third_in:Number;


/**
 * 关卡出场的所有敌方角色
 */
public var enemy_name:String;

/**
 * 
 */
public var id:int;

/**
 * 
 */
public var difficulty:int;

/**
 * 精英怪物出场名单
 */
public var elite_name:String;


/**
 * BOSS掉落的角色
 */
//public var boss_character:String;
public function get boss_character() : String
{
	return _anti["boss_character"];
}
public function set boss_character(value:String) : void
{
	_anti["boss_character"] = value;
}


/**
 * 关卡名
 */
public var level_name:String;


/**
 * 敌人在该关卡最高等级
 */
public var highest_grade:int;


/**
 * BOSS掉落角色的概率
 */
//public var boss_character_rate:Number;
public function get boss_character_rate() : Number
{
	return _anti["boss_character_rate"];
}
public function set boss_character_rate(value:Number) : void
{
	_anti["boss_character_rate"] = value;
}

public var night_enemy_name:String;

public var rain_enemy_name:String;

public var thunder_enemy_name:String;

public var wind_enemy_name:String;

private var _anti:Antiwear;

        public function Battle_disposition()
        {
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["boss_character"] = "";
			_anti["boss_character_rate"] = 0;
        }
       
        public function assign(data:XML) : void
        {
            

    elite_grade = data.@elite_grade


    boss_name = data.@boss_name


    boss_grade = data.@boss_grade


    second_in = data.@second_in


    first_in = data.@first_in


    lowest_grade = data.@lowest_grade


    third_in = data.@third_in


    enemy_name = data.@enemy_name


    id = data.@id


    difficulty = data.@difficulty


    elite_name = data.@elite_name


    boss_character = data.@boss_character


    level_name = data.@level_name


    highest_grade = data.@highest_grade


    boss_character_rate = data.@boss_character_rate
		
		
	night_enemy_name = data.@night_enemy_name
		
		
	rain_enemy_name = data.@rain_enemy_name
		
	
	thunder_enemy_name = data.@thunder_enemy_name
		
		
	wind_enemy_name = data.@wind_enemy_name

        }
        
        public function copy() : Battle_disposition
        {
            var target:Battle_disposition = new Battle_disposition();
            

    target.elite_grade = this.elite_grade;


    target.boss_name = this.boss_name;


    target.boss_grade = this.boss_grade;


    target.second_in = this.second_in;


    target.first_in = this.first_in;


    target.lowest_grade = this.lowest_grade;


    target.third_in = this.third_in;


    target.enemy_name = this.enemy_name;


    target.id = this.id;


    target.difficulty = this.difficulty;


    target.elite_name = this.elite_name;


    target.boss_character = this.boss_character;


    target.level_name = this.level_name;


    target.highest_grade = this.highest_grade;


    target.boss_character_rate = this.boss_character_rate;

	
	target.night_enemy_name = this.night_enemy_name;
	
	
	target.rain_enemy_name = this.rain_enemy_name;
	
	
	target.thunder_enemy_name = this.thunder_enemy_name;
	
	
	target.wind_enemy_name = this.wind_enemy_name;
            
            return target;
        }
    }
}
