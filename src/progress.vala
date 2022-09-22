namespace Soldunzh {
    public class Progress : Object {
        public double progress_bar;
        public double val;

        public Progress (double val) {
            this.val = val;
        }

        public void update (double val, double limit = 0.0) {
            if (limit == 0.0) { val = 0.0; limit = 1.0; }
            var ratio = (val / limit);
            var perc = ratio * 100;

            this.progress_bar = perc;
        }
    }
}