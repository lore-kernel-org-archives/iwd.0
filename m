Content-Type: multipart/mixed; boundary="===============1040459405318712645=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: >=iwd-1.8: crash in dmesg at boot
Date: Tue, 20 Oct 2020 11:42:06 -0500
Message-ID: <1420f2a8-cbe0-6885-8c15-76f719269f2a@gmail.com>
In-Reply-To: <d163a616006b4fc97fc7af2048b19d19068ff74e.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1040459405318712645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> =

> Side note: wpa_supplicant likely doesn't have this problem since it
> does not include ATTR_WIPHY with its GET_REG call AFAIK. Anyone know if
> GET_REG is intended to be per-phy? Or why we are including ATTR_WIPHY?
> =


from linux/nl80211.h:
"
  @NL80211_CMD_GET_REG: ask the wireless core to send us its currently set =

regulatory domain. If %NL80211_ATTR_WIPHY is specified and the device has a =

private regulatory domain, it will be returned. Otherwise, the global regdo=
main =

will be returned.

A device will have a private regulatory domain if it uses the regulatory_hi=
nt() =

API. Even when a private regdomain is used the channel information will sti=
ll be =

mended according to further hints from the regulatory core to help with com=
pliance.
"

So looks like wpa_s always requests the global domain, while iwd is in theo=
ry =

more correct and requests a per-wiphy one.

Regards,
-Denis
--===============1040459405318712645==--

