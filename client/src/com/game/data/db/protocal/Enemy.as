
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

    public class Enemy extends BaseRole
    {
		/**
		 * 角色在简单难度下的掉率
		 */
		public function get join_rate() : Number
		{
			return _anti["join_rate"];
		}
		public function set join_rate(value:Number) : void
		{
			_anti["join_rate"] = value;
		}
		
		/**
		 * 专属角色
		 */
		public function get fixedskill_name() : String
		{
			return _anti["fixedskill_name"];
		}
		public function set fixedskill_name(value:String) : void
		{
			_anti["fixedskill_name"] = value;
		}
		
		/**
		 * 打死获得的金钱
		 */
		public function get money() : int
		{
			return _anti["money"];
		}
		public function set money(value:int) : void
		{
			_anti["money"] = value;
		}
		
		/**
		 * 打死获得的战魂
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
		 * 打死获得的经验值
		 */
		public function get exp() : int
		{
			return _anti["exp"];
		}
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		/**
		 * 角色在困难下的掉率
		 */
		public function get join_rate_hard() : Number
		{
			return _anti["join_rate_hard"];
		}
		public function set join_rate_hard(value:Number) : void
		{
			_anti["join_rate_hard"] = value;
		}
        
		private var _anti:Antiwear;
		
        public function Enemy()
        {
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["join_rate_hard"] = 0;
			_anti["join_rate"] = 0;
			_anti["exp"] = 0;
			_anti["soul"] = 0;
			_anti["money"] = 0;
			_anti["fixedskill_name"] = '';
        }
       
        public function assign(data:XML) : void
        {
            
    toughness = data.@toughness


    money = data.@money


    soul = data.@soul


    atk_point = data.@atk_point


    crit = data.@crit


    spd = data.@spd


    id = data.@id


    join_rate = data.@join_rate
		
	join_rate_hard = data.@join_rate_hard


    lv = data.@lv


    evasion = data.@evasion


    adf = data.@adf


    fixedskill_name = data.@fixedskill_name


    mp = data.@mp


    hit = data.@hit


    hp = data.@hp


    crit_rate = data.@crit_rate


    block_rate = data.@block_rate


    name = data.@name


    gender = data.@gender


    atk = data.@atk


    evasion_rate = data.@evasion_rate


    ats = data.@ats


    exp = data.@exp


    def = data.@def

        }
        
        public function copy() : Enemy
        {
            var target:Enemy = new Enemy();
            

    target.toughness = this.toughness;


    target.money = this.money;


    target.soul = this.soul;


    target.atk_point = this.atk_point;


    target.crit = this.crit;


    target.spd = this.spd;


    target.id = this.id;


    target.join_rate = this.join_rate;
	
	target.join_rate_hard = this.join_rate_hard;


    target.lv = this.lv;


    target.evasion = this.evasion;


    target.adf = this.adf;


    target.fixedskill_name = this.fixedskill_name;


    target.mp = this.mp;


    target.hit = this.hit;


    target.hp = this.hp;


    target.crit_rate = this.crit_rate;


    target.block_rate = this.block_rate;


    target.name = this.name;


    target.gender = this.gender;


    target.atk = this.atk;


    target.evasion_rate = this.evasion_rate;


    target.ats = this.ats;


    target.exp = this.exp;


    target.def = this.def;

            
            return target;
        }
    }
}
