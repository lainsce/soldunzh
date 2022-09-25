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
        [GtkChild]
        public unowned Gtk.Box card_holder;

        public Player player = null;
        public Board board = null;
        public Deck deck = null;
        public Progress progress = null;
        public int difficulty = 0;
        public string msg = "";
        public bool is_complete;
        public MainWindow? mw {get; set;}

        public MainWindow (Gtk.Application app) {
            Object (application: app);

            var adwsm = Adw.StyleManager.get_default ();
            adwsm.set_color_scheme (Adw.ColorScheme.PREFER_DARK);
            this.mw = (MainWindow) app.get_active_window ();
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
		            msg = "You enter the Soldunzh lands\nat Easy difficulty.";
		            timeline.set_text (msg);

                    run_button.visible = true;
		            run_button.clicked.connect (() => {
                        player.escape_room ();
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
		            msg = "You enter the Soldunzh lands\nat Medium difficulty.";
		            timeline.set_text (msg);

                    run_button.visible = true;
		            run_button.clicked.connect (() => {
                        player.escape_room ();
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
		            msg = "You enter the Soldunzh lands\nat Hard difficulty.";
		            timeline.set_text (msg);

		            run_button.visible = false;
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
		                    mw.board.remove_cards ();
		                    mw.player.health.val = 0.21;
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
