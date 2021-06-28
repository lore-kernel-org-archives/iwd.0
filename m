Content-Type: multipart/mixed; boundary="===============7901723546941271634=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: DHCP renewal
Date: Mon, 28 Jun 2021 18:08:34 +0100
Message-ID: <CACsRnHX=ThO+5zbScLLDdwJB8WOEEtkMdA1LmZsh8TttZZsw9w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7901723546941271634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm having a problem with the DHCP component of iwd whereby I have it
sending the initial request and getting the IP fine but when it comes time
for renewal (in my case after 1 hour) then there is an error and the DHCP
lease is left to expire. Turning on the IWD_DHCP_DEBUG flag I get this
output:

Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:626
Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:628
Entering state: DHCP_STATE_RENEWING
Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_request:394
Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:633
Sending request failed: Socket operation on non-socket
Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_release:487
Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] l_dhcp_client_stop:1199
Entering state: DHCP_STATE_INIT

Does anyone know what might be causing this? I'm still learning the code
base but I don't see anything obvious wrong (and I can't be sure this isn't
a problem with my system).
This is with the latest master build of both iwd and ell.


Michael

--===============7901723546941271634==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBoYXZpbmcg
YSBwcm9ibGVtIHdpdGggdGhlIERIQ1AgY29tcG9uZW50wqBvZiBpd2Qgd2hlcmVieSBJIGhhdmUg
aXQgc2VuZGluZyB0aGUgaW5pdGlhbCByZXF1ZXN0IGFuZCBnZXR0aW5nIHRoZSBJUCBmaW5lIGJ1
dCB3aGVuIGl0IGNvbWVzIHRpbWUgZm9yIHJlbmV3YWwgKGluIG15IGNhc2UgYWZ0ZXIgMSBob3Vy
KSB0aGVuIHRoZXJlIGlzIGFuIGVycm9yIGFuZCB0aGUgREhDUCBsZWFzZSBpcyBsZWZ0IHRvIGV4
cGlyZS4gVHVybmluZyBvbiB0aGUgSVdEX0RIQ1BfREVCVUcgZmxhZyBJIGdldCB0aGlzIG91dHB1
dDo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkp1biAyOCAxNDo0NjoyNSBwMy0xMzM3IGl3ZFs3
MjgxXTogW0RIQ1B2NF0gZGhjcF9jbGllbnRfdDFfZXhwaXJlZDo2MjY8YnI+SnVuIDI4IDE0OjQ2
OjI1IHAzLTEzMzcgaXdkWzcyODFdOiBbREhDUHY0XSBkaGNwX2NsaWVudF90MV9leHBpcmVkOjYy
OCBFbnRlcmluZyBzdGF0ZTogREhDUF9TVEFURV9SRU5FV0lORzxicj5KdW4gMjggMTQ6NDY6MjUg
cDMtMTMzNyBpd2RbNzI4MV06IFtESENQdjRdIGRoY3BfY2xpZW50X3NlbmRfcmVxdWVzdDozOTQ8
YnI+SnVuIDI4IDE0OjQ2OjI1IHAzLTEzMzcgaXdkWzcyODFdOiBbREhDUHY0XSBkaGNwX2NsaWVu
dF90MV9leHBpcmVkOjYzMyBTZW5kaW5nIHJlcXVlc3QgZmFpbGVkOiBTb2NrZXQgb3BlcmF0aW9u
IG9uIG5vbi1zb2NrZXQ8YnI+SnVuIDI4IDE0OjQ2OjI1IHAzLTEzMzcgaXdkWzcyODFdOiBbREhD
UHY0XSBkaGNwX2NsaWVudF9zZW5kX3JlbGVhc2U6NDg3PGJyPkp1biAyOCAxNDo0NjoyNSBwMy0x
MzM3IGl3ZFs3MjgxXTogW0RIQ1B2NF0gbF9kaGNwX2NsaWVudF9zdG9wOjExOTkgRW50ZXJpbmcg
c3RhdGU6IERIQ1BfU1RBVEVfSU5JVDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRvZXMg
YW55b25lIGtub3cgd2hhdCBtaWdodCBiZSBjYXVzaW5nIHRoaXM/IEkmIzM5O20gc3RpbGwgbGVh
cm5pbmcgdGhlIGNvZGUgYmFzZSBidXQgSSBkb24mIzM5O3Qgc2VlIGFueXRoaW5nIG9idmlvdXPC
oHdyb25nIChhbmQgSSBjYW4mIzM5O3QgYmUgc3VyZSB0aGlzIGlzbiYjMzk7dCBhIHByb2JsZW0g
d2l0aCBteSBzeXN0ZW0pLsKgPC9kaXY+PGRpdj5UaGlzIGlzIHdpdGggdGhlIGxhdGVzdCBtYXN0
ZXIgYnVpbGQgb2YgYm90aCBpd2QgYW5kIGVsbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pk1pY2hhZWw8YnI+PC9kaXY+PC9kaXY+Cg==

--===============7901723546941271634==--

