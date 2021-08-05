Content-Type: multipart/mixed; boundary="===============5198504514648516257=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
Date: Thu, 05 Aug 2021 08:03:21 +0200
Message-ID: <20210805060321.sb63yfi42qzcuydf@beryllium.lan>
In-Reply-To: <39fccc8f-4f53-ccff-97ba-194258f07923@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5198504514648516257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

On Wed, Aug 04, 2021 at 06:17:20PM -0300, Ariel D'Alessandro wrote:
> > Should we check the keymgmt is SAE and only then set the ieee80211w
> > value?
> =

> Thanks for asking that, two answers:
> =

> * `ssid->ieee80211w` only gets sent if key management is SAE, so that'd
> be redundant. See this code block [0]. So, there's no real need to check
> the keymgmt is SAE here, and `required` could be the default value.

Ah yes, that filters out the ieee80211w settings if it's not SAE. Didn't
see it :)

> * On the other hand, my concern now is about supporting SAE transition
> mode. Let's *drop* this patchset and I'll send an RFC patch implementing
> WPA3-Personal transition mode.

Okay :)

Daniel
--===============5198504514648516257==--

