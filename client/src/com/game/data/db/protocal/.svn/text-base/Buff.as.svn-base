
package com.game.data.db.protocal
{
	public class Buff extends Object
	{
		
		
		/**
		 * 精准增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var hit:Number;
		
		
		/**
		 * 状态名称
		 */
		public var name:String;
		
		
		/**
		 * 灵活增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var evasion:Number;
		
		
		/**
		 * 体力增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var hp:Number;
		
		
		/**
		 * 金钱增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var morny:Number;
		
		
		/**
		 * 外功增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var atk:Number;
		
		
		/**
		 * 罡气增加或者减少的比百分比，没符号的为增加，-的为减少
		 */
		public var adf:Number;
		
		
		/**
		 * 内功增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var ats:Number;
		
		
		/**
		 * 元气增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var mp:Number;
		
		
		/**
		 * 经验值增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var exp:Number;
		
		
		/**
		 * 暴击增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var crit:Number;
		
		
		/**
		 * 步法增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var spd:Number;
		
		
		/**
		 * ID
		 */
		public var id:int;
		
		
		/**
		 * 防御增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var def:Number;
		
		
		/**
		 * 韧性增加或者减少的百分比，没符号的为增加，-的为减少
		 */
		public var toughness:Number;
		
		
		public function Buff()
		{
			
		}
		
		public function assign(data:XML) : void
		{
			
			
			hit = data.@hit
			
			
			name = data.@name
			
			
			evasion = data.@evasion
			
			
			hp = data.@hp
			
			
			morny = data.@morny
			
			
			atk = data.@atk
			
			
			adf = data.@adf
			
			
			ats = data.@ats
			
			
			mp = data.@mp
			
			
			exp = data.@exp
			
			
			crit = data.@crit
			
			
			spd = data.@spd
			
			
			id = data.@id
			
			
			def = data.@def
			
			
			toughness = data.@toughness
			
		}
		
		public function copy() : Buff
		{
			var target:Buff = new Buff();
			
			
			target.hit = this.hit;
			
			
			target.name = this.name;
			
			
			target.evasion = this.evasion;
			
			
			target.hp = this.hp;
			
			
			target.morny = this.morny;
			
			
			target.atk = this.atk;
			
			
			target.adf = this.adf;
			
			
			target.ats = this.ats;
			
			
			target.mp = this.mp;
			
			
			target.exp = this.exp;
			
			
			target.crit = this.crit;
			
			
			target.spd = this.spd;
			
			
			target.id = this.id;
			
			
			target.def = this.def;
			
			
			target.toughness = this.toughness;
			
			
			return target;
		}
	}
}
