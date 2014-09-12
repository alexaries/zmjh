
package com.game.data.db.protocal
{

    public class Status extends Object
    {

/**
 * 状态名称
 */
public var status_name:String;

/**
 * 水附加伤害的数值比例
 */
public var water_damage:Number;

/**
 * 
 */
public var id:int;

/**
 * 0->可以行动，1->不能行动
 */
public var can_act:int;

/**
 * 0->不会混乱，1->会混乱
 */
public var can_confusion:int;

/**
 * 0->不为毒，1->为毒
 */
public var can_poison:int;

/**
 * 减少的韧性值
 */
public var toughness_down:int;

/**
 * 减少的精准值
 */
public var hit_down:int;

/**
 * 火焰附加伤害的数值比例
 */
public var fire_damage:Number;

/**
 * 0->不会睡眠，1->会睡眠
 */
public var can_asleep:int;
        
        public function Status()
        {
			
        }
       
        public function assign(data:XML) : void
        {
            

    status_name = data.@status_name


    water_damage = data.@water_damage


    id = data.@id


    can_act = data.@can_act


    can_confusion = data.@can_confusion


    can_poison = data.@can_poison


    toughness_down = data.@toughness_down


    hit_down = data.@hit_down


    fire_damage = data.@fire_damage


    can_asleep = data.@can_asleep

        }
        
        public function copy() : Status
        {
            var target:Status = new Status();
            

    target.status_name = this.status_name;


    target.water_damage = this.water_damage;


    target.id = this.id;


    target.can_act = this.can_act;


    target.can_confusion = this.can_confusion;


    target.can_poison = this.can_poison;


    target.toughness_down = this.toughness_down;


    target.hit_down = this.hit_down;


    target.fire_damage = this.fire_damage;


    target.can_asleep = this.can_asleep;

            
            return target;
        }
    }
}
