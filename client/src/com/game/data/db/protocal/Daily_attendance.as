
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Daily_attendance extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 获得骰子总数
 */
public function get dice() : int
{
        return _anti["dice"];
}
public function set dice(value:int) : void
{
        _anti["dice"] = value;
}


/**
 * 字段ID
 */
public var id:int;


/**
 * 天数
 */
public function get day() : int
{
        return _anti["day"];
}
public function set day(value:int) : void
{
        _anti["day"] = value;
}

        
        public function Daily_attendance()
        {
            _anti = new Antiwear(new binaryEncrypt());
            
            

    _anti["dice"] = 0;


    _anti["day"] = 0;

        }
       
        public function assign(data:XML) : void
        {
            

    dice = data.@dice


    id = data.@id


    day = data.@day

        }
        
        public function copy() : Daily_attendance
        {
            var target:Daily_attendance = new Daily_attendance();
            

    target.dice = this.dice;


    target.id = this.id;


    target.day = this.day;

            
            return target;
        }
    }
}
