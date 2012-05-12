/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - LabListDTO.as.
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
public class _Super_LabListDTO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _LabListDTOEntityMetadata;
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
    private var _internal_collectedDate : Date;
    private var _internal_encounterID : Number;
    private var _internal_fillerNumber : String;
    private var _internal_genLabType : String;
    private var _internal_pid : Number;
    private var _internal_rangeIndicator : String;
    private var _internal_rangeReference : String;
    private var _internal_result : String;
    private var _internal_resultDate : Date;
    private var _internal_resultUnit : String;
    private var _internal_servTypeChildAcro : String;
    private var _internal_servTypeChildLongDesc : String;
    private var _internal_servTypeRootAcro : String;
    private var _internal_sid : Number;
    private var _internal_sortChildSeq : String;
    private var _internal_state : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_LabListDTO()
    {
        _model = new _LabListDTOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get collectedDate() : Date
    {
        return _internal_collectedDate;
    }

    [Bindable(event="propertyChange")]
    public function get encounterID() : Number
    {
        return _internal_encounterID;
    }

    [Bindable(event="propertyChange")]
    public function get fillerNumber() : String
    {
        return _internal_fillerNumber;
    }

    [Bindable(event="propertyChange")]
    public function get genLabType() : String
    {
        return _internal_genLabType;
    }

    [Bindable(event="propertyChange")]
    public function get pid() : Number
    {
        return _internal_pid;
    }

    [Bindable(event="propertyChange")]
    public function get rangeIndicator() : String
    {
        return _internal_rangeIndicator;
    }

    [Bindable(event="propertyChange")]
    public function get rangeReference() : String
    {
        return _internal_rangeReference;
    }

    [Bindable(event="propertyChange")]
    public function get result() : String
    {
        return _internal_result;
    }

    [Bindable(event="propertyChange")]
    public function get resultDate() : Date
    {
        return _internal_resultDate;
    }

    [Bindable(event="propertyChange")]
    public function get resultUnit() : String
    {
        return _internal_resultUnit;
    }

    [Bindable(event="propertyChange")]
    public function get servTypeChildAcro() : String
    {
        return _internal_servTypeChildAcro;
    }

    [Bindable(event="propertyChange")]
    public function get servTypeChildLongDesc() : String
    {
        return _internal_servTypeChildLongDesc;
    }

    [Bindable(event="propertyChange")]
    public function get servTypeRootAcro() : String
    {
        return _internal_servTypeRootAcro;
    }

    [Bindable(event="propertyChange")]
    public function get sid() : Number
    {
        return _internal_sid;
    }

    [Bindable(event="propertyChange")]
    public function get sortChildSeq() : String
    {
        return _internal_sortChildSeq;
    }

    [Bindable(event="propertyChange")]
    public function get state() : String
    {
        return _internal_state;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set collectedDate(value:Date) : void
    {
        var oldValue:Date = _internal_collectedDate;
        if (oldValue !== value)
        {
            _internal_collectedDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "collectedDate", oldValue, _internal_collectedDate));
        }
    }

    public function set encounterID(value:Number) : void
    {
        var oldValue:Number = _internal_encounterID;
        if (oldValue !== value)
        {
            _internal_encounterID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "encounterID", oldValue, _internal_encounterID));
        }
    }

    public function set fillerNumber(value:String) : void
    {
        var oldValue:String = _internal_fillerNumber;
        if (oldValue !== value)
        {
            _internal_fillerNumber = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fillerNumber", oldValue, _internal_fillerNumber));
        }
    }

    public function set genLabType(value:String) : void
    {
        var oldValue:String = _internal_genLabType;
        if (oldValue !== value)
        {
            _internal_genLabType = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "genLabType", oldValue, _internal_genLabType));
        }
    }

    public function set pid(value:Number) : void
    {
        var oldValue:Number = _internal_pid;
        if (oldValue !== value)
        {
            _internal_pid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pid", oldValue, _internal_pid));
        }
    }

    public function set rangeIndicator(value:String) : void
    {
        var oldValue:String = _internal_rangeIndicator;
        if (oldValue !== value)
        {
            _internal_rangeIndicator = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rangeIndicator", oldValue, _internal_rangeIndicator));
        }
    }

    public function set rangeReference(value:String) : void
    {
        var oldValue:String = _internal_rangeReference;
        if (oldValue !== value)
        {
            _internal_rangeReference = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rangeReference", oldValue, _internal_rangeReference));
        }
    }

    public function set result(value:String) : void
    {
        var oldValue:String = _internal_result;
        if (oldValue !== value)
        {
            _internal_result = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "result", oldValue, _internal_result));
        }
    }

    public function set resultDate(value:Date) : void
    {
        var oldValue:Date = _internal_resultDate;
        if (oldValue !== value)
        {
            _internal_resultDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultDate", oldValue, _internal_resultDate));
        }
    }

    public function set resultUnit(value:String) : void
    {
        var oldValue:String = _internal_resultUnit;
        if (oldValue !== value)
        {
            _internal_resultUnit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "resultUnit", oldValue, _internal_resultUnit));
        }
    }

    public function set servTypeChildAcro(value:String) : void
    {
        var oldValue:String = _internal_servTypeChildAcro;
        if (oldValue !== value)
        {
            _internal_servTypeChildAcro = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "servTypeChildAcro", oldValue, _internal_servTypeChildAcro));
        }
    }

    public function set servTypeChildLongDesc(value:String) : void
    {
        var oldValue:String = _internal_servTypeChildLongDesc;
        if (oldValue !== value)
        {
            _internal_servTypeChildLongDesc = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "servTypeChildLongDesc", oldValue, _internal_servTypeChildLongDesc));
        }
    }

    public function set servTypeRootAcro(value:String) : void
    {
        var oldValue:String = _internal_servTypeRootAcro;
        if (oldValue !== value)
        {
            _internal_servTypeRootAcro = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "servTypeRootAcro", oldValue, _internal_servTypeRootAcro));
        }
    }

    public function set sid(value:Number) : void
    {
        var oldValue:Number = _internal_sid;
        if (oldValue !== value)
        {
            _internal_sid = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sid", oldValue, _internal_sid));
        }
    }

    public function set sortChildSeq(value:String) : void
    {
        var oldValue:String = _internal_sortChildSeq;
        if (oldValue !== value)
        {
            _internal_sortChildSeq = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sortChildSeq", oldValue, _internal_sortChildSeq));
        }
    }

    public function set state(value:String) : void
    {
        var oldValue:String = _internal_state;
        if (oldValue !== value)
        {
            _internal_state = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "state", oldValue, _internal_state));
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
    public function get _model() : _LabListDTOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _LabListDTOEntityMetadata) : void
    {
        var oldValue : _LabListDTOEntityMetadata = model_internal::_dminternal_model;
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
