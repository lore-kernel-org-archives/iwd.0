Content-Type: multipart/mixed; boundary="===============4342362056168077898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Wed, 10 Mar 2021 15:27:25 -0600
Message-ID: <a5901a8f-9970-b381-1932-3362849e14b6@gmail.com>
In-Reply-To: <06fb951fa51a52fe564573044d38156018873b51.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4342362056168077898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Hmm, isn't this completely opposite to the intent of adding this capabil=
ity to
>> brcmfmac?
> =

> Unless there is a way to disable FW roaming we cannot allow station to ro=
am =


Hm, why not?  Isn't the worst case that we run our roam logic as well?  In =

theory we could set the CQM threshold to be more aggressive and attempt roa=
ms =

before the firmware does...

> based on CQM events. We don't have any control when the FW roams so for c=
ards =

> like this I figured it was needed to disable this roaming logic.
> =

> I've only tested this on my single brcmfmac card, which definitely will n=
ot work =


What fails?

> right if station reacts to CQM events. Plus station cannot even do FT on =
these =

> cards anyways.

Sure, and FT is a bit tricky.  But FT is not the only way to roam...

> =

> Maybe Alvin has some insight to this?
> =


Yeah, I'm actually curious why we haven't heard of any NL80211_CMD_ROAM rel=
ated =

issues ?  I believe I remember Alvin reporting that iwd was working fine on=
 his =

brcmfmac hardware + cqm reporting enabled kernel...

Regards,
-Denis
--===============4342362056168077898==--

