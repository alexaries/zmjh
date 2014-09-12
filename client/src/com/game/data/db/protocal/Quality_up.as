
package com.game.data.db.protocal
{

    public class Quality_up extends Object
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
 * 罡气 每次换色的增加值
 */
public var adf:int;

/**
 * 内功 每次换色的增加值
 */
public var ats:int;

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

        
        public function Quality_up()
        {
			
        }
       
        public function assign(data:XML) : void
        {
            

    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    adf = data.@adf


    ats = data.@ats


    crit = data.@crit


    spd = data.@spd


    id = data.@id


    toughness = data.@toughness

        }
        
        public function copy() : Quality_up
        {
            var target:Quality_up = new Quality_up();
            

    target.hit = this.hit;


    target.name = this.name;


    target.evasion = this.evasion;


    target.adf = this.adf;


    target.ats = this.ats;


    target.crit = this.crit;


    target.spd = this.spd;


    target.id = this.id;


    target.toughness = this.toughness;

            
            return target;
        }
    }
}
