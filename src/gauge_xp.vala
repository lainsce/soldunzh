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
