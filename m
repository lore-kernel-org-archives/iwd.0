Content-Type: multipart/mixed; boundary="===============5025689428646729387=="
MIME-Version: 1.0
From: Bruce Johnson <waterfordtrack@gmail.com>
Subject: "Multiple sessions detected" during WSC connection
Date: Wed, 04 Nov 2020 16:29:25 -0500
Message-ID: <CAPucfFxvCc3BMd8pfti=MN0eS1rorqWbrbTHDhUig51hkPMqzw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5025689428646729387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I received the error "Multiple sessions detected" from iwctl after running
"iwctl wsc wlan0 push-button". The same Wi-Fi card was working with WSC on
the same Wi-Fi router when I tried it a week or so ago, and I have since
reformatted the disk of the computer with the Wi-Fi client station. After
looking at the source of wsc.c, I believe I have bumped into something the
code doesn't anticipate correctly in the case of a mesh Wi-Fi installation.

I was trying to pair a Qualcomm Atheros QCA986x/988x with an Amplifi HD
Wi-Fi router that has an Amplifi mesh extender. Both units are running with
SSID "topcog" on 2.4 GHz and 5 GHz, and they each have an additional SSID,
"topcog_5ghz". It looks like iwd gave the pairing a thumbs-down because it
was getting the same offer from two different BSSIDs for SSID "topcog" in
the 5 GHz band. When I unplugged the extender and tried the pairing again,
it succeeded.

I've attached the relevant journal entries with debug turned on. If I can
do additional testing, please let me know. I'm not doing dev work on iwd,
but since I'm building my project using OpenEmbedded, it shouldn't be too
hard for me to stick in some debug code.

The source shows that I'm building with release 1.6 (git hash ad97f4f9).

Thanks!
--
Bruce A. Johnson
Herndon, Virginia

--===============5025689428646729387==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIHJlY2VpdmVkIHRoZSBlcnJvciAmcXVvdDtNdWx0aXBsZSBz
ZXNzaW9ucyBkZXRlY3RlZCZxdW90OyBmcm9tIGl3Y3RsIGFmdGVyIHJ1bm5pbmcgJnF1b3Q7aXdj
dGwgd3NjIHdsYW4wIHB1c2gtYnV0dG9uJnF1b3Q7LiBUaGUgc2FtZSBXaS1GaSBjYXJkIHdhcyB3
b3JraW5nIHdpdGggV1NDIG9uIHRoZSBzYW1lIFdpLUZpIHJvdXRlciB3aGVuIEkgdHJpZWQgaXQg
YSB3ZWVrIG9yIHNvIGFnbywgYW5kIEkgaGF2ZSBzaW5jZSByZWZvcm1hdHRlZCB0aGUgZGlzayBv
ZiB0aGUgY29tcHV0ZXIgd2l0aCB0aGUgV2ktRmkgY2xpZW50IHN0YXRpb24uIEFmdGVyIGxvb2tp
bmcgYXQgdGhlIHNvdXJjZSBvZiB3c2MuYywgSSBiZWxpZXZlIEkgaGF2ZSBidW1wZWQgaW50byBz
b21ldGhpbmcgdGhlIGNvZGUgZG9lc24mIzM5O3QgYW50aWNpcGF0ZSBjb3JyZWN0bHkgaW4gdGhl
IGNhc2Ugb2YgYSBtZXNoIFdpLUZpIGluc3RhbGxhdGlvbi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2Pkkgd2FzIHRyeWluZyB0byBwYWlyIGEgUXVhbGNvbW0gQXRoZXJvcyBRQ0E5ODZ4Lzk4OHgg
d2l0aCBhbiBBbXBsaWZpIEhEIFdpLUZpIHJvdXRlciB0aGF0IGhhcyBhbiBBbXBsaWZpIG1lc2gg
ZXh0ZW5kZXIuIEJvdGggdW5pdHMgYXJlIHJ1bm5pbmcgd2l0aCBTU0lEICZxdW90O3RvcGNvZyZx
dW90OyBvbiAyLjQgR0h6IGFuZCA1IEdIeiwgYW5kIHRoZXkgZWFjaCBoYXZlIGFuIGFkZGl0aW9u
YWwgU1NJRCwgJnF1b3Q7dG9wY29nXzVnaHomcXVvdDsuIEl0IGxvb2tzIGxpa2UgaXdkIGdhdmUg
dGhlIHBhaXJpbmcgYSB0aHVtYnMtZG93biBiZWNhdXNlIGl0IHdhcyBnZXR0aW5nIHRoZSBzYW1l
IG9mZmVyIGZyb20gdHdvIGRpZmZlcmVudCBCU1NJRHMgZm9yIFNTSUQgJnF1b3Q7dG9wY29nJnF1
b3Q7IGluIHRoZSA1IEdIeiBiYW5kLiBXaGVuIEkgdW5wbHVnZ2VkIHRoZSBleHRlbmRlciBhbmQg
dHJpZWQgdGhlIHBhaXJpbmcgYWdhaW4sIGl0IHN1Y2NlZWRlZC48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkkmIzM5O3ZlIGF0dGFjaGVkIHRoZSByZWxldmFudCBqb3VybmFsIGVudHJpZXMgd2l0
aCBkZWJ1ZyB0dXJuZWQgb24uIElmIEkgY2FuIGRvIGFkZGl0aW9uYWwgdGVzdGluZywgcGxlYXNl
IGxldCBtZSBrbm93LiBJJiMzOTttIG5vdCBkb2luZyBkZXYgd29yayBvbiBpd2QsIGJ1dCBzaW5j
ZSBJJiMzOTttIGJ1aWxkaW5nIG15IHByb2plY3QgdXNpbmcgT3BlbkVtYmVkZGVkLCBpdCBzaG91
bGRuJiMzOTt0IGJlIHRvbyBoYXJkIGZvciBtZSB0byBzdGljayBpbiBzb21lIGRlYnVnIGNvZGUu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgc291cmNlIHNob3dzIHRoYXQgSSYjMzk7bSBi
dWlsZGluZyB3aXRoIHJlbGVhc2UgMS42IChnaXQgaGFzaCBhZDk3ZjRmOSkuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGFua3MhPC9kaXY+PGRpdj48ZGl2PjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYg
ZGlyPSJsdHIiPi0tPGRpdj5CcnVjZSBBLiBKb2huc29uPC9kaXY+PGRpdj5IZXJuZG9uLCBWaXJn
aW5pYTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2Pgo=

--===============5025689428646729387==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="iwd.log.gz"

H4sICJUVo18AA2l3ZC5sb2cA7Zjfa9swEMff91fcWxNoE/+Qf0QPg8FgDEYfmr2NIhT54oo6livJ
Sbe/fue4v9aWFq9NYekIxNbZ3Ff30d3Z8rFZQ8AgCngU8iiAC1y1l3l6lDLQm+JHnrNTDpPJtNR+
6qyayhJrP1F8exQWS+082tEYtga4NoCSVYXFh+PXdc/DSZhCI/0Z9LdO8xkbLLJxiiToXzStOxOL
1ntTj8aD/Tgla3LUHURtvF7+pInOaQTbkVbSa1PDd6vLkpB0V0Zx/DIdixctOi987xSLF877EX/w
SXm9Ruiuw40dlsbCpsA13AceDhJs0GpTaCW8XqFpPek9aucPdOLXWpBj3PTWE3Rt5d0oZvchPq9V
oycYpNafiErX57eiuO7SlXKV5Ei4LvASwvxvAyrRi21QXVUtpDonhQe2F9FqpHUoFs4JXdNCr7ag
BFa4ojgcyX0zsuAQTKMk+R/FzqJ4G+eFqfGu42482GnfRO80UHHVT/qSGgMtAxwg47OEp8hZwrOI
S3UAG03dez7/+pnDQtb0A9dU2h/CknoRh4jF2U4mc/SR7uIwqnU1PqRiZCzNGAuyOAtmSRKm4fB+
M5RBzKMZX+IfDLxpjnoOtwTCaL8ILJHPllxFvEg6CKy4T0CZUiTl2a9rBEmYB3uGQF4hiHMeRJzJ
94cAo6eyYH/jvsn+R5d+j+MOnk/5t4o+uGSzPJMBAYiHv4Y9KzSndwzlsTjZblikpfBsu6tn6k0r
eW91lL7TOnqyb759HWU5/ut1lHwhKee6zaBZo61kA2itsbvacT74BPAbCnsJJHcRAAA=
--===============5025689428646729387==--

