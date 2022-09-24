namespace Soldunzh {
    public const string HEART = "heart";
    public const string CLOVE = "clove";
    public const string DIAMOND = "diamond";
    public const string SPADE = "spade";
    public const string JOKER = "joker";

    public class Card : Gtk.Widget {
        public string symbol {get; set;}
        public double val {get; set;}
        public string ctype {get; set;}
        public new string name {get; set;}
        public string cprop {get; set;}

        public bool is_flipped = false;

        public MainWindow mw {get; set;}

        public Card (string sym, double val, string ctype, string name = "Unknown", string cprop) {
            this.symbol = sym;
            this.val = val;
            this.ctype = ctype;
            this.name = name;
            this.cprop = cprop;
        }

        public void touch (MainWindow mw) {
            if (this.is_flipped) { return; };
            this.is_flipped = true;
            if (mw.player.health.val < 0.01) { mw.msg = "Player has expired…"; mw.timeline.set_text (mw.msg); };

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
        }
    }
}