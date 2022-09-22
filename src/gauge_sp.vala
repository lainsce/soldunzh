namespace Soldunzh {
    public class GaugeSP : Gauge {
        public new double limit;
	    public new double val;
        public GaugeSP (double limit) {
            base (limit);
            this.limit = limit;
            this.val = limit;
        }

        public double break_limit = 0.0;
        public bool is_damaged  () {
            if (this.break_limit == 0.0) { return false; }
            return true;
        }

        public new void update (double? val) {
            base.progress.update (val, limit);
            if (this.is_damaged () == true) {
              this.val < this.break_limit ? val : (this.break_limit - 1.0);
            } else if (this.val == 0.0) {
              this.val = 0.0;
            } else {
              this.val = val;
            }
         }
    }
}