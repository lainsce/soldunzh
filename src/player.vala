namespace Soldunzh {
    public class Player : Object {
        public Soldunzh.GaugeHP health = new Soldunzh.GaugeHP (0.21);
        public Soldunzh.GaugeSP shield = new Soldunzh.GaugeSP (0.0);
        public Soldunzh.GaugeXP exp = new Soldunzh.GaugeXP (0.0);

        public bool can_drink = true;
        public bool has_escaped = false;
        private Soldunzh.MainWindow mw = null;

        public Player (MainWindow mw) {
            this.mw = mw;
        }

        public void install () {
            health.val = 0.21;
            shield.break_limit = 0.0;
            shield.val = 0.0;
            exp.val = 0.0;
            exp.limit = 1;

            can_drink = true;
            has_escaped = false;

            update (mw, health.val, shield.val, exp.val);
        }

        public void update (MainWindow mw, double health, double shield, double exp) {
            if (this.health.val < 0.01) {
                mw.card1.add_css_class ("flipped");
                mw.card2.add_css_class ("flipped");
                mw.card3.add_css_class ("flipped");
                mw.card4.add_css_class ("flipped");
                var dialog = new Adw.MessageDialog (mw, _("Game Over"), null);
		        dialog.set_body (_("The player is lost in the mists of Soldunzh."));
		        dialog.add_response ("clear",  _("Try Again"));
		        dialog.set_response_appearance ("clear", Adw.ResponseAppearance.DESTRUCTIVE);
		        dialog.set_default_response ("clear");
		        dialog.response.connect ((response) => {
		            switch (response) {
		                case "clear":
		                    mw.stack.set_visible_child_name ("overview");
		                    dialog.close ();
		                    this.health.val = 0.21;
		                    break;
		                default:
		                    dialog.close ();
		                    return;
		            }
		        });

		        dialog.present ();
            } else if (this.can_escape(mw) == true) {
              mw.run_button.sensitive = true;
            } else {
              mw.run_button.sensitive = false;
            }

            this.health.update (health);
            this.shield.update (shield);
            this.exp.update (exp);
        }


        public void attack (Card card) {
            var attack_value = card.val;
            var damages = attack_value;

            // Shield
            if (this.shield.val > 0.0) {
              // Damaged shield
              if (this.shield.is_damaged () == true && attack_value >= this.shield.break_limit) {
                this.shield.val = 0.0;
                this.shield.break_limit = 0.0;
                mw.msg = (_("Your shield broke."));
                mw.timeline.set_text (mw.msg);
                this.shield.update(this.shield.val);
              } else {
                this.shield.break_limit = attack_value;
                damages = attack_value > this.shield.val ? (int)Math.fabs(attack_value - this.shield.val) : 0;
                mw.msg = (_("Your shield absorbed the blow."));
                mw.timeline.set_text (mw.msg);
                this.shield.update(this.shield.val);
              }
            }

            // Damages went through
            if (damages > 0.0) {
              this.health.update(this.health.val - damages);
            }

            // Timeline
            if (this.health.val < 0.01) {
              mw.msg = (_("The ")) + card.name + (_(" killed you."));
		      mw.timeline.set_text (mw.msg);
              mw.board.dungeon_failed ();
              this.update(mw, this.health.val, this.shield.val, this.exp.val);
            } else {
              string oc = damages > 0.0 ? (_("Battled")) : (_("Killed"));
              mw.msg = oc + (_(" the ")) + card.name + ".";
		      mw.timeline.set_text (mw.msg);
            }

            // Experience
            this.exp.val += 0.02;

            this.can_drink = true;
            mw.is_complete = false;
		    this.health.update(this.health.val);
            this.shield.update(this.shield.val);
        }

        public void equip_shield (double shield_value) {
            this.shield.val = shield_value;
            this.shield.break_limit = 0.0;

            mw.msg = (_("Equipped shield."));
		    mw.timeline.set_text (mw.msg);

            this.shield.val = shield_value;
            this.can_drink = true;
            mw.is_complete = false;
            this.health.update(this.health.val);
            this.shield.update(this.shield.val);
        }

        public void drink_potion (double potion_value) {
            if (this.can_drink == false) {
              mw.msg = (_("Wasted potion!"));
		      mw.timeline.set_text (mw.msg);
              return;
            }
            var new_health = this.health.val + (potion_value);

            this.health.val = new_health <= 0.21 ? new_health : 0.21;
            this.can_drink = false;
            mw.is_complete = false;
            mw.msg = (_("Drank potion."));
		    mw.timeline.set_text (mw.msg);
            this.health.update(this.health.val);
		    this.shield.update(this.shield.val);
        }

        public void escape_room () {
            if (this.can_escape (mw) != true) {
                mw.msg = (_("Cannot escape the room!"));
		        mw.timeline.set_text (mw.msg);
                this.exp.val -= 0.02;
                return;
            }

            this.has_escaped = true;
            this.can_drink = true;

            mw.board.return_cards();
            mw.board.enter_room(false);
            mw.msg = (_("Escaped the room!"));
		    mw.timeline.set_text (mw.msg);
            mw.card1.remove_css_class ("flipped");
            mw.card2.remove_css_class ("flipped");
            mw.card3.remove_css_class ("flipped");
            mw.card4.remove_css_class ("flipped");
        }

        public bool can_escape (MainWindow mw) {
            // Basic Overrides
            if (this.health.val < 0.01) { return true; } // Death
            if (this.exp.val == 0.0) { return true; } // New Game

            // - All monsters have been dealt with. (Easy Mode)
            // - The player has not escaped the previous room. (Normal Mode)
            // - Can never escape. (Hard Mode)

            // Easy
            if (mw.difficulty == 0) {
              if (!this.has_escaped) { return true; }
              if (mw.board.has_monsters()) { mw.msg = (_("Monsters present.")); mw.timeline.set_text (mw.msg); return false; }
              return true;
            }

            // Normal
            if (mw.difficulty == 1) {
              if (!this.has_escaped) { return true; }
              if (mw.board.cards_flipped().size != 3) { mw.msg = (_("Cards remain.")); mw.timeline.set_text (mw.msg); return false; }
              if (mw.board.has_monsters()) { mw.msg = (_("Monsters present.")); mw.timeline.set_text (mw.msg); return false; }
              return true;
            }

            // Hard
            if (mw.difficulty == 2) {
              mw.msg = (_("Cannot escape (Expert Difficulty)."));
              mw.timeline.set_text (mw.msg);
              return false;
            }

            return false;
          }
    }
}