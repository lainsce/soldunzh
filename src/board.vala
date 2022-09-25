namespace Soldunzh {
    public class Board : Object {
        public Gee.ArrayList<Card> room = new Gee.ArrayList<Card>();
        MainWindow mw = null;
        public Board (MainWindow mw) {
            this.mw = mw;
        }

        public void enter_room (bool starting_hand) {
            remove_cards ();

            if (mw.deck.cards.size > 0) {
              add_card (0, mw.deck.draw_card(starting_hand ? DIAMOND : ""));
            }
            if (mw.deck.cards.size > 0) {
              add_card (1, mw.deck.draw_card(starting_hand ? CLOVE : ""));
            }
            if (mw.deck.cards.size > 0) {
              add_card (2, mw.deck.draw_card(starting_hand ? HEART : ""));
            }
            if (mw.deck.cards.size > 0) {
              add_card (3, mw.deck.draw_card(starting_hand ? SPADE : ""));
            }

            this.room[0].remove_css_class ("flipped");
            this.room[1].remove_css_class ("flipped");
            this.room[2].remove_css_class ("flipped");
            this.room[3].remove_css_class ("flipped");

            mw.player.update(mw, mw.player.health.val, mw.player.shield.val, mw.player.exp.val);
            this.update();
        }

        public void add_card (int index, Card card) {
            this.room.insert(index, card);
            if (card != null)
                mw.card_holder.append (card);
        }

        public void remove_cards () {
            if (this.room.size > 0) {
                Gtk.Widget childs = mw.card_holder.get_first_child();
                while (childs != null) {
                    mw.card_holder.remove(childs);
                    childs = mw.card_holder.get_first_child();
                }
            }
            this.room = new Gee.ArrayList<Card>();
        }

        public void return_cards () {
            if (!this.room[0].is_flipped) { mw.deck.return_card(this.room[0]); }
            if (!this.room[1].is_flipped) { mw.deck.return_card(this.room[1]); }
            if (!this.room[2].is_flipped) { mw.deck.return_card(this.room[2]); }
            if (!this.room[3].is_flipped) { mw.deck.return_card(this.room[3]); }
        }

        public void update () {
            if (mw.player.health.val < 0.001) {
              return;
            }

            if (mw.player.exp.val == mw.player.exp.limit) {
              this.dungeon_complete ();
              return;
            }
            if (this.room[0].is_flipped && this.room[1].is_flipped && this.room[2].is_flipped && this.room[3].is_flipped) {
              Timeout.add (5, () => { mw.board.is_complete (); return false; });
            }

            var card1 = this.room[0];
            var card2 = this.room[1];
            var card3 = this.room[2];
            var card4 = this.room[3];
            make_card (card1);
            make_card (card2);
            make_card (card3);
            make_card (card4);
        }

        private void make_card (Card card) {
            card.mw = this.mw;
            card.card_strength.label = card.symbol; card.card_name.label = card.name + " " + (Math.floor(card.val * 100)).to_string ();
            if (card.ctype == HEART) {
                card.card_suit.label = "♥";
                card.card_suit.add_css_class ("red-label");
                card.card_strength.add_css_class ("red-label");
                card.card_suit.remove_css_class ("black-label");
                card.card_strength.remove_css_class ("black-label");
            } else if (card.ctype == CLOVE) {
                card.card_suit.label = "♣";
                card.card_suit.add_css_class ("black-label");
                card.card_strength.add_css_class ("black-label");
                card.card_suit.remove_css_class ("red-label");
                card.card_strength.remove_css_class ("red-label");
            } else if (card.ctype == SPADE) {
                card.card_suit.label = "♠";
                card.card_suit.add_css_class ("black-label");
                card.card_strength.add_css_class ("black-label");
                card.card_suit.remove_css_class ("red-label");
                card.card_strength.remove_css_class ("red-label");
            } else if (card.ctype == DIAMOND) {
                card.card_suit.label = "♦";
                card.card_suit.add_css_class ("red-label");
                card.card_strength.add_css_class ("red-label");
                card.card_suit.remove_css_class ("black-label");
                card.card_strength.remove_css_class ("black-label");
            } else {
                card.card_suit.label = "👁";
                card.card_suit.add_css_class ("red-label");
                card.card_strength.add_css_class ("black-label");
                card.card_suit.remove_css_class ("black-label");
                card.card_strength.remove_css_class ("red-label");
            }
        }

        public void dungeon_complete () {
            mw.is_complete = true;
            this.room[0].add_css_class ("flipped");
            this.room[1].add_css_class ("flipped");
            this.room[2].add_css_class ("flipped");
            this.room[3].add_css_class ("flipped");
            var dialog = new Adw.MessageDialog (mw, _("You Won!"), null);
		        dialog.set_body (_("The player conquered Soldunzh."));
		        dialog.add_response ("clear",  _("New Game"));
		        dialog.set_response_appearance ("clear", Adw.ResponseAppearance.SUGGESTED);
		        dialog.set_default_response ("clear");
		        dialog.response.connect ((response) => {
		            switch (response) {
		                case "clear":
		                    mw.stack.set_visible_child_name ("overview");
		                    dialog.close ();
		                    break;
		                default:
		                    dialog.close ();
		                    return;
		            }
		        });

		        dialog.present ();
        }

        public void is_complete () {
            mw.player.has_escaped = false;
            this.enter_room (false);
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
