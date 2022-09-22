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
    public class Application : Adw.Application {
        public Application () {
            Object (application_id: "io.github.lainsce.Soldunzh", flags: ApplicationFlags.FLAGS_NONE);
        }

        construct {
            ActionEntry[] action_entries = {
                { "about", this.on_about_action },
                { "keys", this.on_help_overlay },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
            this.set_accels_for_action ("app.quit", {"<primary>q"});
            this.set_accels_for_action ("app.help_overlay", {"<Ctrl>question"});
        }

        public override void activate () {
            base.activate ();
            var win = this.active_window;

            if (win == null) {
                win = new Soldunzh.MainWindow (this);
            }
            win.present ();
        }

        private void on_about_action () {
            string[] developers = { "Paulo \"Lains\" Galardi" };
            var about = new Adw.AboutWindow () {
                transient_for = this.active_window,
                application_name = "Soldunzh",
                application_icon = "io.github.lainsce.Soldunzh",
                developer_name = "Paulo \"Lains\" Galardi",
                version = "0.1.0",
                developers = developers,
                copyright = "© 2022 Paulo \"Lains\" Galardi\n© 2016 Hundred Rabbits (idea)",
            };

            about.present ();
        }

        private void on_help_overlay () {
            try {
                var build = new Gtk.Builder ();
                build.add_from_resource ("/io/github/lainsce/Soldunzh/keys.ui");
                var window = (Gtk.ShortcutsWindow) build.get_object ("shortcuts_soldunzh");
            	window.set_transient_for (this.active_window);
                window.show ();
            } catch (Error e) {
                warning ("Failed to open shortcuts window: %s\n", e.message);
            }
	    }
    }
}

int main (string[] args) {
    var app = new Soldunzh.Application ();
    return app.run (args);
}