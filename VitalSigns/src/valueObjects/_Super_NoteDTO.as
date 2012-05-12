/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - NoteDTO.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.ImageDTO;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_NoteDTO extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
        valueObjects.ImageDTO.initRemoteClassAliasSingleChild();
    }

    model_internal var _dminternal_model : _NoteDTOEntityMetadata;
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
    private var _internal_authorID : int;
    private var _internal__date : Date;
    private var _internal_noteID : int;
    private var _internal_noteText : String;
    private var _internal_patientID : int;
    private var _internal_photos : ArrayCollection;
    model_internal var _internal_photos_leaf:valueObjects.ImageDTO;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_NoteDTO()
    {
        _model = new _NoteDTOEntityMetadata(this);

        // Bind to own data or source properties for cache invalidation triggering

    }

    /**
     * data/source property getters
     */

    [Bindable(event="propertyChange")]
    public function get authorID() : int
    {
        return _internal_authorID;
    }

    [Bindable(event="propertyChange")]
    public function get _date() : Date
    {
        return _internal__date;
    }

    [Bindable(event="propertyChange")]
    public function get noteID() : int
    {
        return _internal_noteID;
    }

    [Bindable(event="propertyChange")]
    public function get noteText() : String
    {
        return _internal_noteText;
    }

    [Bindable(event="propertyChange")]
    public function get patientID() : int
    {
        return _internal_patientID;
    }

    [Bindable(event="propertyChange")]
    public function get photos() : ArrayCollection
    {
        return _internal_photos;
    }

    public function clearAssociations() : void
    {
    }

    /**
     * data/source property setters
     */

    public function set authorID(value:int) : void
    {
        var oldValue:int = _internal_authorID;
        if (oldValue !== value)
        {
            _internal_authorID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "authorID", oldValue, _internal_authorID));
        }
    }

    public function set _date(value:Date) : void
    {
        var oldValue:Date = _internal__date;
        if (oldValue !== value)
        {
            _internal__date = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_date", oldValue, _internal__date));
        }
    }

    public function set noteID(value:int) : void
    {
        var oldValue:int = _internal_noteID;
        if (oldValue !== value)
        {
            _internal_noteID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "noteID", oldValue, _internal_noteID));
        }
    }

    public function set noteText(value:String) : void
    {
        var oldValue:String = _internal_noteText;
        if (oldValue !== value)
        {
            _internal_noteText = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "noteText", oldValue, _internal_noteText));
        }
    }

    public function set patientID(value:int) : void
    {
        var oldValue:int = _internal_patientID;
        if (oldValue !== value)
        {
            _internal_patientID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "patientID", oldValue, _internal_patientID));
        }
    }

    public function set photos(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_photos;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_photos = value;
            }
            else if (value is Array)
            {
                _internal_photos = new ArrayCollection(value);
            }
            else if (value == null)
            {
                _internal_photos = null;
            }
            else
            {
                throw new Error("value of photos must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "photos", oldValue, _internal_photos));
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
    public function get _model() : _NoteDTOEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _NoteDTOEntityMetadata) : void
    {
        var oldValue : _NoteDTOEntityMetadata = model_internal::_dminternal_model;
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
