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
    [GtkTemplate (ui = "/io/github/lainsce/Soldunzh/window.ui")]
    public class MainWindow : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.ToggleButton easy_button;
        [GtkChild]
        private unowned Gtk.ToggleButton normal_button;
        [GtkChild]
        private unowned Gtk.ToggleButton hard_button;
        [GtkChild]
        private unowned Gtk.Button start_game_button;
        [GtkChild]
        private unowned Gtk.Button new_game_button;
        [GtkChild]
        public unowned Gtk.Button run_button;
        [GtkChild]
        public unowned Adw.ViewStack stack;
        [GtkChild]
        public unowned Gtk.Label timeline;
        [GtkChild]
        public unowned Gtk.ProgressBar gauge_hp;
        [GtkChild]
        public unowned Gtk.ProgressBar gauge_sp;
        [GtkChild]
        public unowned Gtk.ProgressBar gauge_xp;

        // Cards
        [GtkChild]
        public unowned Gtk.Button card1;
        [GtkChild]
        public unowned Gtk.Label card1_strength;
        [GtkChild]
        public unowned Gtk.Label card1_suit;
        [GtkChild]
        public unowned Gtk.Label card1_name;
        [GtkChild]
        public unowned Gtk.Button card2;
        [GtkChild]
        public unowned Gtk.Label card2_strength;
        [GtkChild]
        public unowned Gtk.Label card2_suit;
        [GtkChild]
        public unowned Gtk.Label card2_name;
        [GtkChild]
        public unowned Gtk.Button card3;
        [GtkChild]
        public unowned Gtk.Label card3_strength;
        [GtkChild]
        public unowned Gtk.Label card3_suit;
        [GtkChild]
        public unowned Gtk.Label card3_name;
        [GtkChild]
        public unowned Gtk.Button card4;
        [GtkChild]
        public unowned Gtk.Label card4_strength;
        [GtkChild]
        public unowned Gtk.Label card4_suit;
        [GtkChild]
        public unowned Gtk.Label card4_name;

        public Player player = null;
        public Board board = null;
        public Deck deck = null;
        public Progress progress = null;
        public int difficulty = 0;
        public string msg = "";
        public bool is_complete;

        public MainWindow (Gtk.Application app) {
            Object (application: app);

            var adwsm = Adw.StyleManager.get_default ();
            adwsm.set_color_scheme (Adw.ColorScheme.PREFER_DARK);
        }

        construct {
	        start_game_button.clicked.connect (() => {
		        if (easy_button.active) {
		            stack.set_visible_child_name ("game");
                    difficulty = 0;
		            player = new Player (this);
		            player.install ();
		            gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		            gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		            gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
		            gauge_hp.fraction = player.health.val;
		            gauge_sp.fraction = player.shield.val;
		            gauge_xp.fraction = player.exp.val;
		            deck = new Deck ();
		            board = new Board (this);
		            deck.start ();
		            board.enter_room (true);
		            deck.shuffle ();
		            msg = "You enter the Soldunzh.";
		            timeline.set_text (msg);

		            run_button.clicked.connect (() => {
                        player.escape_room ();
                    });

		            card1.clicked.connect (() => {
                        //
                        var card1c = board.room[0];
		                card1c.touch (this);
		                if (card1c.is_flipped) {
                          card1.add_css_class ("flipped");
                        } else {
                          card1.remove_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card2.clicked.connect (() => {
                        //
                        var card2c = board.room[1];
		                card2c.touch (this);
		                if (card2c.is_flipped) {
                          card2.add_css_class ("flipped");
                        } else {
                          card2.remove_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card3.clicked.connect (() => {
                        //
                        var card3c = board.room[2];
		                card3c.touch (this);
		                if (card3c.is_flipped) {
                          card3.add_css_class ("flipped");
                        } else {
                          card3.remove_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card4.clicked.connect (() => {
                        //
                        var card4c = board.room[3];
		                card4c.touch (this);
		                if (card4c.is_flipped) {
                          card4.add_css_class ("flipped");
                        } else {
                          card4.remove_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		        } else if (normal_button.active) {
		            stack.set_visible_child_name ("game");
                    difficulty = 1;
		            player = new Player (this);
		            player.install ();
		            gauge_hp.fraction = player.health.val;
		            gauge_sp.fraction = player.shield.val;
		            gauge_xp.fraction = player.exp.val;
		            gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		            gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		            gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
		            deck = new Deck ();
		            board = new Board (this);
		            deck.start ();
		            board.enter_room (true);
		            deck.shuffle ();
		            msg = "You enter the Soldunzh.";
		            timeline.set_text (msg);

		            run_button.clicked.connect (() => {
                        player.escape_room ();
                    });

		            card1.clicked.connect (() => {
                        //
                        var card1c = board.room[0];
		                card1c.touch (this);
		                if (card1c.is_flipped) {
                          card1.add_css_class ("flipped");
                        } else {
                          card1.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card2.clicked.connect (() => {
                        //
                        var card2c = board.room[1];
		                card2c.touch (this);
		                if (card2c.is_flipped) {
                          card2.add_css_class ("flipped");
                        } else {
                          card2.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card3.clicked.connect (() => {
                        //
                        var card3c = board.room[2];
		                card3c.touch (this);
		                if (card3c.is_flipped) {
                          card3.add_css_class ("flipped");
                        } else {
                          card3.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card4.clicked.connect (() => {
                        //
                        var card4c = board.room[3];
		                card4c.touch (this);
		                if (card4c.is_flipped) {
                          card4.add_css_class ("flipped");
                        } else {
                          card4.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		        } else if (hard_button.active) {
		            stack.set_visible_child_name ("game");
                    difficulty = 2;
		            player = new Player (this);
		            player.install ();
		            gauge_hp.fraction = player.health.val;
		            gauge_sp.fraction = player.shield.val;
		            gauge_xp.fraction = player.exp.val;
		            gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		            gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		            gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
		            deck = new Deck ();
		            board = new Board (this);
		            deck.start ();
		            board.enter_room (true);
		            deck.shuffle ();
		            msg = "You enter the Soldunzh.";
		            timeline.set_text (msg);

		            run_button.clicked.connect (() => {
                        player.escape_room ();
                    });

		            card1.clicked.connect (() => {
                        //
                        var card1c = board.room[0];
		                card1c.touch (this);
		                if (card1c.is_flipped) {
                          card1.add_css_class ("flipped");
                        } else {
                          card1.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card2.clicked.connect (() => {
                        //
                        var card2c = board.room[1];
		                card2c.touch (this);
		                if (card2c.is_flipped) {
                          card2.add_css_class ("flipped");
                        } else {
                          card2.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card3.clicked.connect (() => {
                        //
                        var card3c = board.room[2];
		                card3c.touch (this);
		                if (card3c.is_flipped) {
                          card3.add_css_class ("flipped");
                        } else {
                          card3.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card4.clicked.connect (() => {
                        //
                        var card4c = board.room[3];
		                card4c.touch (this);
		                if (card4c.is_flipped) {
                          card4.add_css_class ("flipped");
                        } else {
                          card4.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		        } else {
		            // UB: set as easy then.
		            stack.set_visible_child_name ("game");
                    difficulty = 0;
		            player = new Player (this);
		            player.install ();
		            gauge_hp.fraction = player.health.val;
		            gauge_sp.fraction = player.shield.val;
		            gauge_xp.fraction = player.exp.val;
		            gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		            gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		            gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
		            deck = new Deck ();
		            board = new Board (this);
		            deck.start ();
		            board.enter_room (true);
		            deck.shuffle ();
		            msg = "You enter the Soldunzh.";
		            timeline.set_text (msg);

		            run_button.clicked.connect (() => {
                        player.escape_room ();
                    });

		            card1.clicked.connect (() => {
                        //
                        var card1c = board.room[0];
		                card1c.touch (this);
		                if (card1c.is_flipped) {
                          card1.add_css_class ("flipped");
                        } else {
                          card1.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card2.clicked.connect (() => {
                        //
                        var card2c = board.room[1];
		                card2c.touch (this);
		                if (card2c.is_flipped) {
                          card2.add_css_class ("flipped");
                        } else {
                          card2.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card3.clicked.connect (() => {
                        //
                        var card3c = board.room[2];
		                card3c.touch (this);
		                if (card3c.is_flipped) {
                          card3.add_css_class ("flipped");
                        } else {
                          card3.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		            card4.clicked.connect (() => {
                        //
                        var card4c = board.room[3];
		                card4c.touch (this);
		                if (card4c.is_flipped) {
                          card4.add_css_class ("flipped");
                        } else {
                          card4.add_css_class ("flipped");
                        }
                        gauge_hp.fraction = player.health.val;
		                gauge_sp.fraction = player.shield.val;
		                gauge_xp.fraction = player.exp.val;
		                gauge_hp.text = "%0.0f HP".printf(player.health.val * 100);
		                gauge_sp.text = "%0.0f / %0.0f SP".printf(player.shield.val * 100, player.shield.break_limit * 100);
		                gauge_xp.text = "%0.0f XP".printf(player.exp.val * 100);
                    });
		        }
            });
	        new_game_button.clicked.connect (() => {
		        var dialog = new Adw.MessageDialog (this, _("A Journey Is Happening"), null);
		        dialog.set_body (_("Abandon the journey and try again?"));
		        dialog.add_response ("cancel", _("Cancel"));
		        dialog.add_response ("clear",  _("Abandon"));
		        dialog.set_response_appearance ("clear", Adw.ResponseAppearance.DESTRUCTIVE);
		        dialog.set_default_response ("clear");
		        dialog.set_close_response ("cancel");
		        dialog.response.connect ((response) => {
		            switch (response) {
		                case "clear":
		                    stack.set_visible_child_name ("overview");
		                    dialog.close ();
		                    break;
		                case "cancel":
		                default:
		                    dialog.close ();
		                    return;
		            }
		        });
		        dialog.present ();
            });
        }
    }
}
