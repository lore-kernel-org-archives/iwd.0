Content-Type: multipart/mixed; boundary="===============8320725631609739353=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: "Multiple sessions detected" during WSC connection
Date: Wed, 04 Nov 2020 15:54:05 -0600
Message-ID: <61fe8362-9475-0a21-1571-5fdadc541b27@gmail.com>
In-Reply-To: <CAPucfFxvCc3BMd8pfti=MN0eS1rorqWbrbTHDhUig51hkPMqzw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8320725631609739353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On 11/4/20 3:29 PM, Bruce Johnson wrote:
> I received the error "Multiple sessions detected" from iwctl after runnin=
g =

> "iwctl wsc wlan0 push-button". The same Wi-Fi card was working with WSC o=
n the =

> same Wi-Fi router when I tried it a week or so ago, and I have since refo=
rmatted =

> the disk of the computer with the Wi-Fi client station. After looking at =
the =

> source of wsc.c, I believe I have bumped into something the code doesn't =

> anticipate correctly in the case of a mesh Wi-Fi installation.

 From the log it looks like iwd is doing everything right...

> =

> I was trying to pair a Qualcomm Atheros QCA986x/988x with an Amplifi HD W=
i-Fi =

> router that has an Amplifi mesh extender. Both units are running with SSI=
D =

> "topcog" on 2.4 GHz and 5 GHz, and they each have an additional SSID, =

> "topcog_5ghz". It looks like iwd gave the pairing a thumbs-down because i=
t was =

> getting the same offer from two different BSSIDs for SSID "topcog" in the=
 5 GHz =

> band. When I unplugged the extender and tried the pairing again, it succe=
eded.

According to WSC 2.0.7 (which seems to be the latest doc):
"During this scan, if the Enrollee discovers more than one Registrar in act=
ive =

PBC mode then the Enrollee SHALL abort its connection attempt and signal a =

=E2=80=9Csession overlap=E2=80=9D error to the user."

"Note: In the case of a dual- band AP and a dual-band station, the station =
may =

discover more than one Registrar in active PBC mode. If the dual-band stati=
on =

does discover more than one Registrar in active PBC mode, one on each RF ba=
nd, =

and the UUID in the Beacon and Probe- Response are the same for all RF band=
s, =

then the station shall not consider this to be a session overlap."

So looks like the spec doesn't explicitly allow wiggle room for the case yo=
u =

encountered where both the AP and repeater with different BSSIDs are operat=
ing =

on the same band and advertising a WSC session.

Regards,
-Denis
--===============8320725631609739353==--

