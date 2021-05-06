Content-Type: multipart/mixed; boundary="===============3899865397460856707=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: what is your 5GHz rank modifier?
Date: Thu, 06 May 2021 09:46:10 -0700
Message-ID: <e490f3f35be676156906f9710c64848c47515a03.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3899865397460856707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Several others in the past have asked about IWD's 5/2.4GHz ranking and
explained that on their particular network 2.4GHz is heavily preferred.
I have done some minimal testing and also noticed this. IWD heavily
weights signal strength, and in my case the 5GHz network is
significantly lower than 2.4, e.g. -71db vs -43db. Although the signal
is worse I have found that I actually get higher throughput on 5GHz in
many cases. IWD's own data rate calculation (theoretical) is coming up
higher on 5GHz since its 802.11AC/VHT vs 802.11N on 2.4GHz. The issue
boils down to IWD's significant weight on signal strength.

Signal strength is usually the best way for rank calculation especially
when you have two networks using the same technology. For this reason
its probably a bad idea to reduce the signal strength weights.

As we have suggested others, it seems most appropriate to modify IWD's
5GHz ranking specifically to handle this scenario. By default the 5Ghz
rank modifier is unused (set to 1.0). I would like to know if anyone
else has been playing with [Rank].BandModifier5Ghz, and found values
that work for them as we are considering changing the default to better
handle the average user.

Or maybe IWD handles your network just fine the way it is? Either way
it would be nice to get some feedback from the community.

Thanks,
James

--===============3899865397460856707==--

