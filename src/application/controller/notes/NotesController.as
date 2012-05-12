package application.controller.notes
{
	import application.component.CollapsiblePanel;
	import application.controller.messaging.NotificationController;
	import application.factory.ISpeech;
	import application.view.notes.CameraView;
	import application.view.notes.PhotosView;
	
	import domain.IObservable;
	import domain.command.Command;
	import domain.command.CreateNewNoteCommand;
	import domain.command.GetAllNotesCommand;
	import domain.image.Image;
	import domain.note.Note;
	import domain.patient.Patient;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.system.System;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	
	import services.VitalSignService;
	
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;

	public class NotesController extends NotificationController implements IObservable {
		private var patient:Patient = null;
		
		public var micBtn:Button = new Button();
		public var cameraBtn:Button = new Button();
		public var sendBtn:Button = new Button();
		public var titleLabel:Label = new Label();
		public var newNoteTextArea:TextArea = new TextArea();
		public var vgroup:VGroup = new VGroup();
		public var attachmentsGroup:VGroup = new VGroup();
		public var listNotes:VGroup = new VGroup();
		
		public var notesList:ArrayCollection = new ArrayCollection();
		public var currentText:String = "";
		public var currentAttachments:ArrayCollection = new ArrayCollection;
		public var notesLoaded:Boolean = false;
		
		private var resultFunction:Function;
		
		private var speechAction:ISpeech;
		
		public function NotesController(){
			super();
			speechAction = VitalSigns.PlatformFactory.createSpeechCenter();
		}
		
		protected function notesView_addHandler(event:FlexEvent):void {
			patient = data as Patient;
			
			this.attachmentsGroup.removeAllElements();
			destructionPolicy = "auto";
			if (navigator.poppedViewReturnedObject && navigator.poppedViewReturnedObject.object) {
				if (navigator.poppedViewReturnedObject.object is Image) {
					var photo:Image = navigator.poppedViewReturnedObject.object as Image;
					currentAttachments.addItem(photo);
				}
				else {
					currentAttachments = navigator.poppedViewReturnedObject.object as ArrayCollection;
					if (currentAttachments.length == 0)
						attachmentsGroup.removeAllElements();
				}
			}
			if (currentAttachments.length > 0) {
				sendBtn.visible = true;
				for(var index:int = 0; index < currentAttachments.length; index++)
					addAttachment(index, currentAttachments.getItemAt(index) as Image);
			} else {
				sendBtn.visible = false;
			}
			if (!this.notesLoaded) {
				loadNotes();
			}
			
			this.title = patient.lastName + ", " + patient.firstName; 
			this.validateNow();
		}
		
		/*UI Functions*/
		private function addAttachment(id:int, photo:Image):void {
			var attachment:HGroup = new HGroup();
			attachment.percentWidth = 100;
			attachment.id = id.toString();
			attachmentsGroup.addElement(attachment);
			
			var viewPhotoBtn:Button = new Button();
			viewPhotoBtn.width = 64;
			viewPhotoBtn.height = 64;
			[Embed(source='application/asset/icon/ic_action_attach.png')]
			var attachmentIcon:Class;
			viewPhotoBtn.setStyle("icon", attachmentIcon);
			viewPhotoBtn.addEventListener(MouseEvent.CLICK, viewPhotoBtn_clickHandler);
			attachment.addElement(viewPhotoBtn);
			
			var attachmentLbl:Label = new Label();
			var currentDate:Date = new Date();
			attachmentLbl.text = "Photo " + (id + 1).toString();
			attachmentLbl.percentWidth =  100;
			attachment.addElement(attachmentLbl);
			
			var deletePhotoBtn:Button = new Button();
			deletePhotoBtn.width = 64;
			deletePhotoBtn.height = 64;
			[Embed(source='application/asset/icon/ic_action_delete_l.png')]
			var deleteIcon:Class;
			deletePhotoBtn.setStyle("icon", deleteIcon);
			deletePhotoBtn.addEventListener(MouseEvent.CLICK, deletePhotoBtn_clickHandler);
			attachment.addElement(deletePhotoBtn);
		}
		
		private function createNotePanels():void {
			listNotes.removeAllElements();
			for(var index:int = 0; index < notesList.length; index++) {
				var note:Note = notesList.getItemAt(index) as Note;
				var collapsiblePanel:CollapsiblePanel = new CollapsiblePanel(
					note.getDate(),
					note.getText(),
					false);
				collapsiblePanel.name = index.toString();
				if (note.hasImages()) {
					var viewAttachmentsBtn:Button = new Button();
					viewAttachmentsBtn.percentWidth = 100;
					viewAttachmentsBtn.label = "View Attachments (" +
						note.getNumberOfImages() + ")";
					viewAttachmentsBtn.addEventListener(MouseEvent.CLICK, viewAttachmentsBtn_clickHandler);
					collapsiblePanel.addChild(viewAttachmentsBtn);
				}
				listNotes.addElement(collapsiblePanel);
			}
		}
		
		private function resizeTextArea():void {
			var textAreaHeight:uint = 25;
			for(var index:int = 0; index < newNoteTextArea.mx_internal::getTextField().numLines; index++)
				textAreaHeight += newNoteTextArea.mx_internal::getTextField().getLineMetrics(index).height;
			textAreaHeight += newNoteTextArea.mx_internal::getTextField().getLineMetrics(0).height;
			newNoteTextArea.height = textAreaHeight;
			newNoteTextArea.validateNow();
		}
		
		/*UI Handlers*/
		protected function sendBtn_clickHandler(event:MouseEvent):void {
			createNewNote();
			sendBtn.visible = false;
			micBtn.visible = false;
			newNoteTextArea.text = "";
			newNoteTextArea.height = newNoteTextArea.mx_internal::getTextField().getLineMetrics(0).height;
			attachmentsGroup.removeAllElements();
			System.gc();
		}
		
		protected function micBtn_clickHandler(event:MouseEvent):void {
			speechAction.startSpeech( receiveSpeech );
		}
		
		protected function cameraBtn_clickHandler(event:MouseEvent):void {
			if(Camera.isSupported) {
				this.destructionPolicy = "never";
				navigator.pushView(CameraView);
			}
		}
		
		protected function viewPhotoBtn_clickHandler(event:MouseEvent):void {
			viewPhotos(currentAttachments, parseInt(((event.currentTarget as Button).parent as HGroup).id)); 
		}
		
		protected function viewAttachmentsBtn_clickHandler(event:MouseEvent):void {
			var id:int = parseInt(((event.currentTarget as Button).parent as CollapsiblePanel).name);
			viewPhotos((notesList.getItemAt(id) as Note).getImages(), -1);
		}
		
		protected function deletePhotoBtn_clickHandler(event:MouseEvent):void {
			var index:int = parseInt(((event.currentTarget as Button).parent as HGroup).id);
			currentAttachments.removeItemAt(index);
			this.attachmentsGroup.removeAllElements();
			if ((newNoteTextArea.text.length == 0) && currentAttachments.length == 0)
				sendBtn.visible = false;
			for(var i:int = 0; i < currentAttachments.length; i++)
				addAttachment(i, currentAttachments.getItemAt(i) as Image);
		}
		
		protected function newNoteTextArea_onChangeHandler(event:Event):void {
			if (newNoteTextArea.text.length > 0) {
				sendBtn.visible = true;
				resizeTextArea();
			} else
				sendBtn.visible = false;
		}
		
		protected function newNoteTextArea_focusInHandler(event:FocusEvent):void {
			if (newNoteTextArea.text.length > 0) {
				resizeTextArea();
			}
			micBtn.visible = true;
		}
		
		/*Internal Functions*/
		private function loadNotes():void {
			this.cursorManager.setBusyCursor();
			var cmd:Command = new GetAllNotesCommand(this, patient.patientId);
			resultFunction = getAllNotesResultHandler;
			cmd.execute();
		}
		
		private function viewPhotos(images:ArrayCollection, imageIndex:int):void {
			this.destructionPolicy = "never";
			navigator.pushView(PhotosView, images, imageIndex);
		}
		
		private function createNewNote():void {
			currentText = newNoteTextArea.text;
			var cmd:Command = new CreateNewNoteCommand(this, currentText, currentAttachments, VitalSigns.currentUser.userId, patient.patientId, (new Date()));
			resultFunction = createNewNoteResultHandler;
			cmd.execute();
		}
		
		/*Speech To Text Handler*/
		protected function receiveSpeech( message:String ):void {
			if( message.length > 0 ){
				newNoteTextArea.text = newNoteTextArea.text.substring(0, newNoteTextArea.selectionBeginIndex) + 
					" " + message + " " + newNoteTextArea.text.substring(newNoteTextArea.selectionBeginIndex, newNoteTextArea.length);
				sendBtn.visible = true;
				resizeTextArea();
			}
		}
		
		/*Result Handlers*/
		public function resultHandler(DO:Object):void {
			this.cursorManager.removeBusyCursor();
			resultFunction(DO);
		}
		
		private function getAllNotesResultHandler(notes:ArrayCollection):void {
			this.notesList = notes;
			this.notesLoaded = true;
			this.createNotePanels();
		}
		
		private function createNewNoteResultHandler(object:Object):void {
			notesList.addItem(object as Note);
			createNotePanels();
			currentText = "";
			currentAttachments = new ArrayCollection();
		}
		
		/*Fault Handler*/
		public function faultHandler(message:String):void {
			VitalSigns.showErrorMessage();
		}
	}
}