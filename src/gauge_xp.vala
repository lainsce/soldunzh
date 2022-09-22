namespace Soldunzh {
    public class GaugeXP : Gauge {
        public new double limit = 0;
	    public new double val;
        public GaugeXP (double limit) {
            base (limit);
            this.limit = limit;
            this.val = limit;
        }

        public new void update (double? val) {
            this.val = val;
            if (this.val > this.limit) { this.val = this.limit; }
            if (this.val < 0.0) { this.val = 0.0; }

            this.progress.update(this.val, this.limit);
        }
    }
}