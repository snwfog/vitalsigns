/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - PatientDTO.as.
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
public class _Super_PatientDTO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _PatientDTOEntityMetadata;
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
    private var _internal_address : String;
    private var _internal_bed : String;
    private var _internal_birthDate : Date;
    private var _internal_city : String;
    private var _internal_doctor : String;
    private var _internal_doctorTel : String;
    private var _internal_enFillerNum : String;
    private var _internal_encounterId : Number;
    private var _internal_extAppId : String;
    private var _internal_firstName : String;
    private var _internal_height : Number;
    private var _internal_heightUnit : String;
    private var _internal_lastName : String;
    private var _internal_mrn : String;
    private var _internal_nursingUnit : String;
    private var _internal_patientId : Number;
    private var _internal_postalCode : String;
    private var _internal_province : String;
    private var _internal_readOnly : Boolean;
    private var _internal_sexCd : String;
    private var _internal_weight : Number;
    private var _internal_weightUnit : String;

    private static var emptyArray:Array = new Array();

    // Change this value according to your application's floating-point precision
    private static var epsilon:Number = 0.0001;

    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_PatientDTO()
    {
        _model = new _PatientDTOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get address() : String
    {
        return _internal_address;
    }

    [Bindable(event="propertyChange")]
    public function get bed() : String
    {
        return _internal_bed;
    }

    [Bindable(event="propertyChange")]
    public function get birthDate() : Date
    {
        return _internal_birthDate;
    }

    [Bindable(event="propertyChange")]
    public function get city() : String
    {
        return _internal_city;
    }

    [Bindable(event="propertyChange")]
    public function get doctor() : String
    {
        return _internal_doctor;
    }

    [Bindable(event="propertyChange")]
    public function get doctorTel() : String
    {
        return _internal_doctorTel;
    }

    [Bindable(event="propertyChange")]
    public function get enFillerNum() : String
    {
        return _internal_enFillerNum;
    }

    [Bindable(event="propertyChange")]
    public function get encounterId() : Number
    {
        return _internal_encounterId;
    }

    [Bindable(event="propertyChange")]
    public function get extAppId() : String
    {
        return _internal_extAppId;
    }

    [Bindable(event="propertyChange")]
    public function get firstName() : String
    {
        return _internal_firstName;
    }

    [Bindable(event="propertyChange")]
    public function get height() : Number
    {
        return _internal_height;
    }

    [Bindable(event="propertyChange")]
    public function get heightUnit() : String
    {
        return _internal_heightUnit;
    }

    [Bindable(event="propertyChange")]
    public function get lastName() : String
    {
        return _internal_lastName;
    }

    [Bindable(event="propertyChange")]
    public function get mrn() : String
    {
        return _internal_mrn;
    }

    [Bindable(event="propertyChange")]
    public function get nursingUnit() : String
    {
        return _internal_nursingUnit;
    }

    [Bindable(event="propertyChange")]
    public function get patientId() : Number
    {
        return _internal_patientId;
    }

    [Bindable(event="propertyChange")]
    public function get postalCode() : String
    {
        return _internal_postalCode;
    }

    [Bindable(event="propertyChange")]
    public function get province() : String
    {
        return _internal_province;
    }

    [Bindable(event="propertyChange")]
    public function get readOnly() : Boolean
    {
        return _internal_readOnly;
    }

    [Bindable(event="propertyChange")]
    public function get sexCd() : String
    {
        return _internal_sexCd;
    }

    [Bindable(event="propertyChange")]
    public function get weight() : Number
    {
        return _internal_weight;
    }

    [Bindable(event="propertyChange")]
    public function get weightUnit() : String
    {
        return _internal_weightUnit;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set address(value:String) : void
    {
        var oldValue:String = _internal_address;
        if (oldValue !== value)
        {
            _internal_address = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "address", oldValue, _internal_address));
        }
    }

    public function set bed(value:String) : void
    {
        var oldValue:String = _internal_bed;
        if (oldValue !== value)
        {
            _internal_bed = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bed", oldValue, _internal_bed));
        }
    }

    public function set birthDate(value:Date) : void
    {
        var oldValue:Date = _internal_birthDate;
        if (oldValue !== value)
        {
            _internal_birthDate = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "birthDate", oldValue, _internal_birthDate));
        }
    }

    public function set city(value:String) : void
    {
        var oldValue:String = _internal_city;
        if (oldValue !== value)
        {
            _internal_city = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "city", oldValue, _internal_city));
        }
    }

    public function set doctor(value:String) : void
    {
        var oldValue:String = _internal_doctor;
        if (oldValue !== value)
        {
            _internal_doctor = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "doctor", oldValue, _internal_doctor));
        }
    }

    public function set doctorTel(value:String) : void
    {
        var oldValue:String = _internal_doctorTel;
        if (oldValue !== value)
        {
            _internal_doctorTel = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "doctorTel", oldValue, _internal_doctorTel));
        }
    }

    public function set enFillerNum(value:String) : void
    {
        var oldValue:String = _internal_enFillerNum;
        if (oldValue !== value)
        {
            _internal_enFillerNum = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "enFillerNum", oldValue, _internal_enFillerNum));
        }
    }

    public function set encounterId(value:Number) : void
    {
        var oldValue:Number = _internal_encounterId;
        if (oldValue !== value)
        {
            _internal_encounterId = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "encounterId", oldValue, _internal_encounterId));
        }
    }

    public function set extAppId(value:String) : void
    {
        var oldValue:String = _internal_extAppId;
        if (oldValue !== value)
        {
            _internal_extAppId = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "extAppId", oldValue, _internal_extAppId));
        }
    }

    public function set firstName(value:String) : void
    {
        var oldValue:String = _internal_firstName;
        if (oldValue !== value)
        {
            _internal_firstName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "firstName", oldValue, _internal_firstName));
        }
    }

    public function set height(value:Number) : void
    {
        var oldValue:Number = _internal_height;
        if (isNaN(_internal_height) == true || Math.abs(oldValue - value) > epsilon)
        {
            _internal_height = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "height", oldValue, _internal_height));
        }
    }

    public function set heightUnit(value:String) : void
    {
        var oldValue:String = _internal_heightUnit;
        if (oldValue !== value)
        {
            _internal_heightUnit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "heightUnit", oldValue, _internal_heightUnit));
        }
    }

    public function set lastName(value:String) : void
    {
        var oldValue:String = _internal_lastName;
        if (oldValue !== value)
        {
            _internal_lastName = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "lastName", oldValue, _internal_lastName));
        }
    }

    public function set mrn(value:String) : void
    {
        var oldValue:String = _internal_mrn;
        if (oldValue !== value)
        {
            _internal_mrn = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "mrn", oldValue, _internal_mrn));
        }
    }

    public function set nursingUnit(value:String) : void
    {
        var oldValue:String = _internal_nursingUnit;
        if (oldValue !== value)
        {
            _internal_nursingUnit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nursingUnit", oldValue, _internal_nursingUnit));
        }
    }

    public function set patientId(value:Number) : void
    {
        var oldValue:Number = _internal_patientId;
        if (oldValue !== value)
        {
            _internal_patientId = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "patientId", oldValue, _internal_patientId));
        }
    }

    public function set postalCode(value:String) : void
    {
        var oldValue:String = _internal_postalCode;
        if (oldValue !== value)
        {
            _internal_postalCode = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "postalCode", oldValue, _internal_postalCode));
        }
    }

    public function set province(value:String) : void
    {
        var oldValue:String = _internal_province;
        if (oldValue !== value)
        {
            _internal_province = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "province", oldValue, _internal_province));
        }
    }

    public function set readOnly(value:Boolean) : void
    {
        var oldValue:Boolean = _internal_readOnly;
        if (oldValue !== value)
        {
            _internal_readOnly = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "readOnly", oldValue, _internal_readOnly));
        }
    }

    public function set sexCd(value:String) : void
    {
        var oldValue:String = _internal_sexCd;
        if (oldValue !== value)
        {
            _internal_sexCd = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sexCd", oldValue, _internal_sexCd));
        }
    }

    public function set weight(value:Number) : void
    {
        var oldValue:Number = _internal_weight;
        if (isNaN(_internal_weight) == true || Math.abs(oldValue - value) > epsilon)
        {
            _internal_weight = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "weight", oldValue, _internal_weight));
        }
    }

    public function set weightUnit(value:String) : void
    {
        var oldValue:String = _internal_weightUnit;
        if (oldValue !== value)
        {
            _internal_weightUnit = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "weightUnit", oldValue, _internal_weightUnit));
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
    public function get _model() : _PatientDTOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _PatientDTOEntityMetadata) : void
    {
        var oldValue : _PatientDTOEntityMetadata = model_internal::_dminternal_model;
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
