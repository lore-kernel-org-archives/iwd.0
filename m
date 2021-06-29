Content-Type: multipart/mixed; boundary="===============1698707172854453112=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: DHCP renewal
Date: Tue, 29 Jun 2021 17:23:49 +0100
Message-ID: <CACsRnHVS7cx-NWu0D-U=fByqTgBnxqdNS55d_inFmAKpG4oOvg@mail.gmail.com>
In-Reply-To: <0bb0db6b-8822-46c8-64b7-e1106b4a52e5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1698707172854453112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Denis,

I tracked it down to a problem with capabilities in the systemd service. I
have sent a patch.

Along with the fix, I'm thinking it would be good to have extra logging in
ell/dhcp.c to make these kinds of errors easier to find.
Would you be open to a patch which adds `l_error()` output if the bind
operation fails? I know that `ell/dhcp.c` doesn't currently
have any error output but instead bubbles the errors up. Also I don't know
how fatal this kind of error should really be so maybe
logging isn't enough?

Regards,
Michael

On Mon, 28 Jun 2021 at 18:32, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Michael,
>
> On 6/28/21 12:08 PM, Michael Johnson wrote:
> > Hi all,
> >
> > I'm having a problem with the DHCP component of iwd whereby I have it
> sending
> > the initial request and getting the IP fine but when it comes time for
> renewal
> > (in my case after 1 hour) then there is an error and the DHCP lease is
> left to
> > expire. Turning on the IWD_DHCP_DEBUG flag I get this output:
> >
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:626
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:628
> Entering
> > state: DHCP_STATE_RENEWING
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_request:394
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:633
> Sending
> > request failed: Socket operation on non-socket
>
> This implies that the socket used for the unicast wasn't opened properly.
>
> Try stracing / logging what happens in _dhcp_default_transport_bind().
> Maybe
> one of the sockopts we try to set on the socket is not available?
>
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_release:487
> > Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] l_dhcp_client_stop:1199
> Entering
> > state: DHCP_STATE_INIT
> >
> > Does anyone know what might be causing this? I'm still learning the code
> base
> > but I don't see anything obvious wrong (and I can't be sure this isn't a
> problem
> > with my system).
> > This is with the latest master build of both iwd and ell.
> >
> >
>
> Regards,
> -Denis
>

--===============1698707172854453112==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+VGhhbmtzIERlbmlzLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSB0cmFja2Vk
IGl0IGRvd24gdG8gYSBwcm9ibGVtIHdpdGggY2FwYWJpbGl0aWVzIGluIHRoZSBzeXN0ZW1kIHNl
cnZpY2UuIEkgaGF2ZSBzZW50IGEgcGF0Y2guPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbG9u
ZyB3aXRoIHRoZSBmaXgsIEkmIzM5O20gdGhpbmtpbmcgaXQgd291bGQgYmUgZ29vZCB0byBoYXZl
IGV4dHJhIGxvZ2dpbmcgaW4gZWxsL2RoY3AuYyB0byBtYWtlIHRoZXNlIGtpbmRzIG9mIGVycm9y
cyBlYXNpZXIgdG8gZmluZC7CoDwvZGl2PjxkaXY+V291bGQgeW91IGJlIG9wZW4gdG8gYSBwYXRj
aCB3aGljaMKgYWRkcyBgbF9lcnJvcigpYCBvdXRwdXQgaWYgdGhlIGJpbmQgb3BlcmF0aW9uIGZh
aWxzPyBJIGtub3cgdGhhdCBgZWxsL2RoY3AuY2AgZG9lc24mIzM5O3QgY3VycmVudGx5PC9kaXY+
PGRpdj5oYXZlIGFueSBlcnJvciBvdXRwdXQgYnV0IGluc3RlYWQgYnViYmxlcyB0aGUgZXJyb3Jz
IHVwLiBBbHNvIEkgZG9uJiMzOTt0IGtub3cgaG93IGZhdGFsIHRoaXMga2luZCBvZiBlcnJvciBz
aG91bGQgcmVhbGx5IGJlIHNvIG1heWJlPC9kaXY+PGRpdj5sb2dnaW5nIGlzbiYjMzk7dCBlbm91
Z2g/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDxicj5NaWNoYWVsPC9kaXY+PC9k
aXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21h
aWxfYXR0ciI+T24gTW9uLCAyOCBKdW4gMjAyMSBhdCAxODozMiwgRGVuaXMgS2VuemlvciAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4m
Z3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQs
MjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+SGkgTWljaGFlbCw8YnI+Cjxicj4KT24gNi8yOC8y
MSAxMjowOCBQTSwgTWljaGFlbCBKb2huc29uIHdyb3RlOjxicj4KJmd0OyBIaSBhbGwsPGJyPgom
Z3Q7IDxicj4KJmd0OyBJJiMzOTttIGhhdmluZyBhIHByb2JsZW0gd2l0aCB0aGUgREhDUCBjb21w
b25lbnTCoG9mIGl3ZCB3aGVyZWJ5IEkgaGF2ZSBpdCBzZW5kaW5nIDxicj4KJmd0OyB0aGUgaW5p
dGlhbCByZXF1ZXN0IGFuZCBnZXR0aW5nIHRoZSBJUCBmaW5lIGJ1dCB3aGVuIGl0IGNvbWVzIHRp
bWUgZm9yIHJlbmV3YWwgPGJyPgomZ3Q7IChpbiBteSBjYXNlIGFmdGVyIDEgaG91cikgdGhlbiB0
aGVyZSBpcyBhbiBlcnJvciBhbmQgdGhlIERIQ1AgbGVhc2UgaXMgbGVmdCB0byA8YnI+CiZndDsg
ZXhwaXJlLiBUdXJuaW5nIG9uIHRoZSBJV0RfREhDUF9ERUJVRyBmbGFnIEkgZ2V0IHRoaXMgb3V0
cHV0Ojxicj4KJmd0OyA8YnI+CiZndDsgSnVuIDI4IDE0OjQ2OjI1IHAzLTEzMzcgaXdkWzcyODFd
OiBbREhDUHY0XSBkaGNwX2NsaWVudF90MV9leHBpcmVkOjYyNjxicj4KJmd0OyBKdW4gMjggMTQ6
NDY6MjUgcDMtMTMzNyBpd2RbNzI4MV06IFtESENQdjRdIGRoY3BfY2xpZW50X3QxX2V4cGlyZWQ6
NjI4IEVudGVyaW5nIDxicj4KJmd0OyBzdGF0ZTogREhDUF9TVEFURV9SRU5FV0lORzxicj4KJmd0
OyBKdW4gMjggMTQ6NDY6MjUgcDMtMTMzNyBpd2RbNzI4MV06IFtESENQdjRdIGRoY3BfY2xpZW50
X3NlbmRfcmVxdWVzdDozOTQ8YnI+CiZndDsgSnVuIDI4IDE0OjQ2OjI1IHAzLTEzMzcgaXdkWzcy
ODFdOiBbREhDUHY0XSBkaGNwX2NsaWVudF90MV9leHBpcmVkOjYzMyBTZW5kaW5nIDxicj4KJmd0
OyByZXF1ZXN0IGZhaWxlZDogU29ja2V0IG9wZXJhdGlvbiBvbiBub24tc29ja2V0PGJyPgo8YnI+
ClRoaXMgaW1wbGllcyB0aGF0IHRoZSBzb2NrZXQgdXNlZCBmb3IgdGhlIHVuaWNhc3Qgd2FzbiYj
Mzk7dCBvcGVuZWQgcHJvcGVybHkuPGJyPgo8YnI+ClRyeSBzdHJhY2luZyAvIGxvZ2dpbmcgd2hh
dCBoYXBwZW5zIGluIF9kaGNwX2RlZmF1bHRfdHJhbnNwb3J0X2JpbmQoKS7CoCBNYXliZSA8YnI+
Cm9uZSBvZiB0aGUgc29ja29wdHMgd2UgdHJ5IHRvIHNldCBvbiB0aGUgc29ja2V0IGlzIG5vdCBh
dmFpbGFibGU/PGJyPgo8YnI+CiZndDsgSnVuIDI4IDE0OjQ2OjI1IHAzLTEzMzcgaXdkWzcyODFd
OiBbREhDUHY0XSBkaGNwX2NsaWVudF9zZW5kX3JlbGVhc2U6NDg3PGJyPgomZ3Q7IEp1biAyOCAx
NDo0NjoyNSBwMy0xMzM3IGl3ZFs3MjgxXTogW0RIQ1B2NF0gbF9kaGNwX2NsaWVudF9zdG9wOjEx
OTkgRW50ZXJpbmcgPGJyPgomZ3Q7IHN0YXRlOiBESENQX1NUQVRFX0lOSVQ8YnI+CiZndDsgPGJy
PgomZ3Q7IERvZXMgYW55b25lIGtub3cgd2hhdCBtaWdodCBiZSBjYXVzaW5nIHRoaXM/IEkmIzM5
O20gc3RpbGwgbGVhcm5pbmcgdGhlIGNvZGUgYmFzZSA8YnI+CiZndDsgYnV0IEkgZG9uJiMzOTt0
IHNlZSBhbnl0aGluZyBvYnZpb3VzwqB3cm9uZyAoYW5kIEkgY2FuJiMzOTt0IGJlIHN1cmUgdGhp
cyBpc24mIzM5O3QgYSBwcm9ibGVtIDxicj4KJmd0OyB3aXRoIG15IHN5c3RlbSkuPGJyPgomZ3Q7
IFRoaXMgaXMgd2l0aCB0aGUgbGF0ZXN0IG1hc3RlciBidWlsZCBvZiBib3RoIGl3ZCBhbmQgZWxs
Ljxicj4KJmd0OyA8YnI+CiZndDsgPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj4K

--===============1698707172854453112==--

