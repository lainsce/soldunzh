namespace Soldunzh {
    public class Deck : Object {
        public Card[] cards = {
            new Card("A", 0.11, CardType.HEART, "White Mage", "potion"),
            new Card("2", 0.02, CardType.HEART, "Small Potion", "potion"),
            new Card("3", 0.03, CardType.HEART, "Small Potion", "potion"),
            new Card("4", 0.04, CardType.HEART, "Medium Potion", "potion"),
            new Card("5", 0.05, CardType.HEART, "Medium Potion", "potion"),
            new Card("6", 0.06, CardType.HEART, "Medium Potion", "potion"),
            new Card("7", 0.07, CardType.HEART, "Medium Potion", "potion"),
            new Card("8", 0.08, CardType.HEART, "Medium Potion", "potion"),
            new Card("9", 0.09, CardType.HEART, "Large Potion", "potion"),
            new Card("10", 0.10, CardType.HEART, "Large Potion", "potion"),
            new Card("V", 0.11, CardType.HEART, "White Mage", "potion"),
            new Card("Q", 0.11, CardType.HEART, "White Mage", "potion"),
            new Card("K", 0.11, CardType.HEART, "White Mage", "potion"),

            new Card("A", 0.11, CardType.DIAMOND, "Red Mage", "shield"),
            new Card("2", 0.02, CardType.DIAMOND, "Buckler", "shield"),
            new Card("3", 0.03, CardType.DIAMOND, "Buckler", "shield"),
            new Card("4", 0.04, CardType.DIAMOND, "Shield", "shield"),
            new Card("5", 0.05, CardType.DIAMOND, "Shield", "shield"),
            new Card("6", 0.06, CardType.DIAMOND, "Shield", "shield"),
            new Card("7", 0.07, CardType.DIAMOND, "Shield", "shield"),
            new Card("8", 0.08, CardType.DIAMOND, "Shield", "shield"),
            new Card("9", 0.09, CardType.DIAMOND, "Large Shield", "shield"),
            new Card("10", 0.10, CardType.DIAMOND, "Large Shield", "shield"),
            new Card("V", 0.11, CardType.DIAMOND, "Red Mage", "shield"),
            new Card("Q", 0.11, CardType.DIAMOND, "Red Mage", "shield"),
            new Card("K", 0.11, CardType.DIAMOND, "Red Mage", "shield"),

            new Card("A", 0.17, CardType.CLOVE, "Empress", "monster"),
            new Card("2", 0.02, CardType.CLOVE, "Rat", "monster"),
            new Card("3", 0.03, CardType.CLOVE, "Bat", "monster"),
            new Card("4", 0.04, CardType.CLOVE, "Imp", "monster"),
            new Card("5", 0.05, CardType.CLOVE, "Goblin", "monster"),
            new Card("6", 0.06, CardType.CLOVE, "Orc", "monster"),
            new Card("7", 0.07, CardType.CLOVE, "Ogre", "monster"),
            new Card("8", 0.08, CardType.CLOVE, "Beholder", "monster"),
            new Card("9", 0.09, CardType.CLOVE, "Medusa", "monster"),
            new Card("10", 0.10, CardType.CLOVE, "Demon", "monster"),
            new Card("J", 0.11, CardType.CLOVE, "Consort", "monster"),
            new Card("Q", 0.13, CardType.CLOVE, "Queen", "monster"),
            new Card("K", 0.15, CardType.CLOVE, "Regent", "monster"),
            new Card("A", 0.17, CardType.SPADE, "Empress", "monster"),
            new Card("2", 0.02, CardType.SPADE, "Slime", "monster"),
            new Card("3", 0.03, CardType.SPADE, "Tunneler", "monster"),
            new Card("4", 0.04, CardType.SPADE, "Fiend", "monster"),
            new Card("5", 0.05, CardType.SPADE, "Drake", "monster"),
            new Card("6", 0.06, CardType.SPADE, "Specter", "monster"),
            new Card("7", 0.07, CardType.SPADE, "Ghost", "monster"),
            new Card("8", 0.08, CardType.SPADE, "Elemental", "monster"),
            new Card("9", 0.09, CardType.SPADE, "Witch", "monster"),
            new Card("10", 0.10, CardType.SPADE, "Familiar", "monster"),
            new Card("V", 0.11, CardType.SPADE, "Consort", "monster"),
            new Card("Q", 0.13, CardType.SPADE, "Queen", "monster"),
            new Card("K", 0.15, CardType.SPADE, "Regent", "monster"),
            new Card("J", 0.21, CardType.JOKER, "Soldunzher", "monster"),
            new Card("J", 0.21, CardType.JOKER, "Soldunzher", "monster")
        };

        public Gee.ArrayList<Card> draw_pile;

        public Deck () {
            draw_pile = new Gee.ArrayList<Card>();
        }

        public void start () {
            foreach (Card c in this.cards) {
                draw_pile.add(c);
            }
        }

        public void shuffle () {
            Gee.ArrayList<Card> shuffle_pile = new Gee.ArrayList<Card>();
            foreach (Card c in this.cards) {
                shuffle_pile.add(c);
            }
            draw_pile = shuffle_cards (shuffle_pile);
        }

        public Card draw_card (CardType? type) {
            int i = 0;
            var rand = new GLib.Rand ();
            switch (type) {
              case CardType.HEART:
                i = (int)Math.floor((rand.double_range(0.0, 1.0) * 10) + 0); break;
              case CardType.DIAMOND:
                i = (int)Math.floor((rand.double_range(0.0, 1.0) * 10) + 13); break;
              case CardType.CLOVE:
                i = (int)Math.floor((rand.double_range(0.0, 1.0) * 10) + 25); break;
              case CardType.SPADE:
                i = (int)Math.floor((rand.double_range(0.0, 1.0) * 10) + 36); break;
              case CardType.JOKER:
                break;
            }

            return draw_pile[i];
        }

      public void return_card (Card card) {
        draw_pile.add (card);
        draw_pile = shuffle_cards (draw_pile);
      }

      public Gee.ArrayList<Card> shuffle_cards (Gee.ArrayList<Card> array) {
        var rand = new GLib.Rand ();
        for (int i = array.size - 1; i > 0; i--) {
          int j = (int)Math.floor(rand.double_range(0.0, 1.0) * (i + 1));
          Card temp = array[i];
          array[i] = array[j];
          array[j] = temp;
        }
        return array;
      }
    }
}