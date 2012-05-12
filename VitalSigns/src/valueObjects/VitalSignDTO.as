/**
 * This is a generated sub-class of _VitalSignDTO.as and is intended for behavior
 * customization.  This class is only generated when there is no file already present
 * at its target location.  Thus custom behavior that you add here will survive regeneration
 * of the super-class. 
 *
 * NOTE: Do not manually modify the RemoteClass mapping unless
 * your server representation of this class has changed and you've 
 * updated your ActionScriptGeneration,RemoteClass annotation on the
 * corresponding entity 
 **/ 
 
package valueObjects
{

import com.adobe.fiber.core.model_internal;

import domain.DTO.IDataTransferObject;

public class VitalSignDTO extends _Super_VitalSignDTO implements IDataTransferObject
{
	private var _value1:String;
	private var _value2:String;
	private var _type1:String;
	private var _type2:String
	private var _unit1:String;
	private var _unit2:String;
	
	private var _intDate:Number;
	
	[Bindable]
	public function get unit2():String
	{
		return _unit2;
	}
	
	public function set unit2(value:String):void
	{
		_unit2 = value;
	}
	
	public function get intDate():Number
	{
		return _intDate;
	}
	
	public function set intDate(value:Number):void
	{
		_intDate = value;
	}
	
	[Bindable]
	public function get unit1():String
	{
		return _unit1;
	}
	
	public function set unit1(value:String):void
	{
		_unit1 = value;
	}
	
	[Bindable]
	public function get type2():String
	{
		return _type2;
	}
	
	public function set type2(value:String):void
	{
		_type2 = value;
	}
	
	[Bindable]
	public function get type1():String
	{
		return _type1;
	}
	
	public function set type1(value:String):void
	{
		_type1 = value;
	}
	
	[Bindable]
	public function get value1():String
	{
		return _value1;
	}
	
	public function set value1(value:String):void
	{
		_value1 = value;
	}
	
	[Bindable]
	public function get value2():String
	{
		return _value2;
	}
	
	public function set value2(value:String):void
	{
		_value2 = value;
	}
	
    /** 
     * DO NOT MODIFY THIS STATIC INITIALIZER - IT IS NECESSARY
     * FOR PROPERLY SETTING UP THE REMOTE CLASS ALIAS FOR THIS CLASS
     *
     **/
     
    /**
     * Calling this static function will initialize RemoteClass aliases
     * for this value object as well as all of the value objects corresponding
     * to entities associated to this value object's entity.  
     */     
    public static function _initRemoteClassAlias() : void
    {
        _Super_VitalSignDTO.model_internal::initRemoteClassAliasSingle(valueObjects.VitalSignDTO);
        _Super_VitalSignDTO.model_internal::initRemoteClassAliasAllRelated();
    }
     
    model_internal static function initRemoteClassAliasSingleChild() : void
    {
        _Super_VitalSignDTO.model_internal::initRemoteClassAliasSingle(valueObjects.VitalSignDTO);
    }
    
    {
        _Super_VitalSignDTO.model_internal::initRemoteClassAliasSingle(valueObjects.VitalSignDTO);
    }
    /** 
     * END OF DO NOT MODIFY SECTION
     *
     **/    
}

}