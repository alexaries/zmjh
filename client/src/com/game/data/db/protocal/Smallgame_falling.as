
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Smallgame_falling extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 掉落物品的名字
 */
public function get item() : String
{
        return _anti["item"];
}
public function set item(value:String) : void
{
        _anti["item"] = value;
}


/**
 * 物品本身掉落的间隔时间
 */
public function get interval_time() : int
{
        return _anti["interval_time"];
}
public function set interval_time(value:int) : void
{
        _anti["interval_time"] = value;
}


/**
 * 
 */
public var id:int;


/**
 * 物品自身的掉落速度
 */
public function get speed() : Number
{
        return _anti["speed"];
}
public function set speed(value:Number) : void
{
        _anti["speed"] = value;
}


/**
 * 物品的掉落模式，0->直线;1->曲线
 */
public function get falling_mode() : int
{
        return _anti["falling_mode"];
}
public function set falling_mode(value:int) : void
{
        _anti["falling_mode"] = value;
}

        
        public function Smallgame_falling()
        {
            _anti = new Antiwear(new binaryEncrypt());
            
            

    _anti["item"] = "";


    _anti["interval_time"] = 0;


    _anti["speed"] = 0;


    _anti["falling_mode"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    item = data.@item


    interval_time = data.@interval_time


    id = data.@id


    speed = data.@speed


    falling_mode = data.@falling_mode

        }
        
        public function copy() : Smallgame_falling
        {
            var target:Smallgame_falling = new Smallgame_falling();
            

    target.item = this.item;


    target.interval_time = this.interval_time;


    target.id = this.id;


    target.speed = this.speed;


    target.falling_mode = this.falling_mode;

            
            return target;
        }
    }
}
