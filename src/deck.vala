/*
 * Copyright 2022 Lains
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Soldunzh {
    public class Deck : Object {
        public Gee.ArrayList<Card> cards = new Gee.ArrayList<Card>();
        public Gee.ArrayList<Card> draw_pile = new Gee.ArrayList<Card>();

        construct {
            cards.add(new Card("A", 0.11, HEART, (_("White Mage")), "potion"));
            cards.add(new Card("2", 0.02, HEART, (_("Small Potion")), "potion"));
            cards.add(new Card("3", 0.03, HEART, (_("Small Potion")), "potion"));
            cards.add(new Card("4", 0.04, HEART, (_("Medium Potion")), "potion"));
            cards.add(new Card("5", 0.05, HEART, (_("Medium Potion")), "potion"));
            cards.add(new Card("6", 0.06, HEART, (_("Medium Potion")), "potion"));
            cards.add(new Card("7", 0.07, HEART, (_("Medium Potion")), "potion"));
            cards.add(new Card("8", 0.08, HEART, (_("Medium Potion")), "potion"));
            cards.add(new Card("9", 0.09, HEART, (_("Large Potion")), "potion"));
            cards.add(new Card("10", 0.10, HEART, (_("Large Potion")), "potion"));
            cards.add(new Card("V", 0.11, HEART, (_("White Mage")), "potion"));
            cards.add(new Card("Q", 0.11, HEART, (_("White Mage")), "potion"));
            cards.add(new Card("K", 0.11, HEART, (_("White Mage")), "potion"));
            cards.add(new Card("A", 0.11, DIAMOND, (_("Red Mage")), "shield"));
            cards.add(new Card("2", 0.02, DIAMOND, (_("Buckler")), "shield"));
            cards.add(new Card("3", 0.03, DIAMOND, (_("Buckler")), "shield"));
            cards.add(new Card("4", 0.04, DIAMOND, (_("Shield")), "shield"));
            cards.add(new Card("5", 0.05, DIAMOND, (_("Shield")), "shield"));
            cards.add(new Card("6", 0.06, DIAMOND, (_("Shield")), "shield"));
            cards.add(new Card("7", 0.07, DIAMOND, (_("Shield")), "shield"));
            cards.add(new Card("8", 0.08, DIAMOND, (_("Shield")), "shield"));
            cards.add(new Card("9", 0.09, DIAMOND, (_("Large Shield")), "shield"));
            cards.add(new Card("10", 0.10, DIAMOND, (_("Large Shield")), "shield"));
            cards.add(new Card("V", 0.11, DIAMOND, (_("Red Mage")), "shield"));
            cards.add(new Card("Q", 0.11, DIAMOND, (_("Red Mage")), "shield"));
            cards.add(new Card("K", 0.11, DIAMOND, (_("Red Mage")), "shield"));
            cards.add(new Card("A", 0.17, CLOVE, (_("Empress")), "monster"));
            cards.add(new Card("2", 0.02, CLOVE, (_("Rat")), "monster"));
            cards.add(new Card("3", 0.03, CLOVE, (_("Bat")), "monster"));
            cards.add(new Card("4", 0.04, CLOVE, (_("Imp")), "monster"));
            cards.add(new Card("5", 0.05, CLOVE, (_("Goblin")), "monster"));
            cards.add(new Card("6", 0.06, CLOVE, (_("Orc")), "monster"));
            cards.add(new Card("7", 0.07, CLOVE, (_("Ogre")), "monster"));
            cards.add(new Card("8", 0.08, CLOVE, (_("Beholder")), "monster"));
            cards.add(new Card("9", 0.09, CLOVE, (_("Medusa")), "monster"));
            cards.add(new Card("10", 0.10, CLOVE, (_("Demon")), "monster"));
            cards.add(new Card("J", 0.11, CLOVE, (_("Consort")), "monster"));
            cards.add(new Card("Q", 0.13, CLOVE, (_("Queen")), "monster"));
            cards.add(new Card("K", 0.15, CLOVE, (_("Regent")), "monster"));
            cards.add(new Card("A", 0.17, SPADE, (_("Empress")), "monster"));
            cards.add(new Card("2", 0.02, SPADE, (_("Slime")), "monster"));
            cards.add(new Card("3", 0.03, SPADE, (_("Tunneler")), "monster"));
            cards.add(new Card("4", 0.04, SPADE, (_("Fiend")), "monster"));
            cards.add(new Card("5", 0.05, SPADE, (_("Drake")), "monster"));
            cards.add(new Card("6", 0.06, SPADE, (_("Specter")), "monster"));
            cards.add(new Card("7", 0.07, SPADE, (_("Ghost")), "monster"));
            cards.add(new Card("8", 0.08, SPADE, (_("Elemental")), "monster"));
            cards.add(new Card("9", 0.09, SPADE, (_("Witch")), "monster"));
            cards.add(new Card("10", 0.10, SPADE, (_("Familiar")), "monster"));
            cards.add(new Card("V", 0.11, SPADE, (_("Consort")), "monster"));
            cards.add(new Card("Q", 0.13, SPADE, (_("Queen")), "monster"));
            cards.add(new Card("K", 0.15, SPADE, (_("Regent")), "monster"));
            cards.add(new Card("J", 0.21, JOKER, (_("First Soldunzher")), "monster"));
            cards.add(new Card("J", 0.21, JOKER, (_("Second Soldunzher")), "monster"));
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

        public Card draw_card (string? type) {
            int i = 0;
            var rand = new GLib.Rand ();
            switch (type) {
              case HEART:
              case "":
                i = (int)Math.floor(rand.int_range(0, 12)); break;
              case DIAMOND:
                i = (int)Math.floor(rand.int_range(13, 25)); break;
              case CLOVE:
                i = (int)Math.floor(rand.int_range(26, 38)); break;
              case SPADE:
                i = (int)Math.floor(rand.int_range(39, 51)); break;
            }

            if (i == draw_pile.size) {
                var card = draw_pile.slice(i,i-1)[0];
                if (card.val > 0.10 && card.val != 0.21) {
                    card.remove_css_class ("red-label");
                    card.remove_css_class ("black-label");
                    card.add_css_class ("white-label");
                } else {
                    if (card.ctype == DIAMOND || card.ctype == HEART) {
                        card.card_name.add_css_class ("red-label");
                        card.card_name.remove_css_class ("black-label");
                    } else if (card.ctype == CLOVE || card.ctype == SPADE) {
                        card.card_name.add_css_class ("black-label");
                        card.card_name.remove_css_class ("red-label");
                    }
                }
                card.install (card.val, card.ctype);
                return card;
            } else {
                var card = draw_pile.slice(i,i+1)[0];
                if (card.val > 0.10 && card.val != 0.21) {
                    card.remove_css_class ("red-label");
                    card.remove_css_class ("black-label");
                    card.add_css_class ("white-label");
                } else {
                    if (card.ctype == DIAMOND || card.ctype == HEART) {
                        card.card_name.add_css_class ("red-label");
                        card.card_name.remove_css_class ("black-label");
                    } else if (card.ctype == CLOVE || card.ctype == SPADE) {
                        card.card_name.add_css_class ("black-label");
                        card.card_name.remove_css_class ("red-label");
                    }
                }
                card.install (card.val, card.ctype);
                return card;
            }
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

