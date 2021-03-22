Content-Type: multipart/mixed; boundary="===============4351263803344865310=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Can't connect to 8021x network
Date: Mon, 22 Mar 2021 10:07:41 -0500
Message-ID: <844ba110-17cd-2e23-9a0c-5558a8f59796@gmail.com>
In-Reply-To: <875z1jwgjx.fsf@wavexx.thregr.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4351263803344865310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On 3/22/21 6:51 AM, Yuri D'Elia wrote:
> Hi everyone.
> =

> Recently my organization upgraded our APs to some Cisco C9115AXI-E from
> some older 3500I (also Cisco).
> =

> iwd used to be able to connect, but not anymore. I can still connect
> through wpa_supplicant, so I suspect an issue with iwd.
> =

> Configuration for the 8021x network is unchanged and as follows:
> =

> [Security]
> EAP-Method=3DPEAP
> EAP-Identity=3Da(a)b.c
> EAP-PEAP-Phase2-Method=3DMSCHAPV2
> EAP-PEAP-Phase2-Identity=3Da(a)b.c
> EAP-PEAP-Phase2-Password=3Dxyz
> =


Looks good.  But you're not validating the certificate, which is probably n=
ot =

great for security...

> When connecting with IWD_TLS_DEBUG=3D1 iwd -d, I normally see this just
> after association:

Hmm, I would have actually expected a lot more output with IWD_TLS_DEBUG be=
ing =

enabled, but maybe it is not getting far enough.

<snip>

> src/station.c:station_handshake_event() Handshaking
> src/netdev.c:netdev_mlme_notify() MLME notification Unknown(139)
> src/netdev.c:netdev_unicast_notify() Unicast notification 129
> src/netdev.c:netdev_control_port_frame_event()
> 4-Way handshake failed for ifindex: 17, reason: 15

So AP sends us the first packet, but we time out some time later.  Can you =
do =

two things:

1. Add the following to /etc/iwd/main.conf
[EAPoL]
MaxHandshakeTime=3D15

See if the handshake proceeds further.  The default timeout is 5 seconds, s=
o if =

the AP or RADIUS server is extremely slow things might time out.  However, =
this =

is probably unlikely.

2. Send us or me privately an iwmon pcap trace of the first packet that the=
 AP =

sends.  Maybe it has something unexpected.  See [1].

Regards,
-Denis

[1] https://iwd.wiki.kernel.org/debugging
--===============4351263803344865310==--

