package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.display.FlxBackdrop;
import lime.utils.Assets;
import flixel.effects.FlxFlicker;

using StringTools;
using flixel.util.FlxSpriteUtil;

class CreditsState extends MusicBeatState
{
	static var curSelected:Int = -1;
	static var lessSelected:Int = -2;
	static var succSelected:Int = 0;

	private var optionText:FlxText;
	private var descText:FlxText;
	private var roleText:FlxText;
	private var charText:FlxText;
	private var icon:AttachedSprite;
	private var precIcon:AttachedSprite;
	private var succIcon:AttachedSprite;
	private var creditsStuff:Array<Array<String>> = [];

	//took these two from og credits state lmao
	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var stupidshit:FlxBackdrop;
	var yummy:FlxSprite;
	var arrowshit:FlxSprite;
	var overlay:FlxSprite;
	var lineStuff:FlxTypedGroup<FlxSprite>;
	var statiCazzo:FlxTypedGroup<FlxSprite>;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;

		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		stupidshit = new FlxBackdrop(Paths.image('checkeredBG'), XY);
        stupidshit.velocity.set(FlxG.random.bool(50) ? 90 : -90, FlxG.random.bool(50) ? 90 : -90);
        stupidshit.screenCenter();
        stupidshit.alpha = 0.4;
        add(stupidshit);

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description/Quote - Link - Role - Color
			['the j'],
			['Vs. Dave and Bambi',		'daveandbambi',		'The Original Mod by\nSupport it by pressing ENTER',		'https://gamebanana.com/mods/43201',	'',    '613BE0'],
			['FrogB',		'frogb',		'the',							'https://linktr.ee/FrogB',	'Director/Main Programmer.', 'FFCB6C'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',								'https://twitter.com/Shadow_Mario_', '',	'444444'],
			['RiverOaken',			'river',			'Main Artist/Animator of Psych Engine',							'https://twitter.com/RiverOaken',	'',	'B42F71'],
			['shubs',				'shubs',			'Additional Programmer of Psych Engine',						'https://twitter.com/yoshubs',		'',	'5E99DF'],
			['bb-panzu',			'bb',				'Ex-Programmer of Psych Engine',								'https://twitter.com/bbsub3',		'',	'3E813A'],
			['iFlicky',				'flicky',			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',		'https://twitter.com/flicky_i',		'',	'9E29CF'],
			['SqirraRNG',			'sqirra',			'Crash Handler and Base code for\nChart Editor\'s Waveform',	'https://twitter.com/gedehari',		'',	'E1843A'],
			['PolybiusProxy',		'proxy',			'.MP4 Video Loader Library (hxCodec)',							'https://twitter.com/polybiusproxy', '',	'DCD294'],
			['KadeDev',				'kade',				'Fixed some cool stuff on Chart Editor\nand other PRs',			'https://twitter.com/kade0912',		'',	'64A250'],
			['Keoiki',				'keoiki',			'Note Splash Animations',										'https://twitter.com/Keoiki_',		'',	'D2D2D2'],
			['Nebula the Zorua',	'nebula',			'LUA JIT Fork and some Lua reworks',							'https://twitter.com/Nebula_Zorua',	'',	'7D40B2'],
			['Smokey',				'smokey',			'Sprite Atlas Support',											'https://twitter.com/Smokey_5_',	'',	'483D92'],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",							'https://twitter.com/ninja_muffin99', '',	'CF2D2D'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",								'https://twitter.com/PhantomArcade3K',	'', 'FADC45'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",								'https://twitter.com/evilsk8r',		'',	'5ABD4B'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",								'https://twitter.com/kawaisprite',	'',	'378FC7']
		];

		for(i in pisspoop){
			creditsStuff.push(i);
		}

		optionText = new FlxText(386, FlxG.height * 0.5 - 80, 0, "", 60);
		optionText.setFormat(Paths.font("comic.ttf"), 60, FlxColor.WHITE, LEFT, OUTLINE_FAST, FlxColor.BLACK);
		// optionText.screenCenter();
		add(optionText);

		roleText = new FlxText(optionText.width + 400, optionText.y + 30, 0, "", 30);
		roleText.setFormat(Paths.font("comic.ttf"), 25, FlxColor.RED, LEFT, OUTLINE_FAST, FlxColor.BLACK);
		add(roleText);

		descText = new FlxText(optionText.x, optionText.y + 70, 670, "", 30);
		descText.setFormat(Paths.font("comic.ttf"), 25, FlxColor.BLACK, LEFT, OUTLINE_FAST, FlxColor.WHITE);
		add(descText);

		precIcon = new AttachedSprite('credits/shadowmario');
		add(precIcon);

		icon = new AttachedSprite('credits/shadowmario');
		add(icon);

		succIcon = new AttachedSprite('credits/shadowmario');
		add(succIcon);

		// icons

		// these for positioning

		var thignie:FlxSprite = new FlxSprite(208, 278.1);
		var square:FlxSprite = new FlxSprite(558.5, 36);
		var employee:FlxSprite = new FlxSprite(558.5, 520.4);

		// x add

		icon.xAdd = 6;
		precIcon.xAdd = 6;
		succIcon.xAdd = 6;

		// y add

		icon.yAdd = 6;
		precIcon.yAdd = 6;
		succIcon.yAdd = 6;

		// sprtracking

		icon.sprTracker = thignie;
		precIcon.sprTracker = square;
		succIcon.sprTracker = employee;

		// end of icons

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);

			if(isSelectable) {
				if(curSelected == -1) curSelected = i;
			}
		}

		statiCazzo = new FlxTypedGroup<FlxSprite>();
		add(statiCazzo);

		lineStuff = new FlxTypedGroup<FlxSprite>();
		add(lineStuff);

		for (i in 0...12){
			var stupidLine:FlxSprite = new FlxSprite(208, 287.1);
			stupidLine.makeGraphic(10, Std.int(145.9), FlxColor.WHITE);
			stupidLine.ID = i;

			switch (i)
			{
				case 1:
					// rectangle
					stupidLine.x = 208;
					stupidLine.y = 278.1;
					stupidLine.makeGraphic(864, 10, FlxColor.WHITE);
				case 2:
					stupidLine.x = 208;
					stupidLine.y = 277.1 + 155;
					stupidLine.makeGraphic(864, 10, FlxColor.WHITE);
				case 3:
					stupidLine.x = 208 + 854;
					stupidLine.y = 287.1;
					stupidLine.makeGraphic(10, Std.int(145.9), FlxColor.WHITE);
				case 4:
					// up square
					stupidLine.x = 558.5;
					stupidLine.y = 36;
					stupidLine.makeGraphic(10, 144 + 10, FlxColor.WHITE);
				case 5:
					stupidLine.x = 558.5 + 153;
					stupidLine.y = 36 + 10;
					stupidLine.makeGraphic(10, 144 + 9, FlxColor.WHITE);
				case 6:
					stupidLine.x = 558.5 + 10;
					stupidLine.y = 36;
					stupidLine.makeGraphic(144 + 9, 10, FlxColor.WHITE);
				case 7:
					stupidLine.x = 558.5;
					stupidLine.y = 36 + 153;
					stupidLine.makeGraphic(144 + 10, 10, FlxColor.WHITE);
				case 8:
					// down square
					stupidLine.x = 558.5;
					stupidLine.y = 520.4;
					stupidLine.makeGraphic(10, 144 + 10, FlxColor.WHITE);
				case 9:
					stupidLine.x = 558.5 + 153;
					stupidLine.y = 520.4 + 10;
					stupidLine.makeGraphic(10, 144 + 9, FlxColor.WHITE);
				case 10:
					stupidLine.x = 558.5 + 10;
					stupidLine.y = 520.4;
					stupidLine.makeGraphic(144 + 9, 10, FlxColor.WHITE);
				case 11:
					stupidLine.x = 558.5;
					stupidLine.y = 520.4 + 153;
					stupidLine.makeGraphic(144 + 10, 10, FlxColor.WHITE);
			}
			lineStuff.add(stupidLine);
		}

		arrowshit = new FlxSprite(-80).loadGraphic(Paths.image('stupidarrows'));
		arrowshit.setGraphicSize(Std.int(arrowshit.width * 1));
		arrowshit.updateHitbox();
		arrowshit.screenCenter();
		arrowshit.antialiasing = ClientPrefs.globalAntialiasing;

		overlay = new FlxSprite(-80).loadGraphic(Paths.image('CoolOverlay'));
		overlay.setGraphicSize(Std.int(overlay.width * 1.2)); //god it covers the fucking border i gotta enlarge it
		overlay.updateHitbox();
		overlay.screenCenter();
		overlay.antialiasing = ClientPrefs.globalAntialiasing;

		add(overlay);
		add(arrowshit);

		charText = new FlxText(0, 0, 0, '', 76);
        charText.setFormat(Paths.font('comic-sans.ttf'), 76, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        charText.screenCenter(X);
        add(charText);
		
		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{		
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		//i mean come on, what else could i have fucking done? -frogb
		var LMAO:String = creditsStuff[curSelected][0];
		if (LMAO.startsWith('Vs. '))
			charText.text = "The OG D&B Mod(s) Credits";
		else if (LMAO.startsWith('FrogB'))
			charText.text = "Half-Sided Team";
		else if (LMAO.startsWith('Shadow') || LMAO.startsWith('Smokey'))
			charText.text = 'Psych Engine Team';
		else if (LMAO.startsWith('kawaisprite') || LMAO.startsWith('ninjamuffin99'))
			charText.text = "Funkin' Crew";

		charText.screenCenter(X);

		statiCazzo.forEach(function(item:FlxSprite){
			item.alpha = FlxMath.lerp(0.3, item.alpha, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
		});
		
		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_LEFT_P;
				var downP = controls.UI_RIGHT_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult));
					}
				}
			}

			var creditoLinko:String = creditsStuff[curSelected][3];
			if(controls.ACCEPT && (creditoLinko == null || creditoLinko.length > 4)) {
				CoolUtil.browserLoad(creditoLinko);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}

		super.update(elapsed);
	}
	
	var lerpVal:Float = 1.2;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			lessSelected = (curSelected - 1);
			succSelected = (curSelected + 1);
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
			if (lessSelected == 0)
				lessSelected = creditsStuff.length - 1;
			if (lessSelected == -2)
				lessSelected = creditsStuff.length - 2;
			if (succSelected >= creditsStuff.length)
				succSelected = 1;
			if (succSelected == 0)
				succSelected = 1;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		statiCazzo.forEach(function(item:FlxSprite){
			item.alpha = 1;
		});

		optionText.text = creditsStuff[curSelected][0];
		descText.text = creditsStuff[curSelected][2];
		roleText.text = creditsStuff[curSelected][4];
		optionText.x = 386;
		roleText.x = optionText.width + 400;
		descText.x = optionText.x;
		
		// yeah i could use Paths but idc
		var pattolo:Array<String> = ['assets/images/credits/' + '${creditsStuff[curSelected][1]}' + '.png',
			'assets/images/credits/' + '${creditsStuff[lessSelected][1]}' + '.png',
			'assets/images/credits/' + '${creditsStuff[succSelected][1]}' + '.png'
		];
		for (i in 0...pattolo.length)
		{
			if(!Assets.exists(pattolo[i]))
			{
				trace('doesnt exist');
				pattolo[i] = 'assets/images/credits/error.png';
			}
		}
		icon.loadGraphic(pattolo[0]);
		precIcon.loadGraphic(pattolo[1]);
		succIcon.loadGraphic(pattolo[2]);
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][5];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}