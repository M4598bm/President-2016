# President
A turn based simulation game in Processing: You've just won the 2016 presidential election! Now you have to do the work, as the 45th Chief Executive.

Initial setup:

  The game begins on January 20th, 2017. You have been able to pick a party (Democrat or Republican) and your general starting liberal or conservative tendency. In the default mode both houses of Congress are narrowly lead by your party, but that may change in two years, and you'll get to know the party leadership along the way.

Gameplay:

  Each turn is a week. At the beginning you will get a briefing from your cabinet, each member possibly giving one most important relevant current event (They may repeat if not resolved). Possible that not all members will give news, because many are less important. You will also get an update on any bills you have affected.
    The positions are: Sec. of State, Sec. of Treasury, Sec. of War, Sec. of Commerce, Attorney General, Sec. of the Interior, Sec. of Agriculture, Sec. of Labor, Sec. of Health, Sec. of Housing and Urban Dev., Sec. of Transportation, Sec. of Energy, Sec. of VA, Sec. of Education, Sec. of Homeland Security.

  Here's a list of things you can do each turn:
    - At the beginning of the game you can make an inaugural speech which outlines where you want stats to be at by the end of the first term, and in which you can choose from all available ideas which you want to use. This advice will be used by the Congressional AI to make decisions about passing laws (your party will aligned with your values and the other will go against them). Every year you must (It's unconstitutional not to!) realign your ideas in a State Of The Union Address. Beware of flip-flopping!

    - Perform a speech to either or both houses of congress. Both houses have committee bill proposals at the floor with known yea and nay votes at most times.
      * Bills are on the floor 2 turns before getting a vote, but talking to the speaker or VP can get it moved forward or back.
      * You may pick maximum 2 each turn to support (you may be forced to support extra if you made a deal)
      * You may pick maximum 2 each turn to denounce (and whether you threaten to veto it, which will add nay votes but increase the possibility of an override)
      * To pass a law, a bill must be brought to committee in the House. This can be done automatically or through you. It then needs to pass in the House. It is brought to the Senate (small chance it doesn't), where it needs to pass. If it passes both houses it gets to you and you can choose whether to sign or veto. If you veto, in the next turn both houses will vote to override, which will happen with a two thirds vote (290/435 and 67/100) and then you will need to sign.

    - You may pick a bill to send (through a representative) to a committee that you hope will eventually get to you to sign into law. You can create a bill that has up to 3 ideas in it (each could possibly make it more toxic, so be careful).

    - You may talk to all legislators in your party privately to support up to 5 specific ideas (not bills). They may leak the information.

    - You may talk to legislators during a turn, though there is a small chance they will not talk to you. Things you can say:
      * Make a deal with them. You can support or denounce a bill in front of congress, endorse them, fund their campaign, or cease attack ads, and they will vote yea or nay on any bill. You will see a list of yay and nay votes by them and bills they have expressed support for.
      * If they are campaigning you can endorse them. This will tie you to their voting record and approval rating, but it will also improve their approval rating and they will like you more. This can also be given in a deal.
      * Denounce them.

    - As President you are the leader of your political party, and therefore you have influence in your National Committee.
      * During midterms you can create a plan to give (D/R)NC funds to or to attack specific congresspeople's campaigns for reelection.
      * During presidential reelection you can choose which states to fund advertisements in.
      * Here's a nice electoral map that can be used: https://camelsnose.files.wordpress.com/2008/11/electoral-map-large5.jpg

    - You can interact with the UN by talking to your Ambassador to the UN:
      * Ask to push for any ideas you give to be acted on by the General Assembly.
      * Ask the UN Security Council for military action against a nation or economic sanction action. This will be voted on immediately after discussing with each member, and trades will be allowed (good luck with Russia and China!).
      * Make a speech request (this will be granted or rejected in two turns depending on your stance with the body). In a speech you may talk about one world issue and this will influence international politics on this issue.

    - You have the powers of the Commander-In-Chief:
      * Available military budget depends on legislation, but you start out with a large yet costly military at your disposal.
      * Plan a missile or drone strike (with reaction depending on receiving nation and war declaration)
      * Plan a land invasion with number of troops.
      * Plan a naval battle.
      * Congress declares war, not you, and not being at war greatly affects military capability and consequence.
      * Option to make one speech giving reason for the military action.

    - Control aspects of the CIA:
      * Plan assassination of leaders, with limited success rate and range of consequence
      * Fund rebel groups in different nations
