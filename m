Content-Type: multipart/mixed; boundary="===============8531512642120519720=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Wed, 18 Aug 2021 13:11:43 -0500
Message-ID: <6a81b489-c4fc-7fa3-adbf-a7167774b516@gmail.com>
In-Reply-To: <CACsRnHUM4SjW-mnKU+_9UDcqj3OpEB6q0EG46C1z7WtpQRaVwQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8531512642120519720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/18/21 12:39 PM, Michael Johnson wrote:
> Hi Denis,
> =

> A couple of updates today after some testing.
> =

> Firstly the fix done to add the extended capabilities tags in FT roams
> worked and I had successful 802.11v behaviour with Meraki access
> points. Thank you very much for that.

Awesome, thanks for testing!

> =

> Secondly, Meraki have checked their behavior and are now agreeing that
> the Neighbor Report field does not need to be set for .11k to work
> correctly and that they have a bug relating to the optional SSID tag
> not being included in the message. However they are still saying that
> setting the Neighbor Report field is subjectively "correct" citing
> section 6.3.30 of the 2020 edition of the standard (being completely

Did they quote the exact parts they're interpreting by any chance?  I quick=
ly =

went over this section, but nothing jumps out at me.

> open it is an interpretation rather than solid requirement).
> Personally, I think it makes sense for it to be set when it is
> supported but I don't suppose it makes much difference either way.

Ok.  Let me stare at this section some more.  Generally I agree that there =
is =

probably no harm in setting this bit as the STA.  But, it would be nice to =
have =

a quote from 802.11-2020 (even if it is open to interpretation) that could =
be =

used in the commit message as the justification.

Regards,
-Denis
--===============8531512642120519720==--

