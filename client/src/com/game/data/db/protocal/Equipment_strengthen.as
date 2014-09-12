
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

    public class Equipment_strengthen extends Object
    {
		private var _anti:Antiwear; 

/**
 * 初始强化金钱消耗
 */
//public var basic_money:int;
public function get basic_money() : int
{
	return _anti["basic_money"];
}
public function set basic_money(value:int) : void
{
	_anti["basic_money"] = value;
}


/**
 * 
 */
//public var equ_name:String;
public function get equ_name() : String
{
	return _anti["equ_name"];
}
public function set equ_name(value:String) : void
{
	_anti["equ_name"] = value;
}


/**
 * 强化时每级增加的金钱消耗
 */
//public var money_add:Number;
public function get money_add() : Number
{
	return _anti["money_add"];
}
public function set money_add(value:Number) : void
{
	_anti["money_add"] = value;
}

/**
 * 装备类别：武器,衣着,饰品
 */
public var type:String;

public var hp_fragment:String;

public var mp_fragment:String;

public var atk_fragment:String;

public var def_fragment:String;

public var spd_fragment:String;

public var eva_fragment:String;

public var crt_fragment:String;

//public var basic_soul:int;
public function get basic_soul() : int
{
	return _anti["basic_soul"];
}
public function set basic_soul(value:int) : void
{
	_anti["basic_soul"] = value;
}

//public var total_value:int;
public function get total_value() : int
{
	return _anti["total_value"];
}
public function set total_value(value:int) : void
{
	_anti["total_value"] = value;
}

/**
 * 
 */
public var id:int;

        
        public function Equipment_strengthen()
        {
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["basic_money"] = 0;
			_anti["equ_name"] = "";
			_anti["money_add"] = 0;
			_anti["basic_soul"] = 0;
			_anti["total_value"] = 0;
        }
       
        public function assign(data:XML) : void
        {
            

    basic_money = data.@basic_money


    equ_name = data.@equ_name


    money_add = data.@money_add


    type = data.@type


    id = data.@id
		
		
	hp_fragment = data.@hp_fragment
		
		
	mp_fragment = data.@mp_fragment
	
		
	atk_fragment = data.@atk_fragment
		
		
	def_fragment = data.@def_fragment
		
		
	spd_fragment = data.@spd_fragment
		
		
	eva_fragment = data.@eva_fragment
		
		
	crt_fragment = data.@crt_fragment

		
	basic_soul = data.@basic_soul
		
		
	total_value = data.@total_value
        }
        
        public function copy() : Equipment_strengthen
        {
            var target:Equipment_strengthen = new Equipment_strengthen();
            

    target.basic_money = this.basic_money;


    target.equ_name = this.equ_name;


    target.money_add = this.money_add;


    target.type = this.type;


    target.id = this.id;

	
	target.hp_fragment = this.hp_fragment;
	
	
	target.mp_fragment = this.mp_fragment;
	
	
	target.atk_fragment = this.atk_fragment;
	
	
	target.def_fragment = this.def_fragment;
	
	
	target.spd_fragment = this.spd_fragment;
	
	
	target.eva_fragment = this.eva_fragment;
	
	
	target.crt_fragment = this.crt_fragment;
	
	
	target.basic_soul = this.basic_soul;
	
	
	target.total_value = this.total_value;
            
            return target;
        }
    }
}
