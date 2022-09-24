namespace Soldunzh {
    public class Deck : Object {
        public Card[] cards = {
            new Card("A", 0.11, HEART, (_("White Mage")), "potion"),
            new Card("2", 0.02, HEART, (_("Small Potion")), "potion"),
            new Card("3", 0.03, HEART, (_("Small Potion")), "potion"),
            new Card("4", 0.04, HEART, (_("Medium Potion")), "potion"),
            new Card("5", 0.05, HEART, (_("Medium Potion")), "potion"),
            new Card("6", 0.06, HEART, (_("Medium Potion")), "potion"),
            new Card("7", 0.07, HEART, (_("Medium Potion")), "potion"),
            new Card("8", 0.08, HEART, (_("Medium Potion")), "potion"),
            new Card("9", 0.09, HEART, (_("Large Potion")), "potion"),
            new Card("10", 0.10, HEART, (_("Large Potion")), "potion"),
            new Card("V", 0.11, HEART, (_("White Mage")), "potion"),
            new Card("Q", 0.11, HEART, (_("White Mage")), "potion"),
            new Card("K", 0.11, HEART, (_("White Mage")), "potion"),
            new Card("A", 0.11, DIAMOND, (_("Red Mage")), "shield"),
            new Card("2", 0.02, DIAMOND, (_("Buckler")), "shield"),
            new Card("3", 0.03, DIAMOND, (_("Buckler")), "shield"),
            new Card("4", 0.04, DIAMOND, (_("Shield")), "shield"),
            new Card("5", 0.05, DIAMOND, (_("Shield")), "shield"),
            new Card("6", 0.06, DIAMOND, (_("Shield")), "shield"),
            new Card("7", 0.07, DIAMOND, (_("Shield")), "shield"),
            new Card("8", 0.08, DIAMOND, (_("Shield")), "shield"),
            new Card("9", 0.09, DIAMOND, (_("Large Shield")), "shield"),
            new Card("10", 0.10, DIAMOND, (_("Large Shield")), "shield"),
            new Card("V", 0.11, DIAMOND, (_("Red Mage")), "shield"),
            new Card("Q", 0.11, DIAMOND, (_("Red Mage")), "shield"),
            new Card("K", 0.11, DIAMOND, (_("Red Mage")), "shield"),
            new Card("A", 0.17, CLOVE, (_("Empress")), "monster"),
            new Card("2", 0.02, CLOVE, (_("Rat")), "monster"),
            new Card("3", 0.03, CLOVE, (_("Bat")), "monster"),
            new Card("4", 0.04, CLOVE, (_("Imp")), "monster"),
            new Card("5", 0.05, CLOVE, (_("Goblin")), "monster"),
            new Card("6", 0.06, CLOVE, (_("Orc")), "monster"),
            new Card("7", 0.07, CLOVE, (_("Ogre")), "monster"),
            new Card("8", 0.08, CLOVE, (_("Beholder")), "monster"),
            new Card("9", 0.09, CLOVE, (_("Medusa")), "monster"),
            new Card("10", 0.10, CLOVE, (_("Demon")), "monster"),
            new Card("J", 0.11, CLOVE, (_("Consort")), "monster"),
            new Card("Q", 0.13, CLOVE, (_("Queen")), "monster"),
            new Card("K", 0.15, CLOVE, (_("Regent")), "monster"),
            new Card("A", 0.17, SPADE, (_("Empress")), "monster"),
            new Card("2", 0.02, SPADE, (_("Slime")), "monster"),
            new Card("3", 0.03, SPADE, (_("Tunneler")), "monster"),
            new Card("4", 0.04, SPADE, (_("Fiend")), "monster"),
            new Card("5", 0.05, SPADE, (_("Drake")), "monster"),
            new Card("6", 0.06, SPADE, (_("Specter")), "monster"),
            new Card("7", 0.07, SPADE, (_("Ghost")), "monster"),
            new Card("8", 0.08, SPADE, (_("Elemental")), "monster"),
            new Card("9", 0.09, SPADE, (_("Witch")), "monster"),
            new Card("10", 0.10, SPADE, (_("Familiar")), "monster"),
            new Card("V", 0.11, SPADE, (_("Consort")), "monster"),
            new Card("Q", 0.13, SPADE, (_("Queen")), "monster"),
            new Card("K", 0.15, SPADE, (_("Regent")), "monster"),
            new Card("J", 0.21, JOKER, (_("First Soldunzher")), "monster"),
            new Card("J", 0.21, JOKER, (_("Second Soldunzher")), "monster")
        };

        public Gee.ArrayList<Card> draw_pile = new Gee.ArrayList<Card>();

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

        public Card draw_card (string? type) {
            int i = 0;
            var rand = new GLib.Rand ();
            switch (type) {
              case HEART:
                i = (int)Math.floor(rand.int_range(0, 12)); break;
              case DIAMOND:
                i = (int)Math.floor(rand.int_range(13, 25)); break;
              case CLOVE:
                i = (int)Math.floor(rand.int_range(26, 38)); break;
              case SPADE:
                i = (int)Math.floor(rand.int_range(39, 51)); break;
              case "":
                i = (int)Math.floor(rand.int_range(0, 51)); break;
            }

            return draw_pile.slice(i,i+1)[0];
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