Content-Type: multipart/mixed; boundary="===============0481480862693788384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: IWD is running as AP with the build-in DHCP but android phones
 report no internet connection and switch back to WiFi home network
Date: Fri, 05 Nov 2021 10:35:07 -0500
Message-ID: <b29d30cd-7e96-3bed-4555-e79373f2dda9@gmail.com>
In-Reply-To: 20211105151439.2830.39111@ml01.vlan13.01.org

--===============0481480862693788384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 11/5/21 10:14 AM, salahaldeen.altous(a)leica-camera.com wrote:
> Hi,
> I have a stand alone device (without internet access) using iwd in Access=
 point mode but some android phones connected to this device show no intern=
et connection and switch back to WiFi home network.

Interesting.  Not sure why they would do that if the user explicitly select=
ed to =

connect to your device...

> With different  dhcp-server (dnsmasq) this problem have been solved by dr=
oping defaultroute in answered DHCP requests. How I can solve no internet c=
onnection with iwd and the built-in DHCP server.

I suppose we could use the same approach.  Could you try the attached patch=
 and =

see if this helps.

Regards,
-Denis

--===============0481480862693788384==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-dhcp-server-Omit-OPTION_ROUTER-if-not-configured.patch"

RnJvbSAyZjExNGI4NGQzZTk5MGYyZDExNjRjZDIyNTk1NTZiYmJjZDBjMmVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCA1IE5vdiAyMDIxIDEwOjI4OjMyIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gZGhjcC1z
ZXJ2ZXI6IE9taXQgT1BUSU9OX1JPVVRFUiBpZiBub3QgY29uZmlndXJlZAoKSW5zdGVhZCBvZiBh
c3N1bWluZyB0aGF0IE9QVElPTl9ST1VURVIgc2hvdWxkIGFsd2F5cyBiZSBzZW50LCBhbmQKc2V0
dGluZyBpdCB0byB0aGUgZGhjcCBzZXJ2ZXIncyBJUCBhZGRyZXNzLCBvbWl0IGl0IGVudGlyZWx5
IGlmIHRoZQpnYXRld2F5IHdhcyBub3QgcHJvdmlkZWQgKGkuZS4gbF9kaGNwX3NlcnZlcl9zZXRf
Z2F0ZXdheSB3YXMgbm90CmNhbGxlZC4pCi0tLQogZWxsL2RoY3Atc2VydmVyLmMgfCA0IC0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2VsbC9kaGNwLXNl
cnZlci5jIGIvZWxsL2RoY3Atc2VydmVyLmMKaW5kZXggOWMwNjI4YTZjMzBlLi5jOGIwNmE2ZWY0
MDkgMTAwNjQ0Ci0tLSBhL2VsbC9kaGNwLXNlcnZlci5jCisrKyBiL2VsbC9kaGNwLXNlcnZlci5j
CkBAIC0xMDMyLDEwICsxMDMyLDYgQEAgTElCX0VYUE9SVCBib29sIGxfZGhjcF9zZXJ2ZXJfc3Rh
cnQoc3RydWN0IGxfZGhjcF9zZXJ2ZXIgKnNlcnZlcikKIAkJc2VydmVyLT5hZGRyZXNzID0gaWEu
c19hZGRyOwogCX0KIAotCS8qIEFzc2lnbiBhIGRlZmF1bHQgZ2F0ZXdheSBpZiBub3QgYWxyZWFk
eSBzZXQgKi8KLQlpZiAoIXNlcnZlci0+Z2F0ZXdheSkKLQkJc2VydmVyLT5nYXRld2F5ID0gc2Vy
dmVyLT5hZGRyZXNzOwotCiAJLyogQXNzaWduIGEgZGVmYXVsdCBuZXRtYXNrIGlmIG5vdCBhbHJl
YWR5ICovCiAJaWYgKCFzZXJ2ZXItPm5ldG1hc2spIHsKIAkJaWYgKGluZXRfcHRvbihBRl9JTkVU
LCIyNTUuMjU1LjI1NS4wIiwgJmlhKSAhPSAxKQotLSAKMi4yNi4zCgo=

--===============0481480862693788384==--

