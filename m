Content-Type: multipart/mixed; boundary="===============1953922084578107861=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
Date: Thu, 05 Aug 2021 08:07:04 +0200
Message-ID: <20210805060704.maeaww6q75x4obqy@beryllium.lan>
In-Reply-To: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1953922084578107861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

On Wed, Aug 04, 2021 at 06:23:14PM -0300, Ariel D'Alessandro wrote:
> Hi all, Daniel:
> =

> WPA3 support has been recently added to connman (wpa_supplicant). As
> we've been discussing on a previous thread, this only supports
> WPA3-Personal-only mode.
> =

> This RFC patchset adds support for WPA3-Personal transition mode, which
> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
> =

> Based on the AP accepted key management protocols, connman configures
> wpa_supplicant as follows:
> =

> * WPA3-Personal-only mode: key_mgmt=3D"SAE" ; ieee80211w=3D2
> * WPA3-Personal transition mode: key_mgmt=3D"SAE WPA-PSK" ; ieee80211w=3D1
> =

> This patch applies cleanly on top of current master branch (commit
> e36a38d8).
> =

> I'd like to hear any thoughts you might have about this.
> For reference, see wpa_supplicant configuration [0].

This looks good. If no one speaks up I am going to apply it.

Daniel

ps: we have a new mailing list (connman(a)lists.linux.dev). The old one
was shutdown.


> =

> Regards,
> Ariel D'Alessandro
> =

> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
> =

> Ariel D'Alessandro (1):
>   gsupplicant: Add support for WPA3-Personal transition mode
> =

>  gsupplicant/supplicant.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> =

> -- =

> 2.30.2
>=20
--===============1953922084578107861==--

