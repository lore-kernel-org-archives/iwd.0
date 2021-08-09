Content-Type: multipart/mixed; boundary="===============7294396930594362070=="
MIME-Version: 1.0
From: Altous, Salahaldeen <Salahaldeen.Altous@leica-camera.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Mon, 09 Aug 2021 07:26:43 +0000
Message-ID: <a42bd72102a83de9205487f27360f63ae50d90a6.camel@leica-camera.com>
In-Reply-To: <602386a2-46cd-c507-153b-901a2b30d40e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7294396930594362070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2021-08-06 at 13:32 -0500, Denis Kenzior wrote:
> Hi Salahaldeen Altous,
>
> On 8/6/21 1:30 AM, salahaldeen.altous(a)leica-camera.com wrote:
> > Hi,
> >
> > I have a device which running as AP point. I would like to know
> > every time there is a new connection/discounntion for this access
> > point.
> > Does iwd API support this? DHCP is enable in AP configuration
> > (EnableNetworkConfiguration=3DTrue)
>
> There isn't a nice API for this just yet.  James pointed you to the
> Diagnostics
> API, but that is really meant to be polled since the information
> changes way too
> frequently and it is only useful as a 'snapshot'.
>
> What you need is a dedicated API that would inform the application
> via D-Bus
> when a new client has connected / disconnect.  This would need to be
> modeled as
> a D-Bus property, or perhaps using an Agent type API.  Not something
> we have
> planned to work on just yet.  Patches are always welcome.

This exactly what my application needs (to be informed via D-Bus when a
new client has connected/disconnected). I will try to check if I can
add it.
>
> Regards,
> -Denis

Regards,
Salahaldeen
Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr. Marita Paa=
sch
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--===============7294396930594362070==--

