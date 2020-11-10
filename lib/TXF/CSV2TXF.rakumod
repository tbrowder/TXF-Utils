# Copyright 2012 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

unit module TXF::CSV2TXF;

class F8949-transaction {
    # why no num shares on the form?
    #   because the num shares are part of the description on IRS Form 8949
    has      $.a-desc          is rw = ''; # Form 8949 this includes number of shares
    has Date $.b-date-acquired is rw;      # output fmt: mm/dd/yyyy
    has Date $.c-date-sold     is rw;      # output fmt: mm/dd/yyyy
    has      $.d-proceeds      is rw = 0;  # dollars (use IRS rounding rules)
    has      $.e-basis         is rw = 0;  # dollars (use IRS rounding rules)
    has      $.f-adjust-code   is rw = ''; # if any
    has      $.g-adjust-amount is rw = 0;  # dollars, if any (use IRS rounding rules)
    # worksheet values for calculating adjustments to basis
    has      $.ws1 is rw;
    has      $.ws2 is rw;
    has      $.ws3 is rw;
    has      $.ws4 is rw;

    # additional attrs to be calculated if possible
    has      $.symbol is rw;
    has      $.shares is rw;

    method finish-building(:$debug) {
    }

    method set-attr(:$attr!, :$value!, :$debug) {
        given $attr {
            # 7 mandatory fields
            when /^ a/ { $!a-desc = $value }
            when /^ b/ {
                # need a Date object
                $!b-date-acquired = date2Date $value 
            }
            when /^ c/ {
                # need a Date object
                $!c-date-sold = date2Date $value 
            }
            when /^ d/ { $!d-proceeds = $value }
            when /^ e/ { $!e-basis = $value }
            when /^ f/ { $!f-adjust-code = $value }
            when /^ g/ { $!g-adjust-amount = $value }
            # 4 "optional" fields
            when /line1 $/ { $!ws1 = $value }
            when /line2 $/ { $!ws2 = $value }
            when /line3 $/ { $!ws3 = $value }
            when /line4 $/ { $!ws4 = $value }
            default {
                die "FATAL: Unrecognized attr '$attr'";
            }
        }
    }

    # boxes for Form 8949
    # Part I - Short-term:
    #   A -
    #   B -
    #   C -
    # Part II - Long-term:
    #   D -
    #   E -
    #   F -

    method txf($fh, :$debug) {
        # writes the transaction to the open txf file handle
    }

    method b-date-acquired-str() {
        # fmt: mm/dd/yyyy
    }

    method c-date-sold-str() {
        # fmt: mm/dd/yyyy
    }

} # class Transaction
