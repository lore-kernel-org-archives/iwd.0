Content-Type: multipart/mixed; boundary="===============7417375345778089329=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [issue] Can't connect to a WPA2-Enterprise network: 4-way
 handshake timeout
Date: Mon, 29 Mar 2021 11:30:03 -0500
Message-ID: <79680adc-7d8a-dfd1-744e-97cfe8c13f85@gmail.com>
In-Reply-To: <YF+4Fg7HwTjVyxhi@cello>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7417375345778089329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arseny,

On 3/28/21 6:05 AM, Arseny Maslennikov wrote:
> Hi everyone!
> =

> I'm running iwd 1.12 on Debian sid, package version 1.12-1.
> I'm trying to connect to a WPA2-Enterprise network with the following
> network config file produced by NetworkManager, to no avail:
> =

> [Security]
> EAP-Method=3DPEAP
> EAP-Identity=3D

So an empty Identity frequently causes some EAP servers to get confused.  I=
n =

theory the outer identity is completely optional, but quite often it is req=
uired =

in practice (probably due to a mis-configured RADIUS server).  Try setting =
it to =

anonymous(a)your.org or using your Phase2 identity.

> EAP-PEAP-Phase2-Method=3DMSCHAPV2
> EAP-PEAP-Phase2-Identity=3D<redacted>
> =

> The password is stored by NM and provided to iwd on-demand.
> The connection fails due to 4-way handshake timeout. Setting the timeout
> period to 15 seconds in /etc/iwd/main.conf does not help, so it doesn't
> look like the APs are that slow.

Right, what seems to be happening from the log you provided is that the AP =
sends =

EAP/RequestIdentity and we reply with an empty one.  It sends an EAP/Fail a=
nd =

re-tries the EAP/RequestIdentity again.  So try what I outlined above first=
 and =

see if you get further.

> =

> If I turn the iwd NM backend off and use wpa_supplicant instead, the
> connection succeeds and I'm able to use the network properly. Various
> Windows, Mac, iOS, Android clients work without issue as well.
> =

> Here follows a log excerpt of wpa_supplicant successfully connecting to
> the same network:
> =

> Dec 04 12:25:39 cello wpa_supplicant[981]: wlan0: Reject scan trigger sin=
ce one is already pending
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: SME: Trying to authenti=
cate with 00:25:84:0e:99:de (SSID=3D'BMK_WIFI' freq=3D5200 MHz)
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: Trying to associate wit=
h 00:25:84:0e:99:de (SSID=3D'BMK_WIFI' freq=3D5200 MHz)
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: Associated with 00:25:8=
4:0e:99:de
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-SUBNET-STATU=
S-UPDATE status=3D0
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-STARTED =
EAP authentication started
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-PROPOSED=
-METHOD vendor=3D0 method=3D25
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-METHOD E=
AP vendor 0 method 25 (PEAP) selected
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-PEER-CER=
T depth=3D0 subject=3D'/CN=3Dplat.redacted.cs.msu.su' hash=3Dad02acd8a22829=
f4a987495194bfbcfa0cb21f6a75eab12746d4c48fbf1e2dfd
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-PEER-ALT=
 depth=3D0 DNS:plat.redacted.cs.msu.su
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-PEER-CER=
T depth=3D0 subject=3D'/CN=3Dplat.redacted.cs.msu.su' hash=3Dad02acd8a22829=
f4a987495194bfbcfa0cb21f6a75eab12746d4c48fbf1e2dfd
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-PEER-ALT=
 depth=3D0 DNS:plat.redacted.cs.msu.su
> Dec 04 12:25:41 cello wpa_supplicant[981]: EAP-MSCHAPV2: Authentication s=
ucceeded
> Dec 04 12:25:41 cello wpa_supplicant[981]: EAP-TLV: TLV Result - Success =
- EAP-TLV/Phase2 Completed
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: CTRL-EVENT-EAP-SUCCESS =
EAP authentication completed successfully
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: WPA: CCMP is used, but =
EAPOL-Key descriptor version (3) is not 2
> Dec 04 12:25:41 cello wpa_supplicant[981]: wlan0: WPA: Interoperability w=
orkaround: allow incorrect (should have been HMAC-SHA1), but stronger (is A=
ES-128-CMAC), descriptor version to be used
> =

> Maybe that "Interoperability workaround" they do is a clue?

Ah we're not even getting this far in the authentication process yet.  This =

seems related to the 4-way handshake which happens after the EAP transactio=
n has =

succeeded.  So lets take it one step at a time.

> =

> If it's really a problem with the network, I have no way to explain it
> to our wifi admins =E2=80=94 they do not recognise the problem and recomm=
end
> to use wpa_supplicant, which works.
> =

> Could this be fixed in iwd? I'm willing to help as much as I can, but
> I'm a WiFi noob and don't really know anything about 802.11i outside
> what's described in doc/wpa-auth.txt.
> =

> I'm also attaching the output of `iwmon --nortnl' launched prior to
> connection.
> =

> Sorry if this has been discussed before, searches on the list for the
> words "EAPoL" and "key descriptor version" give nothing.
> =

> Thanks in advance!
> =


Regards,
-Denis
--===============7417375345778089329==--

