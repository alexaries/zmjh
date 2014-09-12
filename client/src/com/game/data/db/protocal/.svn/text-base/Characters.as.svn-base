
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

    public class Characters extends BaseRole
    {
		private var _anti:Antiwear;
/**
 * 好感度
 */
public var likability:int;
/**
 * 专属技能 
 */
//public var fixedskill_name:String;
public function get fixedskill_name() : String
{
	return _anti["fixedskill_name"];
}
public function set fixedskill_name(value:String) : void
{
	_anti["fixedskill_name"] = value;
}

/**
 *  角色的资质
 */
public var qualifications:String;

public var skill_info:String;

public var location:String;

public var quality:int;

public var token:int;

public var synthetic:String;

public var info:String;

public var get_place:String;

public var type:int;
        
        public function Characters()
        {
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["fixedskill_name"] = "";
			
        }
       
        public function assign(data:XML) : void
        {
            

    adf = data.@adf


    block_rate = data.@block_rate


    hit = data.@hit


    name = data.@name


    evasion = data.@evasion


    gender = data.@gender


    hp = data.@hp


    atk = data.@atk


    evasion_rate = data.@evasion_rate


    lv = data.@lv


    crit_rate = data.@crit_rate


    ats = data.@ats


    atk_point = data.@atk_point


    mp = data.@mp


    crit = data.@crit


    spd = data.@spd


    likability = data.@likability


    id = data.@id


    def = data.@def


    toughness = data.@toughness
		
	fixedskill_name = data.@fixedskill_name;
	qualifications = data.@qualifications;
	
	location = data.@location;
	
	skill_info = data.@skill_info;
	
	grade = data.@grade;
		
	quality = data.@quality;
	
	token = data.@token;
	
	synthetic = data.@synthetic;
	
	info = data.@info;
	
	get_place = data.@get_place;
	
	type = data.@type;
	
	/*hp_compose = data.@hp_compose;
	mp_compose = data.@mp_compose;
	atk_compose = data.@atk_compose;
	def_compose = data.@def_compose;
	spd_compose = data.@spd_compose;
	evasion_compose = data.@evasion_compose;
	crit_compose = data.@crit_compose;*/
        }
    }
}
