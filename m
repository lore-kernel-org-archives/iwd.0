Content-Type: multipart/mixed; boundary="===============0288059266059409042=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: How to configure an IoT wifi setup
Date: Thu, 20 May 2021 08:42:47 +0200
Message-ID: <20210520064247.ce64u2y637ofbyna@beryllium.lan>
In-Reply-To: <9edf45db-6cb5-1a9c-68da-5f08ff9332e9@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0288059266059409042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 19, 2021 at 04:20:20PM -0500, Denis Kenzior wrote:
> > If I set up connman by:
> > "# connmanctl tether wifi on SSID password" I can connect and 'see' my
> > new SSID, but I cannot scan for any APs to set up. I do not know how
> > to set the SSID IP address, if this has been enabled in connman.
> =

> Daniel or Marcel can correct me if I'm wrong, but I don't think this is a
> usecase connman supports.  Tethering is just that, sharing your
> ethernet/wwan/whatever connection over wifi.

You are right. ConnMan does not support AP mode. There is no D-Bus API
exposing the AP mode of an WiFi interface. ConnMan does not expose
devices either, so it's not something we could just add.

Thanks,
Daniel
--===============0288059266059409042==--

