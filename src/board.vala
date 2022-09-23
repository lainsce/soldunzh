namespace Soldunzh {
    public class Board : Object {
        public Gee.ArrayList<Card> room = new Gee.ArrayList<Card>();
        MainWindow mw = null;
        public Board (MainWindow mw) {
            this.mw = mw;
        }

        public void enter_room (bool starting_hand = false) {
            remove_cards ();

            if (mw.deck.cards.length > 0) {
              add_card (0, mw.deck.draw_card(CardType.DIAMOND));
              add_card (1, mw.deck.draw_card(CardType.CLOVE));
              add_card (2, mw.deck.draw_card(CardType.HEART));
              add_card (3, mw.deck.draw_card(CardType.SPADE));
            }

            if (starting_hand) {
              mw.card1.remove_css_class ("flipped");
              mw.card2.remove_css_class ("flipped");
              mw.card3.remove_css_class ("flipped");
              mw.card4.remove_css_class ("flipped");
            }

            mw.player.update(mw, mw.player.health.val, mw.player.shield.val, mw.player.exp.val);
            this.update();
        }

        public void add_card (int index, Card card) {
            this.room.insert(index, card);
        }

        public void remove_cards () {
            this.room = new Gee.ArrayList<Card>();
        }

        public void return_cards () {
            if (!this.room[0].is_flipped) { mw.deck.return_card(this.room[0]); }
            if (!this.room[1].is_flipped) { mw.deck.return_card(this.room[1]); }
            if (!this.room[2].is_flipped) { mw.deck.return_card(this.room[2]); }
            if (!this.room[3].is_flipped) { mw.deck.return_card(this.room[3]); }
        }

        public void update () {
            if (mw.player.health.val < 0.01) {
              return;
            }

            if (mw.player.exp.val == mw.player.exp.limit) {
              this.dungeon_complete ();
              return;
            }
            if (this.room[0].is_flipped && this.room[1].is_flipped && this.room[2].is_flipped && this.room[3].is_flipped) {
              Timeout.add (10, () => { mw.board.is_complete (); return false; });
            }

            var card1 = this.room[0];
            var card2 = this.room[1];
            var card3 = this.room[2];
            var card4 = this.room[3];

            mw.card1_strength.label = card1.symbol; mw.card1_name.label = card1.name;
            mw.card2_strength.label = card2.symbol; mw.card2_name.label = card2.name;
            mw.card3_strength.label = card3.symbol; mw.card3_name.label = card3.name;
            mw.card4_strength.label = card4.symbol; mw.card4_name.label = card4.name;

            if (card1.ctype == CardType.HEART) {
                mw.card1_suit.label = "♥";
                mw.card1_suit.add_css_class ("destructive-label");
                mw.card1_strength.add_css_class ("destructive-label");
            } else if (card1.ctype == CardType.CLOVE) {
                mw.card1_suit.label = "♣";
                mw.card1_suit.remove_css_class ("destructive-label");
                mw.card1_strength.remove_css_class ("destructive-label");
            } else if (card1.ctype == CardType.SPADE) {
                mw.card1_suit.label = "♠";
                mw.card1_suit.remove_css_class ("destructive-label");
                mw.card1_strength.remove_css_class ("destructive-label");
            } else if (card1.ctype == CardType.DIAMOND) {
                mw.card1_suit.label = "♦";
                mw.card1_suit.add_css_class ("destructive-label");
                mw.card1_strength.add_css_class ("destructive-label");
            } else {
                mw.card1_suit.label = "👁";
                mw.card1_suit.remove_css_class ("destructive-label");
                mw.card1_strength.add_css_class ("destructive-label");
            }

            if (card2.ctype == CardType.HEART) {
                mw.card2_suit.label = "♥";
                mw.card2_suit.add_css_class ("destructive-label");
                mw.card2_strength.add_css_class ("destructive-label");
            } else if (card2.ctype == CardType.CLOVE) {
                mw.card2_suit.label = "♣";
                mw.card2_suit.remove_css_class ("destructive-label");
                mw.card2_strength.remove_css_class ("destructive-label");
            } else if (card2.ctype == CardType.SPADE) {
                mw.card2_suit.label = "♠";
                mw.card2_suit.remove_css_class ("destructive-label");
                mw.card2_strength.remove_css_class ("destructive-label");
            } else if (card2.ctype == CardType.DIAMOND) {
                mw.card2_suit.label = "♦";
                mw.card2_suit.add_css_class ("destructive-label");
                mw.card2_strength.add_css_class ("destructive-label");
            } else {
                mw.card2_suit.label = "👁";
                mw.card2_suit.remove_css_class ("destructive-label");
                mw.card2_strength.add_css_class ("destructive-label");
            }

            if (card3.ctype == CardType.HEART) {
                mw.card3_suit.label = "♥";
                mw.card3_suit.add_css_class ("destructive-label");
                mw.card3_strength.add_css_class ("destructive-label");
            } else if (card3.ctype == CardType.CLOVE) {
                mw.card3_suit.label = "♣";
                mw.card3_suit.remove_css_class ("destructive-label");
                mw.card3_strength.remove_css_class ("destructive-label");
            } else if (card3.ctype == CardType.SPADE) {
                mw.card3_suit.label = "♠";
                mw.card3_suit.remove_css_class ("destructive-label");
                mw.card3_strength.remove_css_class ("destructive-label");
            } else if (card3.ctype == CardType.DIAMOND) {
                mw.card3_suit.label = "♦";
                mw.card3_suit.add_css_class ("destructive-label");
                mw.card3_strength.add_css_class ("destructive-label");
            } else {
                mw.card3_suit.label = "👁";
                mw.card3_suit.remove_css_class ("destructive-label");
                mw.card3_strength.add_css_class ("destructive-label");
            }

            if (card4.ctype == CardType.HEART) {
                mw.card4_suit.label = "♥";
                mw.card4_suit.add_css_class ("destructive-label");
                mw.card4_strength.add_css_class ("destructive-label");
            } else if (card4.ctype == CardType.CLOVE) {
                mw.card4_suit.label = "♣";
                mw.card4_suit.remove_css_class ("destructive-label");
                mw.card4_strength.remove_css_class ("destructive-label");
            } else if (card4.ctype == CardType.SPADE) {
                mw.card4_suit.label = "♠";
                mw.card4_suit.remove_css_class ("destructive-label");
                mw.card4_strength.remove_css_class ("destructive-label");
            } else if (card4.ctype == CardType.DIAMOND) {
                mw.card4_suit.label = "♦";
                mw.card4_suit.add_css_class ("destructive-label");
                mw.card4_strength.add_css_class ("destructive-label");
            } else {
                mw.card4_suit.label = "👁";
                mw.card4_suit.remove_css_class ("destructive-label");
                mw.card4_strength.add_css_class ("destructive-label");
            }
        }

        public void dungeon_complete () {
            mw.is_complete = true;
            mw.card1.add_css_class ("flipped");
            mw.card2.add_css_class ("flipped");
            mw.card3.add_css_class ("flipped");
            mw.card4.add_css_class ("flipped");
            var dialog = new Adw.MessageDialog (mw, _("You Won!"), null);
		        dialog.set_body (_("The player conquered Soldunzh."));
		        dialog.add_response ("cancel", _("Cancel"));
		        dialog.add_response ("clear",  _("New Game"));
		        dialog.set_response_appearance ("clear", Adw.ResponseAppearance.SUGGESTED);
		        dialog.set_default_response ("clear");
		        dialog.set_close_response ("cancel");
		        dialog.response.connect ((response) => {
		            switch (response) {
		                case "clear":
		                    mw.stack.set_visible_child_name ("overview");
		                    dialog.close ();
		                    break;
		                case "cancel":
		                default:
		                    dialog.close ();
		                    return;
		            }
		        });

		        dialog.present ();
        }

        public void is_complete () {
            mw.player.has_escaped = false;
            this.enter_room (true);
        }

        public void dungeon_failed () {

        }

        public bool is_started () {
            return this.cards_flipped().size > 0;
        }
        public Gee.ArrayList<Card> cards_flipped () {
            Gee.ArrayList<Card> a = new Gee.ArrayList<Card>();
            if (this.room[0] != null && this.room[0].is_flipped) { a.add(this.room[0]); }
            if (this.room[1] != null && this.room[1].is_flipped) { a.add(this.room[1]); }
            if (this.room[2] != null && this.room[2].is_flipped) { a.add(this.room[2]); }
            if (this.room[3] != null && this.room[3].is_flipped) { a.add(this.room[3]); }
            return a;
        }

        public bool has_monsters () {
            return this.cards_monsters().size > 0;
        }
        public Gee.ArrayList<Card> cards_monsters () {
            Gee.ArrayList<Card> a = new Gee.ArrayList<Card>();
            if (this.room[0] != null && this.room[0].cprop == "monster" && this.room[0].is_flipped == false) { a.add(this.room[0]); }
            if (this.room[1] != null && this.room[1].cprop == "monster" && this.room[1].is_flipped == false) { a.add(this.room[1]); }
            if (this.room[2] != null && this.room[2].cprop == "monster" && this.room[2].is_flipped == false) { a.add(this.room[2]); }
            if (this.room[3] != null && this.room[3].cprop == "monster" && this.room[3].is_flipped == false) { a.add(this.room[3]); }
            return a;
        }
    }
}