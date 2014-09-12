
package com.game.data.db.protocal
{
    import com.edgarcai.encrypt.binaryEncrypt;
    import com.edgarcai.gamelogic.Antiwear;
        
    public class Smallgame_card extends Object
    {
        private var _anti:Antiwear;
        
        

/**
 * 
 */
public var id:int;


/**
 * 翻开角色可获得的经验
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
 * 角色名字
 */
public function get name() : String
{
        return _anti["name"];
}
public function set name(value:String) : void
{
        _anti["name"] = value;
}

        
        public function Smallgame_card()
        {
            _anti = new Antiwear(new binaryEncrypt());
            


    _anti["exp"] = 0;


    _anti["name"] = "";

        }
       
        public function assign(data:XML) : void
        {
            

    id = data.@id


    exp = data.@exp


    name = data.@name

        }
        
        public function copy() : Smallgame_card
        {
            var target:Smallgame_card = new Smallgame_card();
            

    target.id = this.id;


    target.exp = this.exp;


    target.name = this.name;

            
            return target;
        }
    }
}
