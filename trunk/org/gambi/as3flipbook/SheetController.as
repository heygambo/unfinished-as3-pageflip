package org.gambi.as3flipbook
{
	import away3d.core.math.Number3D;
	import away3d.events.MouseEvent3D;
	import away3d.primitives.Plane;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.plugins.away3d.LibraryAway3d;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SheetController extends EventDispatcher
	{
		private var _sheet:Plane;
		private var _sheetIndex:int;
		private var _modifierStack:ModifierStack;
		private var _bend:Bend;
		private var _applyTimer:Timer = new Timer(30);
		private const _animationDuration:uint = 1;
		
		public function SheetController(init:Object = null)
		{
			if (init.sheetIndex)
			{
				this._sheetIndex = init.sheetIndex
			}
			_sheet = new Plane(init);
			_sheet.rotationX = 90;
			_sheet.pivotPoint = new Number3D(-(_sheet.width / 2), 0, 0);
			_sheet.addEventListener(MouseEvent3D.MOUSE_UP, onMouseUp, false, 0, true);
			
			_modifierStack = new ModifierStack(new LibraryAway3d(), _sheet);
			_bend = new Bend(0, .9, 1.5);
			_modifierStack.addModifier(_bend);
			
			_applyTimer.addEventListener(TimerEvent.TIMER, onApplyTimer, false, 0, true);
		}
		
		public function get view():Plane
		{
			return _sheet;
		}
		
		public function get sheetIndex():int
		{
			return _sheetIndex;
		}
		
		public function animateToLeft():void
		{
			_applyTimer.start();
			
			TweenLite.to(_sheet, _animationDuration, {
				rotationY: 180,
				ease: Linear.easeNone,
				onComplete: onTweenComplete
			});
			
			// Bending
			TweenLite.to(_bend, _animationDuration/2, { force: 0.5, ease: Circ.easeOut });
			TweenLite.to(_bend, _animationDuration/1.5, { force: 0, ease: Circ.easeOut, delay: _animationDuration/4, overwrite: 0 });
		}
		
		public function animateToRight():void
		{
			_applyTimer.start();
			
			TweenLite.to(_sheet, _animationDuration, {
				rotationY: 0,
				ease: Linear.easeNone,
				onComplete: onTweenComplete
			});
			
			// Bending
			TweenLite.to(_bend, _animationDuration/2, { force: -0.5, ease: Circ.easeOut });
			TweenLite.to(_bend, _animationDuration/1.5, { force: 0, ease: Circ.easeOut, delay: _animationDuration/4, overwrite: 0 });
		}
		
		private function onMouseUp( event:MouseEvent3D ):void
		{
			this.dispatchEvent(new SheetEvent(SheetEvent.SHEET_CLICK));
		}
		
		private function onTweenComplete():void
		{
			_applyTimer.stop();
			_modifierStack.apply();
		}
		
		private function onApplyTimer( event:TimerEvent ):void
		{
			_modifierStack.apply();
		}
	}
}