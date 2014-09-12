
package com.game.data.db.protocal
{
        
    public class Item_disposition extends Object
    {
        
        

/**
 * 掉落战斗时掉落的暗器的名称，用竖线隔开
 */
public var missiles:String;


/**
 * 关卡名称
 */
public var name:String;


/**
 * boss掉落的装备品级
 */
public var boss_equ_quality:String;


/**
 * 开金币时1金币的牌出现的概率
 */
public var gold_rate1:Number;


/**
 * 开宝箱时装备的掉落品级，用竖线分开
 */
public var equiment_quality:String;


/**
 * 开宝箱时相对应的等级掉落的概率，用竖线分开
 */
public var equ_gra_rate:String;


/**
 * 开金币时100金币的牌出现的概率
 */
public var gold_rate100:Number;


/**
 * 开宝箱时相对应的品级掉落的概率，用竖线分开
 */
public var equ_qua_rate:String;


/**
 * 开金币时10金币的牌出现的概率
 */
public var gold_rate1000:Number;


/**
 * 关卡的难度
 */
public var difficulty:String;


/**
 * 暗器掉落的最多数量
 */
public var missiles_number:int;


/**
 * 开宝箱时装备的掉落等级，用竖线分开
 */
public var equiment_grade:String;


/**
 * boss掉落的装备等级
 */
public var boss_equ_grade:int;


/**
 * 关卡名
 */
public var level_name:String;


/**
 * 开金币时10金币的牌出现的概率
 */
public var gold_rate10:Number;

/**
 * 
 */
public var id:int;


/**
 * boss掉落装备的概率
 */
public var boss_equ_rate:Number;

/**
 * 开金币时2000金币的牌出现的概率
 */
public var gold_rate2000:Number;

        
        public function Item_disposition()
        {

        }
       
        public function assign(data:XML) : void
        {
            

    missiles = data.@missiles


    name = data.@name


    boss_equ_quality = data.@boss_equ_quality


    gold_rate1 = data.@gold_rate1


    equiment_quality = data.@equiment_quality


    equ_gra_rate = data.@equ_gra_rate


    gold_rate100 = data.@gold_rate100


    equ_qua_rate = data.@equ_qua_rate


    gold_rate1000 = data.@gold_rate1000


    difficulty = data.@difficulty


    missiles_number = data.@missiles_number


    equiment_grade = data.@equiment_grade


    boss_equ_grade = data.@boss_equ_grade


    level_name = data.@level_name


    gold_rate10 = data.@gold_rate10


    id = data.@id


    boss_equ_rate = data.@boss_equ_rate
		
		
	gold_rate2000 = data.@gold_rate2000

        }
        
        public function copy() : Item_disposition
        {
            var target:Item_disposition = new Item_disposition();
            

    target.missiles = this.missiles;


    target.name = this.name;


    target.boss_equ_quality = this.boss_equ_quality;


    target.gold_rate1 = this.gold_rate1;


    target.equiment_quality = this.equiment_quality;


    target.equ_gra_rate = this.equ_gra_rate;


    target.gold_rate100 = this.gold_rate100;


    target.equ_qua_rate = this.equ_qua_rate;


    target.gold_rate1000 = this.gold_rate1000;


    target.difficulty = this.difficulty;


    target.missiles_number = this.missiles_number;


    target.equiment_grade = this.equiment_grade;


    target.boss_equ_grade = this.boss_equ_grade;


    target.level_name = this.level_name;


    target.gold_rate10 = this.gold_rate10;


    target.id = this.id;


    target.boss_equ_rate = this.boss_equ_rate;
	
	
	target.gold_rate2000 = this.gold_rate2000;

            
            return target;
        }
    }
}
