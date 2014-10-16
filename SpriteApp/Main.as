package 
{
	import starling.events.Event;
	import starling.display.Sprite;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Panel;
	import feathers.controls.ImageLoader;
	import feathers.controls.TabBar;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import feathers.themes.MetalWorksMobileTheme;

	import feathers.events.FeathersEventType;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.data.ListCollection;
	import starling.utils.AssetManager;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	
	
	public class Main extends Screen
	{
		[Embed(source = "kevin_sprite2.xml",mimeType = "application/octet-stream")]
		public static const kevin_sprite2:Class;
		[Embed(source = "images/kevin_sprite.png")]
		public static const ATLAS_TEXTURE:Class;
		protected var atlas:TextureAtlas;
		protected var atlasTexture:Texture;
		protected var bgTexture:Texture;
		protected var bgImgLoader:ImageLoader;
		protected var button:Button;
		protected var contentPanel:Panel;
		protected var buttonPanel:Panel;
		private var assetMgr:AssetManager;
		
		
		public function Main()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler (e:Event):void
		{
			assetMgr = new AssetManager ();
			assetMgr.verbose = true;
			assetMgr.enqueue(EmbeddedAssets);
			assetMgr.loadQueue(handleAssetsLoading);
			}
			
			private function handleAssetsLoading(ratioLoaded:Number):void
			{ 
			if(ratioLoaded == 1)
			   {
				   startApp()
			   }
			}
		protected function startApp() 
		{
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);
			//new AeonDesktopTheme();
			new MetalWorksMobileTheme();
			//new MinimalMobileTheme();
			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			

			atlasTexture = Texture.fromBitmap(new ATLAS_TEXTURE());
			var xml: XML = XML(new kevin_sprite2());
			atlas = new TextureAtlas(atlasTexture,xml);
			this.buttonPanel = new Panel();
			
			
			
			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;
			
			
			this.buttonPanel.layoutData = buttonPanelLayoutData;
			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);
			
			
			
			
			this.contentPanel = new Panel();			
	
			
			var contentPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 50;
			contentPanelLayoutData.bottom = 50;
			contentPanelLayoutData.left = 50;
			contentPanelLayoutData.right = 50;
		    contentPanel.width = 600;
			contentPanel.height = 600;
			contentPanelLayoutData.bottomAnchorDisplayObject = this.buttonPanel;
			contentPanel.layoutData = contentPanelLayoutData;
			this.addChild(contentPanel);
			
			
			
			bgTexture = atlas.getTexture("images/flowers.jpg");
			bgImgLoader = new ImageLoader();
			bgImgLoader.source = bgTexture;
			bgImgLoader.width = this.stage.stageWidth;
			bgImgLoader.maintainAspectRatio = true;
			contentPanel.addChild(bgImgLoader);

			
			
			this.button = new Button();
			this.button.label = "Click Me";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			this.buttonPanel.addChild(this.button);
			
			this.button = new Button();
			this.button.label = "Music";
			this.button.addEventListener(Event.TRIGGERED, musicHandler);
			this.buttonPanel.addChild(this.button);
		}
		protected function button_triggeredHandler(e: Event):void
		{
			bgTexture = atlas.getTexture("images/kevin_sprite.png");
			
			var label:Label = new Label ();
			label.text = "ImgComingSoon";
			label.width=500;
			label.height=120;
			Callout.show(label, this.button);
			   
			
			
		}
		
		protected function musicHandler(e: Event):void
		{
			trace ("Button clicked");
			assetMgr.playSound("GoneGoing");
		}
		protected function stageResized(e: Event):void
		{
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			bgImgLoader.width = this.width;
		}
	}}