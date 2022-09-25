namespace Soldunzh {
    public const string HEART = "heart";
    public const string CLOVE = "clove";
    public const string DIAMOND = "diamond";
    public const string SPADE = "spade";
    public const string JOKER = "joker";

    [GtkTemplate (ui = "/io/github/lainsce/Soldunzh/card.ui")]
    public class Card : Gtk.Button {
        [GtkChild]
        public unowned Gtk.Label card_strength;
        [GtkChild]
        public unowned Gtk.Label card_suit;
        [GtkChild]
        public unowned Gtk.Label card_name;

        public string symbol {get; set;}
        public double val {get; set;}
        public string ctype {get; set;}
        public new string name {get; set;}
        public string cprop {get; set;}

        public bool is_flipped = false;

        public MainWindow mw {get; set;}
        private Gtk.CssProvider provider = new Gtk.CssProvider();

        public Card (string sym, double val, string ctype, string name = "Unknown", string cprop) {
            this.symbol = sym;
            this.val = val;
            this.ctype = ctype;
            this.name = name;
            this.cprop = cprop;
        }

        construct {
            this.clicked.connect (() => {
                //
                this.touch (this.mw);
                if (is_flipped) {
                  add_css_class ("flipped");
                } else {
                  remove_css_class ("flipped");
                }
                mw.gauge_hp.fraction = mw.player.health.val;
                mw.gauge_sp.fraction = mw.player.shield.val;
                mw.gauge_xp.fraction = mw.player.exp.val;
                mw.gauge_hp.text = "%0.0f HP".printf(mw.player.health.val * 100);
                mw.gauge_sp.text = "%0.0f / %0.0f SP".printf(mw.player.shield.val * 100, mw.player.shield.break_limit * 100);
                mw.gauge_xp.text = "%0.0f XP".printf(mw.player.exp.val * 100);
            });
            this.get_style_context().add_provider(provider, 999);
        }

        public void install (double vals, string ctypes) {
            var val_dec = (Math.floor(vals * 100)).to_string();
            this.provider.load_from_data ((uint8[]) """
                .card-icon {
                  background-image: url(resource://io/github/lainsce/Soldunzh/%s/%s.svg);
                  background-repeat: no-repeat;
                  background-position: bottom;
                }
            """.printf(ctypes, val_dec));
        }

        public void touch (MainWindow mw) {
            if (this.is_flipped) { return; };
            this.is_flipped = true;
            if (mw.player.health.val < 0.001) { mw.msg = "Player has expired…"; mw.timeline.set_text (mw.msg); };

            switch (cprop) {
              case "monster":
                  mw.player.attack(this);
                  mw.player.exp.val += 0.02;
                  mw.board.update();
                  break;
              case "shield":
                  mw.player.equip_shield(this.val);
                  mw.player.exp.val += 0.02;
                  mw.board.update();
                  break;
              case "potion":
                  mw.player.drink_potion(this.val);
                  mw.player.exp.val += 0.02;
                  mw.board.update();
                  break;
            }

            mw.deck.cards.remove(this);
        }
    }
}
