Content-Type: multipart/mixed; boundary="===============6565001493543066152=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: Reconnect issues, still
Date: Tue, 09 Feb 2021 17:11:00 -0600
Message-ID: <CAG17S_OkvN8dYd=NOdg_u8Gowv5bsp7=Hbjq8GAVYVUYSW0m6w@mail.gmail.com>
In-Reply-To: <CAG17S_NxQzh-0-fEKNmnXzq3S020ng3VG+b0+sePu0n-hAqzOw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6565001493543066152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

I see a similar result, though the mechanism may be different, on an x86
laptop also running Arch Linux. I use iwd with NetworkManager on this
computer and if I do the same thing (restart radio on router), it also does
not reconnect. NM is 1.28.1dev+7+g3f5df3cdc6 and iwd is v1.11. If it is
force disconnected from the router it never tries to reconnect. If I select
it from the drop down, it reconnects.

I noticed that NM did not set 'AutoConnect=3Dtrue' in the
/var/lib/iwd/spg3.psk file, so I added it and verified that iwctl reports
that this feature is set (It did not before), but even after this was
added, it does not reconnect when it is forced off the network by
rebooting, disconnecting or cycling the radio.

The iwd-monitor log shows lots of this:
{Station} [/net/connman/iwd/0/4] Scanning =3D False
{Station} [/net/connman/iwd/0/4] Scanning =3D True
{Station} [/net/connman/iwd/0/4] Scanning =3D False
{Station} [/net/connman/iwd/0/4] Scanning =3D True
{Removed net.connman.iwd.Network}
[/net/connman/iwd/0/4/426964656e486172726973_psk]
{Added net.connman.iwd.Network}
[/net/connman/iwd/0/4/4e4554474541523336_psk]
      Name =3D NETGEAR36
      Connected =3D False
      Device =3D /net/connman/iwd/0/4
      Type =3D psk
{Station} [/net/connman/iwd/0/4] Scanning =3D False
{Station} [/net/connman/iwd/0/4] Scanning =3D True
{Added net.connman.iwd.Network}
[/net/connman/iwd/0/4/415454687a4366547869_psk]
      Name =3D ATThzCfTxi
      Connected =3D False
      Device =3D /net/connman/iwd/0/4
      Type =3D psk
{Added net.connman.iwd.Network} [/net/connman/iwd/0/4/5261676e6172_psk]
      Name =3D Ragnar
      Connected =3D False
      Device =3D /net/connman/iwd/0/4
      Type =3D psk
{Removed net.connman.iwd.Network}
[/net/connman/iwd/0/4/4d65617374657761_psk]
{Removed net.connman.iwd.Network}
[/net/connman/iwd/0/4/41545470666b766e4378_psk]
{Added net.connman.iwd.Network}
[/net/connman/iwd/0/4/4e4554474541523539_psk]
      Name =3D NETGEAR59
      Connected =3D False
      Device =3D /net/connman/iwd/0/4
      Type =3D psk
{Station} [/net/connman/iwd/0/4] Scanning =3D False
...

Interestingly, none of the logs I made actually showed that iwd had scanned
and found the network that it was just previously connected to in the list
of Network Names. While scanning, it sees the 2.5 network on the same
router, but not the 5Ghz that it knows the password to. If I do a 'iwctl
wlan0 get-networks', the 5Ghz radio is at the top of the list but it does
not connect to it. As soon as I select it in the drop down in NM it
connects.

My questions: With NM, is it supposed to have an 'AutoConnect=3Dtrue' in the
psk file? If so, it does not appear that NM creates that in the psk file.
Why does the scan not pick up the previously connected SSID?

I just tried this again on the RPi and now, today, it reconnects when I
force a disconnect. I have no idea what changed. It absolutely did not
yesterday or the day before. I did  not even reboot the Pi. It also scanned
but never saw the SSID I was intending to use.

Regards,

Keith

On Mon, Feb 8, 2021 at 3:32 PM KeithG <ys3al35l@gmail.com> wrote:

> On Mon, Feb 8, 2021 at 1:53 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
>>
>> To me, it looks like scanning is being driven over D-Bus by invoking
>> Station.Scan().  It also looks like autoconnect has been forced off,
>> perhaps via
>> Station.Disconnect() being invoked?  Hard to tell from this log, but
>> looks iwd
>> isn't trying to autoconnect and would instead rely on connman to trigger
>> the
>> connection.
>>
>> Regards,
>> -Denis
>>
> Denis,
>
> The /var/lib/iwd/*.psk file has "AutoConnect=3Dtrue" set. I did notice th=
at
> last night it had been reset somehow to false after I sent those partial
> logs, but I reset it to true today and still do not get a reconnect.
>
> Running the dbus-monitor script shows exactly that. it gets a
> {Station} [/net/connman/iwd/0/3] Scanning =3D True
> then False periodically, but it never connects. I'll post again on connman
> mail list to see what may need to be adjusted.
>
> If I restart iwd, it connects right away.
>
> Regards,
> Keith
>

--===============6565001493543066152==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5EZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2Vl
IGEgc2ltaWxhciByZXN1bHQsIHRob3VnaCB0aGUgbWVjaGFuaXNtIG1heSBiZSBkaWZmZXJlbnQs
IG9uIGFuIHg4NiBsYXB0b3AgYWxzbyBydW5uaW5nIEFyY2ggTGludXguIEkgdXNlIGl3ZCB3aXRo
IE5ldHdvcmtNYW5hZ2VyIG9uIHRoaXMgY29tcHV0ZXIgYW5kIGlmIEkgZG8gdGhlIHNhbWUgdGhp
bmcgKHJlc3RhcnQgcmFkaW8gb24gcm91dGVyKSwgaXQgYWxzbyBkb2VzIG5vdCByZWNvbm5lY3Qu
IE5NIGlzIDEuMjguMWRldis3K2czZjVkZjNjZGM2IGFuZCBpd2QgaXMgdjEuMTEuIElmIGl0IGlz
IGZvcmNlIGRpc2Nvbm5lY3RlZCBmcm9tIHRoZSByb3V0ZXIgaXQgbmV2ZXIgdHJpZXMgdG8gcmVj
b25uZWN0LiBJZiBJIHNlbGVjdCBpdCBmcm9tIHRoZSBkcm9wIGRvd24sIGl0IHJlY29ubmVjdHMu
IDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgbm90aWNlZCB0aGF0IE5NIGRpZCBub3Qg
c2V0ICYjMzk7QXV0b0Nvbm5lY3Q9dHJ1ZSYjMzk7IGluIHRoZSAvdmFyL2xpYi9pd2Qvc3BnMy5w
c2sgZmlsZSwgc28gSSBhZGRlZCBpdCBhbmQgdmVyaWZpZWQgdGhhdCBpd2N0bCByZXBvcnRzIHRo
YXQgdGhpcyBmZWF0dXJlIGlzIHNldCAoSXQgZGlkIG5vdCBiZWZvcmUpLCBidXQgZXZlbiBhZnRl
ciB0aGlzIHdhcyBhZGRlZCwgaXQgZG9lcyBub3QgcmVjb25uZWN0IHdoZW4gaXQgaXMgZm9yY2Vk
IG9mZiB0aGUgbmV0d29yayBieSByZWJvb3RpbmcsIGRpc2Nvbm5lY3Rpbmcgb3IgY3ljbGluZyB0
aGUgcmFkaW8uIDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBpd2QtbW9uaXRvciBs
b2cgc2hvd3MgbG90cyBvZiB0aGlzOjwvZGl2PjxkaXY+e1N0YXRpb259IFsvbmV0L2Nvbm5tYW4v
aXdkLzAvNF0gU2Nhbm5pbmcgPSBGYWxzZTxicj57U3RhdGlvbn0gWy9uZXQvY29ubm1hbi9pd2Qv
MC80XSBTY2FubmluZyA9IFRydWU8YnI+e1N0YXRpb259IFsvbmV0L2Nvbm5tYW4vaXdkLzAvNF0g
U2Nhbm5pbmcgPSBGYWxzZTxicj57U3RhdGlvbn0gWy9uZXQvY29ubm1hbi9pd2QvMC80XSBTY2Fu
bmluZyA9IFRydWU8YnI+e1JlbW92ZWQgbmV0LmNvbm5tYW4uaXdkLk5ldHdvcmt9IFsvbmV0L2Nv
bm5tYW4vaXdkLzAvNC80MjY5NjQ2NTZlNDg2MTcyNzI2OTczX3Bza108YnI+e0FkZGVkIG5ldC5j
b25ubWFuLml3ZC5OZXR3b3JrfSBbL25ldC9jb25ubWFuL2l3ZC8wLzQvNGU0NTU0NDc0NTQxNTIz
MzM2X3Bza108YnI+wqAgwqAgwqAgTmFtZSA9IE5FVEdFQVIzNjxicj7CoCDCoCDCoCBDb25uZWN0
ZWQgPSBGYWxzZTxicj7CoCDCoCDCoCBEZXZpY2UgPSAvbmV0L2Nvbm5tYW4vaXdkLzAvNDxicj7C
oCDCoCDCoCBUeXBlID0gcHNrPGJyPntTdGF0aW9ufSBbL25ldC9jb25ubWFuL2l3ZC8wLzRdIFNj
YW5uaW5nID0gRmFsc2U8YnI+e1N0YXRpb259IFsvbmV0L2Nvbm5tYW4vaXdkLzAvNF0gU2Nhbm5p
bmcgPSBUcnVlPGJyPntBZGRlZCBuZXQuY29ubm1hbi5pd2QuTmV0d29ya30gWy9uZXQvY29ubm1h
bi9pd2QvMC80LzQxNTQ1NDY4N2E0MzY2NTQ3ODY5X3Bza108YnI+wqAgwqAgwqAgTmFtZSA9IEFU
VGh6Q2ZUeGk8YnI+wqAgwqAgwqAgQ29ubmVjdGVkID0gRmFsc2U8YnI+wqAgwqAgwqAgRGV2aWNl
ID0gL25ldC9jb25ubWFuL2l3ZC8wLzQ8YnI+wqAgwqAgwqAgVHlwZSA9IHBzazxicj57QWRkZWQg
bmV0LmNvbm5tYW4uaXdkLk5ldHdvcmt9IFsvbmV0L2Nvbm5tYW4vaXdkLzAvNC81MjYxNjc2ZTYx
NzJfcHNrXTxicj7CoCDCoCDCoCBOYW1lID0gUmFnbmFyPGJyPsKgIMKgIMKgIENvbm5lY3RlZCA9
IEZhbHNlPGJyPsKgIMKgIMKgIERldmljZSA9IC9uZXQvY29ubm1hbi9pd2QvMC80PGJyPsKgIMKg
IMKgIFR5cGUgPSBwc2s8YnI+e1JlbW92ZWQgbmV0LmNvbm5tYW4uaXdkLk5ldHdvcmt9IFsvbmV0
L2Nvbm5tYW4vaXdkLzAvNC80ZDY1NjE3Mzc0NjU3NzYxX3Bza108YnI+e1JlbW92ZWQgbmV0LmNv
bm5tYW4uaXdkLk5ldHdvcmt9IFsvbmV0L2Nvbm5tYW4vaXdkLzAvNC80MTU0NTQ3MDY2NmI3NjZl
NDM3OF9wc2tdPGJyPntBZGRlZCBuZXQuY29ubm1hbi5pd2QuTmV0d29ya30gWy9uZXQvY29ubm1h
bi9pd2QvMC80LzRlNDU1NDQ3NDU0MTUyMzUzOV9wc2tdPGJyPsKgIMKgIMKgIE5hbWUgPSBORVRH
RUFSNTk8YnI+wqAgwqAgwqAgQ29ubmVjdGVkID0gRmFsc2U8YnI+wqAgwqAgwqAgRGV2aWNlID0g
L25ldC9jb25ubWFuL2l3ZC8wLzQ8YnI+wqAgwqAgwqAgVHlwZSA9IHBzazxicj57U3RhdGlvbn0g
Wy9uZXQvY29ubm1hbi9pd2QvMC80XSBTY2FubmluZyA9IEZhbHNlPC9kaXY+PGRpdj4uLi48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkludGVyZXN0aW5nbHksIG5vbmUgb2YgdGhlIGxvZ3MgSSBt
YWRlIGFjdHVhbGx5IHNob3dlZCB0aGF0IGl3ZCBoYWQgc2Nhbm5lZCBhbmQgZm91bmQgdGhlIG5l
dHdvcmsgdGhhdCBpdCB3YXMganVzdCBwcmV2aW91c2x5IGNvbm5lY3RlZCB0byBpbiB0aGUgbGlz
dCBvZiBOZXR3b3JrIE5hbWVzLiBXaGlsZSBzY2FubmluZywgaXQgc2VlcyB0aGUgMi41IG5ldHdv
cmsgb24gdGhlIHNhbWUgcm91dGVyLCBidXQgbm90IHRoZSA1R2h6IHRoYXQgaXQga25vd3MgdGhl
IHBhc3N3b3JkIHRvLiBJZiBJIGRvIGEgJiMzOTtpd2N0bCB3bGFuMCBnZXQtbmV0d29ya3MmIzM5
OywgdGhlIDVHaHogcmFkaW8gaXMgYXQgdGhlIHRvcCBvZiB0aGUgbGlzdCBidXQgaXQgZG9lcyBu
b3QgY29ubmVjdCB0byBpdC4gQXMgc29vbiBhcyBJIHNlbGVjdCBpdCBpbiB0aGUgZHJvcCBkb3du
IGluIE5NIGl0IGNvbm5lY3RzLiA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk15IHF1ZXN0aW9u
czogV2l0aCBOTSwgaXMgaXQgc3VwcG9zZWQgdG8gaGF2ZSBhbiAmIzM5O0F1dG9Db25uZWN0PXRy
dWUmIzM5OyBpbiB0aGUgcHNrIGZpbGU/IElmIHNvLCBpdCBkb2VzIG5vdCBhcHBlYXIgdGhhdCBO
TSBjcmVhdGVzIHRoYXQgaW4gdGhlIHBzayBmaWxlLiBXaHkgZG9lcyB0aGUgc2NhbiBub3QgcGlj
ayB1cCB0aGUgcHJldmlvdXNseSBjb25uZWN0ZWQgU1NJRD88YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGp1c3QgdHJpZWQgdGhpcyBhZ2FpbiBvbiB0aGUgUlBpIGFuZCBub3csIHRvZGF5
LCBpdCByZWNvbm5lY3RzIHdoZW4gSSBmb3JjZSBhIGRpc2Nvbm5lY3QuIEkgaGF2ZSBubyBpZGVh
IHdoYXQgY2hhbmdlZC4gSXQgYWJzb2x1dGVseSBkaWQgbm90IHllc3RlcmRheSBvciB0aGUgZGF5
IGJlZm9yZS4gSSBkaWTCoCBub3QgZXZlbiByZWJvb3QgdGhlIFBpLiBJdCBhbHNvIHNjYW5uZWQg
YnV0IG5ldmVyIHNhdyB0aGUgU1NJRCBJIHdhcyBpbnRlbmRpbmcgdG8gdXNlLiA8YnI+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S2Vp
dGg8YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gTW9uLCBGZWIgOCwgMjAyMSBhdCAzOjMyIFBNIEtl
aXRoRyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnlzM2FsMzVsQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPnlzM2FsMzVsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+T24gTW9uLCBGZWIgOCwgMjAyMSBhdCAxOjUzIFBN
IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGJyPgpUbyBtZSwgaXQgbG9va3MgbGlrZSBz
Y2FubmluZyBpcyBiZWluZyBkcml2ZW4gb3ZlciBELUJ1cyBieSBpbnZva2luZyA8YnI+ClN0YXRp
b24uU2NhbigpLsKgIEl0IGFsc28gbG9va3MgbGlrZSBhdXRvY29ubmVjdCBoYXMgYmVlbiBmb3Jj
ZWQgb2ZmLCBwZXJoYXBzIHZpYSA8YnI+ClN0YXRpb24uRGlzY29ubmVjdCgpIGJlaW5nIGludm9r
ZWQ/wqAgSGFyZCB0byB0ZWxsIGZyb20gdGhpcyBsb2csIGJ1dCBsb29rcyBpd2QgPGJyPgppc24m
IzM5O3QgdHJ5aW5nIHRvIGF1dG9jb25uZWN0IGFuZCB3b3VsZCBpbnN0ZWFkIHJlbHkgb24gY29u
bm1hbiB0byB0cmlnZ2VyIHRoZSA8YnI+CmNvbm5lY3Rpb24uPGJyPgo8YnI+ClJlZ2FyZHMsPGJy
PgotRGVuaXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+RGVuaXMsPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5UaGUgL3Zhci9saWIvaXdkLyoucHNrIGZpbGUgaGFzICZxdW90O0F1dG9Db25uZWN0PXRy
dWUmcXVvdDsgc2V0LiBJIGRpZCBub3RpY2UgdGhhdCBsYXN0IG5pZ2h0IGl0IGhhZCBiZWVuIHJl
c2V0IHNvbWVob3cgdG8gZmFsc2UgYWZ0ZXIgSSBzZW50IHRob3NlIHBhcnRpYWwgbG9ncywgYnV0
IEkgcmVzZXQgaXQgdG8gdHJ1ZSB0b2RheSBhbmQgc3RpbGwgZG8gbm90IGdldCBhIHJlY29ubmVj
dC48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SdW5uaW5nIHRoZSBkYnVzLW1vbml0b3Ig
c2NyaXB0IHNob3dzIGV4YWN0bHkgdGhhdC4gaXQgZ2V0cyBhIDxicj48L2Rpdj48ZGl2PntTdGF0
aW9ufSBbL25ldC9jb25ubWFuL2l3ZC8wLzNdIFNjYW5uaW5nID0gVHJ1ZSA8YnI+PC9kaXY+PGRp
dj50aGVuIEZhbHNlIHBlcmlvZGljYWxseSwgYnV0IGl0IG5ldmVyIGNvbm5lY3RzLiBJJiMzOTts
bCBwb3N0IGFnYWluIG9uIGNvbm5tYW4gbWFpbCBsaXN0IHRvIHNlZSB3aGF0IG1heSBuZWVkIHRv
IGJlIGFkanVzdGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SWYgSSByZXN0YXJ0IGl3ZCwg
aXQgY29ubmVjdHMgcmlnaHQgYXdheS4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVn
YXJkcyw8L2Rpdj48ZGl2PktlaXRoPGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+
PC9kaXY+Cg==

--===============6565001493543066152==--

