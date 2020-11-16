Content-Type: multipart/mixed; boundary="===============6933868128185325797=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Segmentation Fault in nl80211_get_reg_do
Date: Mon, 16 Nov 2020 11:30:02 -0600
Message-ID: <e5258719-1d75-1c38-273d-8625e8762c89@gmail.com>
In-Reply-To: <20201115112744.2865.38689@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6933868128185325797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 11/15/20 5:27 AM, mstromberger(a)aon.at wrote:
> I get a segmentation fault (logged on each boot) in  nl80211_get_reg_do. =
After a research the segmentation could tracked down to iwd version > 1.7
> Firmware for regdb (wireless-regdb) is installed and configured. Can you =
please have a look at the debug output?.
> =


This has been reported once or twice to us already.  Please note that this =
is a =

bug in the kernel and should be reported there.  Might want to send this re=
port =

to linux-wireless(a)vger.kernel.org.

Regards,
-Denis


--===============6933868128185325797==--

