namespace Soldunzh {
    public class GaugeHP : Gauge {
        public new double limit;
	    public new double val;
        public GaugeHP (double limit) {
            base (limit);
            this.limit = limit;
            this.val = limit;
        }

        public new void update (double? val) {
            base.progress.update (val, limit);

            this.val = val;
         }
    }
}