Content-Type: multipart/mixed; boundary="===============8082683730046142116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Fri, 06 Aug 2021 13:32:41 -0500
Message-ID: <602386a2-46cd-c507-153b-901a2b30d40e@gmail.com>
In-Reply-To: <20210806063051.2797.40602@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8082683730046142116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen Altous,

On 8/6/21 1:30 AM, salahaldeen.altous(a)leica-camera.com wrote:
> Hi,
> =

> I have a device which running as AP point. I would like to know every tim=
e there is a new connection/discounntion for this access point.
> Does iwd API support this? DHCP is enable in AP configuration (EnableNetw=
orkConfiguration=3DTrue)

There isn't a nice API for this just yet.  James pointed you to the Diagnos=
tics =

API, but that is really meant to be polled since the information changes wa=
y too =

frequently and it is only useful as a 'snapshot'.

What you need is a dedicated API that would inform the application via D-Bu=
s =

when a new client has connected / disconnect.  This would need to be modele=
d as =

a D-Bus property, or perhaps using an Agent type API.  Not something we hav=
e =

planned to work on just yet.  Patches are always welcome.

Regards,
-Denis
--===============8082683730046142116==--

