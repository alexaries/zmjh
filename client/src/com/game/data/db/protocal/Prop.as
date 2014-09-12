
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Prop extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 道具信息
 * 
 */
public var message:String;


/**
 * 道具ID
 */
public var id:int;


/**
 * 关卡中获得道具的概率
 */
public var rate:Number;


/**
 * 道具名称
 */
public function get name() : String
{
        return _anti["name"];
}
public function set name(value:String) : void
{
        _anti["name"] = value;
}

public var coupon:int;

public var type:int;

public var restrict:int;
        
        public function Prop()
        {
            _anti = new Antiwear(new binaryEncrypt());


    _anti["name"] = "";

        }
       
        public function assign(data:XML) : void
        {
            

    message = data.@message


    id = data.@id


    rate = data.@rate


    name = data.@name
		
		
	coupon = data.@coupon
		
		
	type = data.@type
		
		
	restrict = data.@restrict

        }
        
        public function copy() : Prop
        {
            var target:Prop = new Prop();
            

    target.message = this.message;


    target.id = this.id;


    target.rate = this.rate;


    target.name = this.name;
	
	
	target.coupon = this.coupon;
	
	
	target.type = this.type;

	
	target.restrict = this.restrict;
            
            return target;
        }
    }
}
