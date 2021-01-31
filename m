Content-Type: multipart/mixed; boundary="===============2290601169128872631=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Sun, 31 Jan 2021 09:44:39 -0600
Message-ID: <CAG17S_NVgvtXFqZQdn974imgypqb8F3g5zTP0Cx0dP55a4v1yw@mail.gmail.com>
In-Reply-To: <CAG17S_OG84KADM-HVK12DHYf2o_pGqeZa-iGY1Y-feHFTCMgCQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2290601169128872631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 30, 2021 at 2:25 PM KeithG <ys3al35l@gmail.com> wrote:

> it lives! This is the latest git built as
> iwd-git-r5142.065f19b-1-aarch64.pkg.tar.xz on Arch running  on a RPiB3+
>
> I have not tried using the iwd network management, but when I use connman,
> I can create a 'tether' interface and connect to it.
> This starts it on 192.168.0.1
> connmanctl tether wifi on myssid password
> this stops it.
> connmanctl tether wlan0 off
>
> I'll try iwd alone next, but this is a great development for the
> RaspberryPi community, IMO.
>
> Thanks!
>
> On Sat, Jan 30, 2021 at 5:47 AM Paul Menzel <pmenzel@molgen.mpg.de> wro=
te:
>
>>
>> Dear James, Dear Keith,
>>
>>
>> Am 29.01.21 um 02:37 schrieb James Prestwood:
>>
>> > <snip>
>> >> When I restart the AP from iwctl, I can connect again.
>> >> What I do not yet know how to do, though, is assign an ip address to
>> >> the ap and then have it be a dhcp server to serve out a dhcp address
>> >> to the connecting computer. I found this online and took a stab, but
>> >> it did not assign an address, though the computer did 'attach'.
>> >
>> > Yes this is exactly the behavior we are seeing as well. I do have a
>> > patch which fixes the disconnect issue and allows the same client to
>> > connect again but we've actually got more problems than this. My recent
>> > patches 'fixing' AP mode is somewhat of a hack in all honesty. It
>> > allows the 4-way handshake to happen but not the GTK handshake. This
>> > means no group traffic which breaks DHCP.
>> >
>> > I won't bore you with details but it boils down to brcmfmac being (as
>> > far as we can tell) broken when used this way.
>>
>> Are the Linux kernel subsystem maintainers (BROADCOM BRCM80211
>> IEEE802.11n WIRELESS DRIVER) aware of this issue?
>>
>> > We are going to investigate handshake offloading which might fix it,
>> > but we just don't know yet. I am expecting offloading to work  but if
>> > not we need to talk with linux-wireless/broadcom about why its broken
>> > or how it supposed to work. Anyways, we hope to have this sorted
>> > soon.
>> [=E2=80=A6]
>>
>>
>> Kind regards,
>>
>> Paul
>>
>
So, I finally tried running iwd in 'standalone' ap mode (no connman). It
still connects but even though I have this for my main.conf:
[General]
UseDefaultInterface=3Dtrue
EnableNetworkConfiguration=3Dtrue
It connects, but does not set up an IP address. the log shows this:
iwd[32171]: KEY_SEQ not returned in GET_KEY reply
the windows computer I have connected shows this:

Wireless LAN adapter Wi-Fi:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) Wireless-AC 9560 160MHz
   Physical Address. . . . . . . . . : 60-F2-62-AE-70-FE
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Link-local IPv6 Address . . . . . :
fe80::dc8d:27f1:52c2:5b0f%10(Preferred)
   Autoconfiguration IPv4 Address. . : 169.254.91.15(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . . :
   DHCPv6 IAID . . . . . . . . . . . : 90239586
   DHCPv6 Client DUID. . . . . . . . :
00-01-00-01-25-7E-CD-22-34-48-ED-06-F5-9A
   DNS Servers . . . . . . . . . . . : fec0:0:0:ffff::1%1
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBIOS over Tcpip. . . . . . . . : Enabled

Is there any more I can do to help?

--===============2290601169128872631==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gU2F0LCBKYW4gMzAs
IDIwMjEgYXQgMjoyNSBQTSBLZWl0aEcgJmx0OzxhIGhyZWY9Im1haWx0bzp5czNhbDM1bEBnbWFp
bC5jb20iPnlzM2FsMzVsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
PGRpdiBkaXI9Imx0ciI+PGRpdj5pdCBsaXZlcyEgVGhpcyBpcyB0aGUgbGF0ZXN0IGdpdCBidWls
dCBhcyBpd2QtZ2l0LXI1MTQyLjA2NWYxOWItMS1hYXJjaDY0LnBrZy50YXIueHogb24gQXJjaCBy
dW5uaW5nwqAgb24gYSBSUGlCMys8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUg
bm90IHRyaWVkIHVzaW5nIHRoZSBpd2QgbmV0d29yayBtYW5hZ2VtZW50LCBidXQgd2hlbiBJIHVz
ZSBjb25ubWFuLCBJIGNhbiBjcmVhdGUgYSAmIzM5O3RldGhlciYjMzk7IGludGVyZmFjZSBhbmQg
Y29ubmVjdCB0byBpdC48L2Rpdj48ZGl2PlRoaXMgc3RhcnRzIGl0IG9uIDE5Mi4xNjguMC4xPGJy
PjwvZGl2PjxkaXY+Y29ubm1hbmN0bCB0ZXRoZXIgd2lmaSBvbiBteXNzaWQgcGFzc3dvcmQ8L2Rp
dj48ZGl2PnRoaXMgc3RvcHMgaXQuIDxicj48L2Rpdj48ZGl2PmNvbm5tYW5jdGwgdGV0aGVyIHds
YW4wIG9mZjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bGwgdHJ5IGl3ZCBhbG9uZSBu
ZXh0LCBidXQgdGhpcyBpcyBhIGdyZWF0IGRldmVsb3BtZW50IGZvciB0aGUgUmFzcGJlcnJ5UGkg
Y29tbXVuaXR5LCBJTU8uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MhPGJyPjwvZGl2
PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9
ImdtYWlsX2F0dHIiPk9uIFNhdCwgSmFuIDMwLCAyMDIxIGF0IDU6NDcgQU0gUGF1bCBNZW56ZWwg
Jmx0OzxhIGhyZWY9Im1haWx0bzpwbWVuemVsQG1vbGdlbi5tcGcuZGUiIHRhcmdldD0iX2JsYW5r
Ij5wbWVuemVsQG1vbGdlbi5tcGcuZGU8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxi
cj4KRGVhciBKYW1lcywgRGVhciBLZWl0aCw8YnI+Cjxicj4KPGJyPgpBbSAyOS4wMS4yMSB1bSAw
MjozNyBzY2hyaWViIEphbWVzIFByZXN0d29vZDo8YnI+Cjxicj4KJmd0OyAmbHQ7c25pcCZndDs8
YnI+CiZndDsmZ3Q7IFdoZW4gSSByZXN0YXJ0IHRoZSBBUCBmcm9tIGl3Y3RsLCBJIGNhbiBjb25u
ZWN0IGFnYWluLjxicj4KJmd0OyZndDsgV2hhdCBJIGRvIG5vdCB5ZXQga25vdyBob3cgdG8gZG8s
IHRob3VnaCwgaXMgYXNzaWduIGFuIGlwIGFkZHJlc3MgdG88YnI+CiZndDsmZ3Q7IHRoZSBhcCBh
bmQgdGhlbiBoYXZlIGl0IGJlIGEgZGhjcCBzZXJ2ZXIgdG8gc2VydmUgb3V0IGEgZGhjcCBhZGRy
ZXNzPGJyPgomZ3Q7Jmd0OyB0byB0aGUgY29ubmVjdGluZyBjb21wdXRlci4gSSBmb3VuZCB0aGlz
IG9ubGluZSBhbmQgdG9vayBhIHN0YWIsIGJ1dDxicj4KJmd0OyZndDsgaXQgZGlkIG5vdCBhc3Np
Z24gYW4gYWRkcmVzcywgdGhvdWdoIHRoZSBjb21wdXRlciBkaWQgJiMzOTthdHRhY2gmIzM5Oy48
YnI+CiZndDsgPGJyPgomZ3Q7IFllcyB0aGlzIGlzIGV4YWN0bHkgdGhlIGJlaGF2aW9yIHdlIGFy
ZSBzZWVpbmcgYXMgd2VsbC4gSSBkbyBoYXZlIGE8YnI+CiZndDsgcGF0Y2ggd2hpY2ggZml4ZXMg
dGhlIGRpc2Nvbm5lY3QgaXNzdWUgYW5kIGFsbG93cyB0aGUgc2FtZSBjbGllbnQgdG88YnI+CiZn
dDsgY29ubmVjdCBhZ2FpbiBidXQgd2UmIzM5O3ZlIGFjdHVhbGx5IGdvdCBtb3JlIHByb2JsZW1z
IHRoYW4gdGhpcy4gTXkgcmVjZW50PGJyPgomZ3Q7IHBhdGNoZXMgJiMzOTtmaXhpbmcmIzM5OyBB
UCBtb2RlIGlzIHNvbWV3aGF0IG9mIGEgaGFjayBpbiBhbGwgaG9uZXN0eS4gSXQ8YnI+CiZndDsg
YWxsb3dzIHRoZSA0LXdheSBoYW5kc2hha2UgdG8gaGFwcGVuIGJ1dCBub3QgdGhlIEdUSyBoYW5k
c2hha2UuIFRoaXM8YnI+CiZndDsgbWVhbnMgbm8gZ3JvdXAgdHJhZmZpYyB3aGljaCBicmVha3Mg
REhDUC48YnI+CiZndDsgPGJyPgomZ3Q7IEkgd29uJiMzOTt0IGJvcmUgeW91IHdpdGggZGV0YWls
cyBidXQgaXQgYm9pbHMgZG93biB0byBicmNtZm1hYyBiZWluZyAoYXM8YnI+CiZndDsgZmFyIGFz
IHdlIGNhbiB0ZWxsKSBicm9rZW4gd2hlbiB1c2VkIHRoaXMgd2F5Ljxicj4KPGJyPgpBcmUgdGhl
IExpbnV4IGtlcm5lbCBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMgKEJST0FEQ09NIEJSQ004MDIxMSA8
YnI+CklFRUU4MDIuMTFuIFdJUkVMRVNTIERSSVZFUikgYXdhcmUgb2YgdGhpcyBpc3N1ZT88YnI+
Cjxicj4KJmd0OyBXZSBhcmUgZ29pbmcgdG8gaW52ZXN0aWdhdGUgaGFuZHNoYWtlIG9mZmxvYWRp
bmcgd2hpY2ggbWlnaHQgZml4IGl0LDxicj4KJmd0OyBidXQgd2UganVzdCBkb24mIzM5O3Qga25v
dyB5ZXQuIEkgYW0gZXhwZWN0aW5nIG9mZmxvYWRpbmcgdG8gd29ya8KgIGJ1dCBpZjxicj4KJmd0
OyBub3Qgd2UgbmVlZCB0byB0YWxrIHdpdGggbGludXgtd2lyZWxlc3MvYnJvYWRjb20gYWJvdXQg
d2h5IGl0cyBicm9rZW48YnI+CiZndDsgb3IgaG93IGl0IHN1cHBvc2VkIHRvIHdvcmsuIEFueXdh
eXMsIHdlIGhvcGUgdG8gaGF2ZSB0aGlzIHNvcnRlZDxicj4KJmd0OyBzb29uLjxicj4KW+KApl08
YnI+Cjxicj4KPGJyPgpLaW5kIHJlZ2FyZHMsPGJyPgo8YnI+ClBhdWw8YnI+PC9ibG9ja3F1b3Rl
PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PsKgPC9kaXY+PGRpdj4KPGRpdj5TbywgSSBmaW5hbGx5
IHRyaWVkIHJ1bm5pbmcgaXdkIGluICYjMzk7c3RhbmRhbG9uZSYjMzk7IGFwIG1vZGUgKG5vIGNv
bm5tYW4pLiBJdCBzdGlsbCBjb25uZWN0cyBidXQgZXZlbiB0aG91Z2ggSSBoYXZlIHRoaXMgZm9y
IG15IG1haW4uY29uZjo8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTptb25vc3Bh
Y2UiPltHZW5lcmFsXTxicj5Vc2VEZWZhdWx0SW50ZXJmYWNlPXRydWU8YnI+RW5hYmxlTmV0d29y
a0NvbmZpZ3VyYXRpb249dHJ1ZTwvc3Bhbj48L2Rpdj48ZGl2Pkl0IGNvbm5lY3RzLCBidXQgZG9l
cyBub3Qgc2V0IHVwIGFuIElQIGFkZHJlc3MuIHRoZSBsb2cgc2hvd3MgdGhpczo8L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UiPml3ZFszMjE3MV06IEtFWV9TRVEg
bm90IHJldHVybmVkIGluIEdFVF9LRVkgcmVwbHk8L3NwYW4+PC9kaXY+PGRpdj50aGUgd2luZG93
cyBjb21wdXRlciBJIGhhdmUgY29ubmVjdGVkIHNob3dzIHRoaXM6PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlIj5XaXJlbGVzcyBMQU4g
YWRhcHRlciBXaS1GaTo8YnI+PGJyPsKgIMKgQ29ubmVjdGlvbi1zcGVjaWZpYyBETlMgU3VmZml4
IMKgLiA6PGJyPsKgIMKgRGVzY3JpcHRpb24gLiAuIC4gLiAuIC4gLiAuIC4gLiAuIDogSW50ZWwo
UikgV2lyZWxlc3MtQUMgOTU2MCAxNjBNSHo8YnI+wqAgwqBQaHlzaWNhbCBBZGRyZXNzLiAuIC4g
LiAuIC4gLiAuIC4gOiA2MC1GMi02Mi1BRS03MC1GRTxicj7CoCDCoERIQ1AgRW5hYmxlZC4gLiAu
IC4gLiAuIC4gLiAuIC4gLiA6IFllczxicj7CoCDCoEF1dG9jb25maWd1cmF0aW9uIEVuYWJsZWQg
LiAuIC4gLiA6IFllczxicj7CoCDCoExpbmstbG9jYWwgSVB2NiBBZGRyZXNzIC4gLiAuIC4gLiA6
IGZlODA6OmRjOGQ6MjdmMTo1MmMyOjViMGYlMTAoUHJlZmVycmVkKTxicj7CoCDCoEF1dG9jb25m
aWd1cmF0aW9uIElQdjQgQWRkcmVzcy4gLiA6IDE2OS4yNTQuOTEuMTUoUHJlZmVycmVkKTxicj7C
oCDCoFN1Ym5ldCBNYXNrIC4gLiAuIC4gLiAuIC4gLiAuIC4gLiA6IDI1NS4yNTUuMC4wPGJyPsKg
IMKgRGVmYXVsdCBHYXRld2F5IC4gLiAuIC4gLiAuIC4gLiAuIDo8YnI+wqAgwqBESENQdjYgSUFJ
RCAuIC4gLiAuIC4gLiAuIC4gLiAuIC4gOiA5MDIzOTU4Njxicj7CoCDCoERIQ1B2NiBDbGllbnQg
RFVJRC4gLiAuIC4gLiAuIC4gLiA6IDAwLTAxLTAwLTAxLTI1LTdFLUNELTIyLTM0LTQ4LUVELTA2
LUY1LTlBPGJyPsKgIMKgRE5TIFNlcnZlcnMgLiAuIC4gLiAuIC4gLiAuIC4gLiAuIDogZmVjMDow
OjA6ZmZmZjo6MSUxPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZmVjMDowOjA6ZmZmZjo6MiUxPGJyPsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmVjMDowOjA6ZmZmZjo6
MyUxPGJyPsKgIMKgTmV0QklPUyBvdmVyIFRjcGlwLiAuIC4gLiAuIC4gLiAuIDogRW5hYmxlZDwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UiPjxicj48
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlIj48Zm9u
dCBmYWNlPSJhcmlhbCxzYW5zLXNlcmlmIj5JcyB0aGVyZSBhbnkgbW9yZSBJIGNhbiBkbyB0byBo
ZWxwPzwvZm9udD48L3NwYW4+PC9kaXY+wqAgPGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============2290601169128872631==--

