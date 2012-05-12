/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - BradenScaleDTO.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_BradenScaleDTO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _BradenScaleDTOEntityMetadata;
    model_internal var _changedObjects:mx.collections.ArrayCollection = new ArrayCollection();

    public function getChangedObjects() : Array
    {
        _changedObjects.addItemAt(this,0);
        return _changedObjects.source;
    }

    public function clearChangedObjects() : void
    {
        _changedObjects.removeAll();
    }

    /**
     * properties
     */
    private var _internal_b1SENSRY : String;
    private var _internal_b2MOBLTY : String;
    private var _internal_b3MSTURE : String;
    private var _internal_b4ACTVTY : String;
    private var _internal_b5NUTRTN : String;
    private var _internal_b6FRCTSH : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_BradenScaleDTO()
    {
        _model = new _BradenScaleDTOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get b1SENSRY() : String
    {
        return _internal_b1SENSRY;
    }

    [Bindable(event="propertyChange")]
    public function get b2MOBLTY() : String
    {
        return _internal_b2MOBLTY;
    }

    [Bindable(event="propertyChange")]
    public function get b3MSTURE() : String
    {
        return _internal_b3MSTURE;
    }

    [Bindable(event="propertyChange")]
    public function get b4ACTVTY() : String
    {
        return _internal_b4ACTVTY;
    }

    [Bindable(event="propertyChange")]
    public function get b5NUTRTN() : String
    {
        return _internal_b5NUTRTN;
    }

    [Bindable(event="propertyChange")]
    public function get b6FRCTSH() : String
    {
        return _internal_b6FRCTSH;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set b1SENSRY(value:String) : void
    {
        var oldValue:String = _internal_b1SENSRY;
        if (oldValue !== value)
        {
            _internal_b1SENSRY = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b1SENSRY", oldValue, _internal_b1SENSRY));
        }
    }

    public function set b2MOBLTY(value:String) : void
    {
        var oldValue:String = _internal_b2MOBLTY;
        if (oldValue !== value)
        {
            _internal_b2MOBLTY = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b2MOBLTY", oldValue, _internal_b2MOBLTY));
        }
    }

    public function set b3MSTURE(value:String) : void
    {
        var oldValue:String = _internal_b3MSTURE;
        if (oldValue !== value)
        {
            _internal_b3MSTURE = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b3MSTURE", oldValue, _internal_b3MSTURE));
        }
    }

    public function set b4ACTVTY(value:String) : void
    {
        var oldValue:String = _internal_b4ACTVTY;
        if (oldValue !== value)
        {
            _internal_b4ACTVTY = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b4ACTVTY", oldValue, _internal_b4ACTVTY));
        }
    }

    public function set b5NUTRTN(value:String) : void
    {
        var oldValue:String = _internal_b5NUTRTN;
        if (oldValue !== value)
        {
            _internal_b5NUTRTN = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b5NUTRTN", oldValue, _internal_b5NUTRTN));
        }
    }

    public function set b6FRCTSH(value:String) : void
    {
        var oldValue:String = _internal_b6FRCTSH;
        if (oldValue !== value)
        {
            _internal_b6FRCTSH = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "b6FRCTSH", oldValue, _internal_b6FRCTSH));
        }
    }

    /**
     * Data/source property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _BradenScaleDTOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _BradenScaleDTOEntityMetadata) : void
    {
        var oldValue : _BradenScaleDTOEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }


}

}
